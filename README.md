# Dotfiles

Mirror-of-home layout: configs live here and are **symlinked** into `~` / `~/.config`.

## Stack

| Area | Tool | Location |
| ---- | ---- | -------- |
| Shell | fish + Starship | `.config/fish/`, `.config/starship.toml` |
| Runtimes | mise | `.config/mise/config.toml` |
| Editor | Neovim (LazyVim) | `.config/nvim/` |
| VCS | git (SSH-signed commits) | `.gitconfig` |
| Terminal | iTerm2 | profile settings in the app |
| Keyboard | ZSA Moonlander | hardware layout in Oryx |
| GitHub | gh | `.config/gh/` |
| AI skills | Cursor / Claude / Codex | `skills/` |
| Launcher | Raycast | `raycast/quicklinks.json` |
| Multiplexer | zellij | `.config/zellij/` |

## Layout

```
dotfiles/
├── setup.sh
├── .gitconfig               # → ~/.gitconfig
├── .zshrc                   # → ~/.zshrc (non-fish fallback)
├── skills/{shared,cursor,claude,codex}/
├── raycast/quicklinks.json
└── .config/
    ├── fish/                # config.fish + fish_plugins
    ├── mise/config.toml
    ├── starship.toml
    ├── nvim/
    ├── zellij/
    └── gh/config.yml
```

## Setup

```bash
git clone https://github.com/michaelmoschitto/dotfiles.git ~/projects/dotfiles
bash ~/projects/dotfiles/setup.sh
```

`setup.sh` installs core brew packages, creates an SSH key and loads it into
Keychain, sets fish as the login shell, symlinks this repo into place, runs
fisher, and launches nvim once.

Then:

1. Add `~/.ssh/id_ed25519.pub` on GitHub as an **Authentication** key and a
   **Signing** key ([SSH keys](https://github.com/settings/ssh/new)).
2. iTerm → Profiles → Text → **FiraCode Nerd Font**.
3. iTerm → Profiles → Keys → Left/Right Option → **Esc+**.
4. Open a new Cursor terminal tab (defaults to fish).

Runtimes and extras as needed:

```bash
mise use -g bun@latest
brew install zellij
```

Raycast Quicklinks: **Export Quicklinks** into `raycast/quicklinks.json`, or
**Import Quicklinks** from that file on a new machine.

## Notes

### Fish

Tracked files: `config.fish` and `fish_plugins`. Fisher installs the rest
(`fisher update`).

| Abbreviation | Expands to |
| ------------ | ---------- |
| `cd` | `z` (zoxide) |
| `ls` / `ll` | `eza` |
| `cat` | `bat` |
| `vim` | `nvim` |
| `grep` | `rg` |
| `top` / `du` | `btm` / `dust` |

Also loaded: fzf.fish and plugin-git (`g…` git abbreviations).

### mise

Activated from fish. Global tool versions are in `.config/mise/config.toml`.
`mise use -g <tool>@<ver>` updates that file.

### Git

Commits are signed with SSH (`gpg.format = ssh`). The signing key passphrase is
stored in the macOS Keychain via `ssh-add --apple-use-keychain`.

### Neovim

LazyVim with snacks picker, neo-tree, dial, Harpoon, multicursor, Claude Code,
octo, neotest, and language support for Go, Rust, Python, TypeScript, SQL,
JSON, YAML, and Markdown.

| Keys | Action |
| ---- | ------ |
| `Space Space` | Find files |
| `Space e` | File tree |
| `Space /` | Grep project |
| `Space B` / `Space 1..9` | Harpoon add / jump |
| `Space` | which-key menu |

### Skills

`skills/shared/` is symlinked into Cursor, Claude, and Codex. Tool-specific
skills live under `skills/{cursor,claude,codex}/`.

### Raycast

Quicklinks are stored as JSON in `raycast/`. See [`raycast/README.md`](raycast/README.md).

## Updating

```bash
cd ~/projects/dotfiles
git add -A && git commit -m "Update <tool>" && git push
fisher update
nvim +"Lazy sync" +qa
```

## Not tracked

Fisher-installed fish files, Neovim plugin data (`~/.local/share/nvim/`),
Zellij backups, Raycast `.rayconfig` / tokens, Claude/Codex/Cursor app state,
and secrets (gh uses the system Keychain).
