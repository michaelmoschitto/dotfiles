starship init fish | source

# Runtimes (node, bun, …) — single source of truth via mise
if type -q mise
    mise activate fish | source
end

# Docker Desktop CLI (was previously only in ~/.zprofile)
fish_add_path ~/.docker/bin

if status is-interactive
    zoxide init fish | source
end

abbr -a -- vim nvim
abbr -a -- ls eza
abbr -a -- cat bat
abbr -a -- cd z
abbr -a -- grep rg
abbr -a -- top btm
abbr -a -- du dust
abbr -a -- m 'git checkout main; and git pull --rebase origin main'
alias ll='eza -lbG --git'

set -gx FX_THEME 2
