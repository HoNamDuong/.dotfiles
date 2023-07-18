# Dual boot Arch linux and Window 10

## Pre-installation checks

Change console font

    setfont ter-132n
    setfont iso01-12x22
    setfont drdos8x16

The current set up assumes you have EFI-enabled BIOS.
Once booted from a CD or USB stick, verify that the installation supports EFI.

    ls -la /sys/firmware/efi

As you begin the installation, you might want to ensure that you have internet connectivity.
Internet connectivity is crucial in setting time and date.

    ping 8.8.8.8 -c 4

## Update time and date

Update the system time and date using the `timedatectl` command

    timedatectl set-ntp true

Confirm the time and date using the command

    timedatectl status

## Create, format and mount Linux partitions

In order to install a Linux system we need two main partitions:

- Boot (mounted on `/mnt/boot/efi`) - contains bootloader (we have already created this in Windows setup)
- Root (mounted on `/mnt`) - the Linux root (`/`) where everything is installed

Run 'lsblk' to list the drives and partitions with their mountpoints, size and other information

    # Example:
    NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
    nvme0n1     259:0    0 119.2G  0 disk
    ├─nvme0n1p1 259:1    0   100M  0 part
    ├─nvme0n1p2 259:2    0    16M  0 part
    ├─nvme0n1p3 259:3    0  88.6G  0 part
    └─nvme0n1p4 259:4    0   559M  0 part

Here, I have a drive named `nvme0n1`, and then some partition names followed by it. You may have `sda` or something else as the drive name. The partitions are as follows:

- nvme01np1 - Boot partition
- nvme0n1p2 - Microsoft reserved
- nvme0n1p3 - Primary Windows Parittion (C: drive)
- nvme0n1p4 - Windows recovery environment

Remember the boot partition name (`nvme0n1p1` in my case).

We don't see the unallocated space we left for Arch because we haven't created a partition from the unallocated space yet.
To do that type in:

    cfdisk /dev/nvme0n1

Create a new partition with the remaining space with type `Linux filesystem`.
After you are done partitioning select the `Write` button and write the changes to disk and `Quit` cfdisk.
Now the partition should be listed when you run `lsblk` again.

After creating the root partition, we need to format it with a filesystem type -- I'll make it an ext4 partition.
Run `mkfs.ext4` to format the partition with the ext4 filesystem:

    mkfs.ext4 /dev/nvme0n1p5

Mount the root partition (replace `nvme0n1p6` with your root partition) to `/mnt`

    mount /dev/nvme0n1p5 /mnt

Mount the boot partition (the one we created in windows, `nvme0n1p1` in my case)

    mkdir -p /mnt/boot/efi
    mount /dev/nvme0n1p1 /mnt/boot/efi

## Installation kernel

### Mirrors

Synchronize the package databases and update the keyring (sometimes keyring can be a issue if the archiso is very old):

    pacman -Sy archlinux-keyring

Arch linux packages are installed from mirrors defined in `/etc/pacman.d/mirrorlist`, if the download speed in the above command was slow, it could be an issue related to the mirrors.
We can fix that by updating the mirrors, which you can do either manually or using `reflector` to automatically update the mirrors.

Install reflector with pacman:

    pacman -Sy reflector

Backup the default mirrolist:

    cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

Get the latest 6 mirrors sorted by speed and save using reflector:

    reflector --latest 6 --sort rate --download-timeout 100 --save /etc/pacman.d/mirrorlist

You can also add the `-c <Country>` flag if you want to, which will only select mirrors from .

### Base Install

Use the pacstrap script to install the `base` and `linux` packages

    pacstrap /mnt base base-devel linux linux-firmware intel-ucode neovim

The above command installs the base group, linux and linux firmware, packages necessary for building and development (base-devel) and neovim (CLI text editor) on the system.

## Generate fstab file

Fstab (filesystem table) located in `/etc/fstab` is a file that keeps track of all the partitions that a distro requires to boot along with their mountpoints.
Generate the fstab file from /mnt and append into /mnt/etc/fstab:

    genfstab -U /mnt >> /mnt/etc/fstab

## Chroot and other configuration

After installing the `base` group and generating the fstab, we will `chroot` into the Arch installation and configure some other things like the locale, timezone and hostname.

    arch-chroot /mnt

### Update timezone

Find your region and city:

    ls /usr/share/zoneinfo

Update timezone (replace Region/City with your timezone):

    ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime

Sync system clock to hardware clock:

    hwclock —-systohc --utc --localtime

### Set language, location and hostname

The locale determines the system language, currency format, numbering and date on your system.
This information is contained in the `/etc/locale.gen` file.

    nvim /etc/locale.gen

    # Scroll and uncomment
    en_US.UTF-8 UTF-8

Save and exit the file. Next generate the locale configuration using the command:

    locale-gen

Set teh `LANG` variable in the `locale.conf` file:

    echo "LANG=en_US.UTF-8" >> /etc/locale.conf

`hostname` is a unique name to identify a machine on a network.
Create `hostname` file and add a hostname:

    echo yourhostname > /etc/hostname

After, create host file:

    touch /etc/hosts

Add this content to the file and save:

    127.0.0.1   localhost
    ::1         localhost
    127.0.1.1   yourhostname.localdomain    yourhostname

Give root user a password:

    passwd

## Create a regular user (with superuser)

Create user with wheel gropu (replace username with name)

    useradd -mG wheel username

Give a password to user:

    passwd username

Add sudo access to the user.

    EDITOR=nvim visudo

    # Uncomment:
    %wheel ALL=(ALL) ALL

## Install Grub Bootloader

`grub` bootloader package alongside the efi boot manager package since we are using the UEFI mode.

`os-prober` package which will enable Arch Linux to detect the Windows operating system.

`efibootmgr` is a userspace application used to modify the UEFI Boot Manager.

    pacman -S grub efibootmgr os-prober

Mount the boot partition (the one we created in windows, `nvme0n1p1` in my case)

    mkdir -p /boot/efi
    mount /dev/nvme0n1p1 /boot/efi

    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --recheck --debug

This installs the grub on /boot which is mounted on `nvme0n1p1`, our boot partition

Grub generate config:

    grub-mkconfig -o /boot/grub/grub.cfg

Here grub will generate the config and write it to grub.cfg. Make sure Linux and Windows both are detected here.

## Install NetworkManager and enable

    pacman -S networkmanager
    systemctl enable NetworkManager.service

## Exit and reboot

    exit
    umount -R /mnt
    shutdown -r now

## Enable the NTP service (Network Time Synchronization)

    sudo timedatectl set-ntp true
    timedatectl status

## Set Windows startup default

Login root user. By default, `os-prober` is disabled in the grub config, hence it won't detect Windows.
When generating config in next step, you'll get a warning saying `os-prober` is disabled.

    nvim /etc/default/grub

    # Change
    GRUB_DEFAULT=saved
    # Uncomment
    GRUB_DISABLE_OS_PROBER=false

    mount /dev/nvme0n1p1 /boot/efi

    grub-set-default 2

    grub-mkconfig -o /boot/grub/grub.cfg
