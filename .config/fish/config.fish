starship init fish | source

if status is-interactive
    zoxide init fish | source

    # mise: language/runtime version manager
    if type -q mise
        mise activate fish | source
    end
end

abbr -a -- vim nvim
abbr -a -- ls eza
abbr -a -- cat bat
abbr -a -- cd z
abbr -a -- grep rg
abbr -a -- top btm
abbr -a -- du dust
alias ll='eza -lbG --git'

set -gx FX_THEME 2
