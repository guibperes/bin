if status is-interactive
    # Commands to run in interactive sessions can go here
    # Starship prompt
    starship init fish | source

    # Mise
    mise activate fish | source
end

# .bin directory scripts
fish_add_path $HOME/.akira/bin

# Remove greeting message
set -g fish_greeting

# Aliases
alias l="la"
alias spotify="spotify_player"
alias calendar="calcure"
alias tt="taskwarrior-tui"
