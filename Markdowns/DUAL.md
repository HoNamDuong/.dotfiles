## Dual boot Arch linux and Window 10

### Change console font

    setfont ter-132n
    setfont iso01-12x22

### Kiểm tra máy có phải ở chế độ UEFI hay không

    ls /sys/firmware/efi/efivars

Nếu hiện ra một số thư mục hoặc file thì máy đang ở chế dộ UEFI

### Kiểm tra kết nối mạng

    ping 8.8.8.8 -c 4

### Bật giao thức thời gian mạng (NTP)

Bạn cần bật giao thức NTP và cho phép hệ thống cập nhật thời gian thông qua internet bằng lệnh sau:

    timedatectl set-ntp true

Để kiểm tra trạng thái của NTP, dùng lệnh:

    timedatectl status

### Phần vùng ổ đĩa

Kiểm tra các phân vùng và tìm phần vùng trống

    lsblk

Phần vùng ổ đĩa bằng lệnh cfdisk

    cfdisk /dev/sdX

Trong đó, X là tên drive của ổ đĩa mà bạn muốn phân vùng

Cần phải xác định các phân vùng của mình có tên là gì bằng câu lệnh blkid thường thì nó sẽ có dạng /dev/sd[X][y], trong đó X sẽ là a và b tương ứng với ổ đĩa 1 (SSD) và ổ đĩa 2 (HDD) của máy mình. Còn Y sẽ là số thứ tự phân vùng. Vì đang dual với window nên sử dụng chung phân vùng EFI

- EFI : /dev/sda1 EFI system
- root : /dev/sda5 Linux filesystem

Xác nhận các thay đổi trên ổ đĩa bằng cách chọn Write ở phía dưới màn hình. Nhập yes rồi nhấn Enter.

Chọn Quit rồi nhấn Enter để thoát khỏi màn hình cfdisk.

Kiểm tra lại các phân vùng với lsblk

### Format and mount phân vùng

Tiến hành format phân vùng root sau đó mount để tiến hành cài đặt:

    mkfs.ext4 /dev/sda5
    mount /dev/sda5 /mnt

Kiểm tra lại các phân vùng với lsblk

### Cài đặt kernel

Synchronize the package databases and update the keyring (sometimes keyring can be a issue if the archiso is very old):

    pacman -Sy archlinux-keyring

Arch linux packages are installed from mirrors defined in /etc/pacman.d/mirrorlist, if the download speed in the above command was slow, it could be an issue related to the mirrors.
We can fix that by updating the mirrors, which you can do either manually or using reflector to automatically update the mirrors.

Install reflector with pacman:

    pacman -Sy reflector

Backup the default mirrolist:

    cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

Get the latest 6 mirrors sorted by speed and save using reflector:

    reflector --latest 6 --sort rate --download-timeout 100 --save /etc/pacman.d/mirrorlist

You can also add the -c <Country> flag if you want to, which will only select mirrors from .

Dùng script pacstrap để cài đặt Arch Linux vào phân vùng có thể boot:

    pacstrap /mnt base base-devel linux linux-firmware intel-ucode neovim

Tùy vào tốc độ download của bạn, quá trình cài đặt có thể mất khá nhiều thời gian.

### Tạo file fstab

Sau khi cài đặt xong Arch Linux, bạn cần cấu hình các cài đặt như các phần hướng dẫn dưới đây.

File fstab định nghĩa thứ tự mount các phân vùng ổ đĩa, thiết bị block, thiết bị từ xa và các nguồn dữ liệu khác. Tạo file fstab bằng lệnh sau:

    genfstab -U /mnt >> /mnt/etc/fstab

### Sử dụng Arch-Chroot

Thay đổi root sang hệ thống Arch mới đặt cài đặt bằng lệnh arch-chroot như sau:

    arch-chroot /mnt

### Cài đặt thời gian

    # Xem list Zone bằng lệnh
    ls /usr/share/zoneinfo

    # link time zone Ho_Chi_Minh City vào /etc/localtime
    ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime

    # Config clock
    hwclock —-systohc —-utc

### Cài đặt ngôn ngữ và location

Mở tệp locale.gen

    nvim /etc/locale.gen
    locale-gen

Ở đây mình sẽ dùng en_US.UTF-8 nên sẽ bỏ dấu thăng ở dòng này và lưu file lại rồi chạy lệnh dưới locale-gen rồi lưu lại

Add this content to the file:

    nvim /etc/locale.conf

    LANG=en_US.UTF-8
    LANGUAGE=en_US

Add this content to the file:

    nvim /etc/vconsole.conf
    KEYMAP=us

### Cài đặt Hostname file (tên máy tính)

    echo yourhostname > /etc/hostname

Sau đó, tạo một host file:

    touch /etc/hosts

Thêm nội dung sau vào host file vừa mới tạo và lưu lại:

    127.0.0.1   localhost
    ::1         localhost
    127.0.1.1   yourhostname.localdomain    yourhostname

### Thêm người dùng

Cài đặt một mật khẩu root mới bằng lệnh passwd:

    passwd

Tạo user và thêm group cho user

    useradd -mG wheel username

đặt mật khẩu cho user, nên tạo giống mật khẩu root

    passwd username

Sau đó, nhập password mới rồi nhập lại lần nữa để hoàn tất.

### Chỉnh sửa sudo để user có quyền root

    EDITOR=nvim visudo

Bỏ dấu # trước dòng #%wheel ALL=(ALL) ALL và lưu lại

    %wheel ALL=(ALL) ALL
    # Set thời gian nhập lại mật khẩu
    Defaults timestamp_timeout=0

### Cài đặt Grub Bootloader

Đầu tiên, thêm các GRUB bootloader package vào hệ thống bằng pacman manager
Thêm os-prober để phát hiên Window boot manager

    pacman -S grub efibootmgr os-prober

install grub EFI to EFI partition mount as /boot
And install a grub configuration file as shown.

    mkdir /boot/efi
    mount /dev/sda1 /boot/efi

    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --recheck --debug

    grub-mkconfig -o /boot/grub/grub.cfg

The last line is an indication that Arch has detected the presence of Windows Boot manager on /dev/sda1 partition. Perfect!

### Cài đặt NetworkManager và kích hoạt

    pacman -S networkmanager network-manager-applet
    systemctl enable NetworkManager.service

### Install useful linux tools

    pacman -Syu && \
    pacman -S htop git tmux wget

### Exit và Reboot Usb cài Arch

    exit
    umount -R /mnt
    shutdown -r now

### Set Window startup default

Login root user
By default, os-prober is disabled in the grub config, hence it won't detect Windows.
When generating config in next step, you'll get a warning saying os-prober is disabled.
In /etc/default/grub.

    nvim /etc/default/grub

    # change
    GRUB_DEFAULT=saved
    # uncomment
    GRUB_DISABLE_OS_PROBER=false

    mount /dev/sda1 /boot/efi

    grub-set-default 2

    grub-mkconfig -o /boot/grub/grub.cfg
