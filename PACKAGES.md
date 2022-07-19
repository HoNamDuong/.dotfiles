### Install lazygit from binary package

[Dowload lazygit](https://github.com/jesseduffield/lazygit/releases)

Create folder lazygit

    cd ~
    mkdir lazygit
    cd ~/lazygit

Install

    wget -O lazygit.tgz https://github.com/jesseduffield/lazygit/releases/download/v0.34/lazygit_0.34_Linux_x86_64.tar.gz
    tar xvf lazygit.tgz
    sudo mv lazygit /usr/local/bin/

Show version

    lazygit  -v

### Install ranger

    sudo apt install ranger

Create config file

    ranger --copy-config=all

Add into ~/.config/ranger/rifle.conf

    ext ods|xls|xlsx|csv|ics|vcf|3dm|3ds|max|bmp|dds|gif|jpg|jpeg|png|psd|xcf|tga|thm|tif|tiff|yuv|ai|eps|ps|svg|dwg|dxf|gpx|kml|kmz|webp|3g2|3gp|aaf|asf|avchd|avi|drc|flv|m2v|m4p|m4v|mkv|mng|mov|mp2|mp4|mpe|mpeg|mpg|mpv|mxf|nsv|ogg|ogv|ogm|qt|rm|rmvb|roq|srt|svi|vob|webm|wmv|yuv|aac|aiff|ape|au|flac|gsm|it|m3u|m4a|mid|mod|mp3|mpa|pls|ra|s3m|sid|wav|wma|xm|7z|a|apk|ar|bz2|cab|cpio|deb|dmg|egg|gz|iso|jar|lha|mar|pea|rar|rpm|s7z|shar|tar|tbz2|tgz|tlz|war|whl|xpi|zip|zipx|xz|pak|exe|msi|bin|command|bat|crx|c|cc|class|clj|cpp|cs|cxx|el|go|h|java|lua|m|m4|php|pl|po|py|rb|rs|swift|vb|vcxproj|xcodeproj|xml|diff|patch|html|js|html|htm|css|js|jsx|less|scss|wasm|php|ppt|odp|doc|docx|ebook|log|msg|odt|org|pages|pdf|rtf|rst|tex|txt|wpd|wps|mobi|epub|azw1|azw3|azw4|azw6|azw|cbr|cbz = wslpath -w "$@" | sed -e 's/.\*/"&"/' | xargs cmd.exe /C start ""
