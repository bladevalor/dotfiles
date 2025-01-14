set -Ux fish_greeting

function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

function ks
   exa -a $argv
end

function reload
   source ~/.config/fish/config.fish
end

fzf --fish | source
starship init fish | source
