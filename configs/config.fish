if status is-interactive
    # Commands to run in interactive sessions can go here
    # Starship prompt
    starship init fish | source

    # Mise
    mise activate fish | source
end

fish_add_path $HOME/.bin/cli
set -g fish_greeting

