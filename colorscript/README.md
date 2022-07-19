# Source [Shell Color Scripts](https://gitlab.com/dwt1/shell-color-scripts)

## Installing colorscript on Linux distributions

Download the source code from this repository or use a git clone:

    # Install
    cd ~/.dotfiles/colorscript
    sudo make install

    # Removal
    sudo make uninstall

    # Optional for zsh completion
    sudo cp completions/_colorscript /usr/share/zsh/vendor-completions

    # Remove zsh completion
    sudo rm /usr/share/zsh/vendor-completions/_colorscript

## Usage

    colorscript --help
    Description: A collection of terminal color scripts.

    Usage: colorscript [OPTION] [SCRIPT NAME/INDEX]
    -h, --help, help        	Print this help.
    -l, --list, list        	List all installed color scripts.
    -r, --random, random    	Run a random color script.
    -e, --exec, exec        	Run a specified color script by SCRIPT NAME or INDEX.
    -a, --all, all          	List the outputs of all colorscripts with their SCRIPT NAME
    -b, --blacklist, blacklist	Blacklist a color script by SCRIPT NAME or INDEX.

## The Scripts Are Located in /opt/colorscript/colorscripts

The source for colorscript is placed in:

    /opt/colorscript/colorscripts

For even more fun, add the following line to your .bashrc or .zshrc and you will run a random color script each time you open a terminal:

    # Random color script
    if [ -f /usr/local/bin/colorscript ]; then
        colorscript random
    fi
