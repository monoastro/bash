# Context
The folder for (almost) all of my bash scripts. For convenience, I've made the bash directory to be exported to PATH so the scripts can be run from anywhere. So if you want to use these scripts, you most likely have to do the same or use absolute paths where necessary.

# Broad categories that the scripts fall under

## C/C++ Development Environment
#### Scripts: c.init, cc.init, tmux-compile-run, compile-run
These scripts are the latest additions in the gcc->makefile->cmake chain, that automatically generates the CMakeLists.txt file for you, and provides functionality to compile and run your C/C++ code. The scripts are designed to be used in a Linux environment but feel free to adapt it to a Windows environment too if you want. 
Required: tmux, gcc, g++, make, cmake

#### Scripts: c.makefile.init, cc.makefile.init
The makefile scripts were what I used before I discovered cmake, and they are still useful for small projects. Like the cmake scripts, they generate the project directory and makefile with compile_commands.json with bear for clangd.
Required: gcc, g++, make, clangd, bear

#### Bindings:
tmux.conf: bind m run-shell "~/projects/bash/tmux-compile-run"

## Tmux specific scripts
#### Scripts: tmux-new-session, tmux-switch-kill

## Singular scripts

### Toggle alacritty's opacity, Scripts: toggleOpacity
This one is globally bound to run when I press ctrl+shift+a. It toggles the opacity of the alacritty terminal between a fixed set of values. I'm not gonna write my command for binding here because it's different for every window manager.
Required: alacritty
#### Bindings:
ctrl+shift+a: toggleOpacity

### CommandIn, Scripts: commandIn_vosk, commandIn_whisper
Convert audio to text for monika.

### html.init, Scripts: html.init
Generates a basic web development project directory with the index.html, css and js files.

### cht.sh, Scripts: cht.sh
A script to search for programming language documentation from the terminal. It's just a wrapper around the cht.sh API.

### ani-cli
Watch anime in the terminal

### battery.sh
KDE specific script used with crontab to send notification if it detects battery levels exceed 80%. (Li-ion and Li-po should ideally operate between the 40%-80% range) 

### pushConfigs
Script to selectively add and push my personal configs from the ocean of other non-personal configs(Apparently there's no inverse of .gitignore)

### setBrightness
Change brightness from cli if de gets nuked
