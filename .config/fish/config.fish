set -Ux fish_greeting
set -Ux SUDO_EDITOR nvim

function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

set -Ux DEEPSEEK_API_KEY sk-b73defc36a794152948038c96ae5e1ae

set -Ux CHROME_EXECUTABLE /usr/bin/google-chrome-stable
set -Ux JAVA_HOME /usr/lib/jvm/java-17-openjdk/
set -Ux ANDROID_SDK_ROOT /opt/android-sdk

function x
    xdg-open $argv
end

function ks
    exa -a $argv
end

function nv
    nvim $argv
end

function lg
    lazygit $argv
end

function xo
    xdg-open $argv
end

function reload
    source ~/.config/fish/config.fish
end

function glacier
    cd /opt/android-sdk/tools/
    emulator @glacier -netdelay none -netspeed full -gpu on -memory 4096 -cores 4 -feature KeyboardSupport
end

fzf --fish | source
zoxide init fish | source
starship init fish | source
