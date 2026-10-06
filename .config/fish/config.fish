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

# gwt mike-worktree → ../mike-worktree on new branch mike-worktree (from origin/main)
function gwt --description 'Add git worktree ../<branch> with matching branch name'
    if test (count $argv) -lt 1
        echo "usage: gwt <branch> [start-point]" >&2
        return 1
    end
    set -l branch $argv[1]
    set -l start origin/main
    if test (count $argv) -ge 2
        set start $argv[2]
    end
    set -l dir ../$branch
    git fetch origin main
    and git worktree add -b $branch $dir $start
end

set -gx FX_THEME 2
