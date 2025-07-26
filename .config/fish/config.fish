set -Ux fish_greeting
set -Ux SUDO_EDITOR nvim

function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

set -Ux DEEPSEEK_API_KEY sk-b73defc36a794152948038c96ae5e1ae

set -Ux ARDMK_DIR "/opt/Arduino-Makefile"
set -Ux ARDUINO_DIR ""
set -Ux AVR_TOOLS_DIR ""

function x
   xdg-open $argv
end

function ks
   exa -a $argv
end

function nv
   nvim $argv
end

function av
   env NVIM_APPNAME=nvim-astro nvim $argv
end

function xo
   xdg-open $argv
end

function reload
   source ~/.config/fish/config.fish
end

fzf --fish | source
zoxide init fish | source
starship init fish | source
