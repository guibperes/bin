if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Starship prompt
starship init fish | source

# Mise
mise activate fish | source

fish_add_path $HOME/.bin/cli
set -g fish_greeting

