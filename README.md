# Dotfiles

Mirror-of-home layout: configs live here and are **symlinked** into `~` / `~/.config`.

## Stack

| Area | Tool | Location |
| ---- | ---- | -------- |
| Shell | fish + Starship | `.config/fish/`, `.config/starship.toml` |
| Runtimes | mise | `.config/mise/config.toml` |
| Editor | Neovim (LazyVim) | `.config/nvim/` |
| VCS | git (SSH-signed) | `.gitconfig` |
| Terminal | iTerm2 | not tracked (see notes) |
| Keyboard | ZSA Moonlander | Oryx link (add yours below) |
| GitHub | gh | `.config/gh/` |
| AI skills | shared → Cursor/Claude/Codex | `skills/` |
| Launcher | Raycast | `raycast/quicklinks.json` |
| Multiplexer | zellij | `.config/zellij/` |

## Layout

```
dotfiles/
├── setup.sh                 # one-shot bootstrap
├── .gitconfig               # → ~/.gitconfig
├── .zshrc                   # stub only (interactive shell is fish)
├── skills/{shared,cursor,claude,codex}/
├── raycast/quicklinks.json
└── .config/
    ├── fish/                # config.fish + fish_plugins
    ├── mise/config.toml
    ├── starship.toml
    ├── nvim/                # LazyVim
    ├── zellij/
    └── gh/config.yml
```

## Setup

```bash
git clone https://github.com/michaelmoschitto/dotfiles.git ~/projects/dotfiles
bash ~/projects/dotfiles/setup.sh
```

The script installs core brew packages (including zellij), creates an SSH key + Keychain entry,
sets fish as the login shell, symlinks configs, runs fisher, and boots nvim.

**After setup**

1. Paste `~/.ssh/id_ed25519.pub` into GitHub twice: **Authentication** + **Signing**  
   (`pbcopy < ~/.ssh/id_ed25519.pub` → [SSH keys](https://github.com/settings/ssh/new))
2. iTerm → Profiles → Text → font **FiraCode Nerd Font**
3. iTerm → Profiles → Keys → Left/Right Option → **Esc+** (Alt for fish/nvim/zellij)
4. Cursor terminal is set to fish in user settings; open a new terminal tab
5. Start a multiplexer session with `zellij` (`Ctrl+s` = scroll/copy mode)

**Optional**

```bash
mise use -g bun@latest          # updates .config/mise/config.toml — commit it
# Raycast → Export Quicklinks → raycast/quicklinks.json
```

## Notes

### Fish

Lockfile-only: `config.fish` + `fish_plugins`. Fisher fills the rest (`fisher update`).

| You type | Becomes |
| -------- | ------- |
| `cd` | `z` (zoxide) |
| `ls` / `ll` | `eza` |
| `cat` | `bat` |
| `vim` | `nvim` |
| `grep` | `rg` |
| `top` / `du` | `btm` / `dust` |
| `gwt mike-worktree` | `git worktree add -b mike-worktree ../mike-worktree origin/main` |

Also: fzf.fish (Ctrl+R history, etc.) and `g…` git abbrs from plugin-git.

### mise

Activated from fish. Global versions live in `.config/mise/config.toml`.  
`mise use -g <tool>@<ver>` → commit the file.

### Git

SSH commit signing (`gpg.format = ssh`). Keychain via `ssh-add --apple-use-keychain`.  
No GPG Suite.

### Neovim

LazyVim. Extras: snacks picker, neo-tree, dial, languages (rust/python/ts/sql/… — no Go/Java), Claude Code, octo, neotest.

**Full key map:** [`.config/nvim/CHEATSHEET.md`](.config/nvim/CHEATSHEET.md) — written for vim-motions-in-Cursor → full Neovim (file tree, LSP, harpoon, multicursor, …).

| Keys | Action |
| ---- | ------ |
| `Space Space` | Find files |
| `Space e` | File tree (`z` collapse / `Z` expand all) |
| `Space /` | Grep project |
| `Space B` / `Space 1..9` | Harpoon add / jump |

Press `Space` alone for the which-key menu. Obsidian is stubbed until you set a vault path.

### Zellij

Multiplexer (panes + tabs). Config clears defaults — use **this** key map, not stock Zellij docs.

**Full key map:** [`.config/zellij/CHEATSHEET.md`](.config/zellij/CHEATSHEET.md)

| Keys | Action |
| ---- | ------ |
| `zellij` | Start session |
| `⌥+hjkl` | Move focus |
| `⌥+n` | New pane |
| `Ctrl+s` | Scroll / copy mode |
| `Ctrl+p` / `Ctrl+t` | Pane / tab mode |
| `Ctrl+q` | Quit |

### Skills & Raycast

- `skills/shared/` → symlinked into Cursor, Claude, and Codex (DRY)
- Quicklinks: edit/import `raycast/quicklinks.json` — see [`raycast/README.md`](raycast/README.md)

### Keyboard

ZSA Moonlander — add Oryx URL here when ready.

## Updating

Edits apply live through symlinks:

```bash
cd ~/projects/dotfiles
# edit…
git add -A && git commit -m "Update <tool>" && git push
fisher update                 # after fish_plugins changes
nvim +"Lazy sync" +qa         # after plugin changes
```

## Not tracked

Fisher install trees · Neovim plugin data · Zellij `*.bak` · Raycast `.rayconfig` /
tokens · Claude/Codex/Cursor app state · secrets (gh uses Keychain)
