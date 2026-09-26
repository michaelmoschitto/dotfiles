# Dotfiles

Personal configuration using the **mirror home directory pattern**: this repo
mirrors `~`, so setup is symlinking `.config/` (and a couple of root-level
files) into place.

## The stack

| Area        | Tool                         | Config location                          |
| ----------- | ---------------------------- | ---------------------------------------- |
| Shell       | **fish** + **Starship**      | `.config/fish/`, `.config/starship.toml` |
| Multiplexer | **zellij** (optional)        | `.config/zellij/config.kdl`              |
| VCS         | **git** (SSH-signed commits) | `.gitconfig`                             |
| Editor      | **Neovim** (LazyVim)         | `.config/nvim/`                          |
| Terminal    | **iTerm2**                   | Profiles in iTerm (not tracked)          |
| Keyboard    | **ZSA Moonlander**           | Oryx layout (add your URL here)          |
| Runtimes    | **mise**                     | activated from fish                      |
| GitHub CLI  | **gh**                       | `.config/gh/`                            |
| AI skills   | **shared** (Cursor/Claude/Codex) | `skills/`                            |
| Launcher    | **Raycast**                  | Encrypted export (not tracked)           |

## Structure

```
dotfiles/
├── .gitconfig                  # → ~/.gitconfig (identity + SSH signing)
├── .gitignore
├── README.md
├── skills/                     # DRY AI skills (symlinked into each agent)
│   ├── shared/                 # linked into Cursor, Claude, and Codex
│   ├── cursor/                 # Cursor-only
│   ├── claude/                 # Claude-only
│   └── codex/                  # Codex-only
└── .config/                    # → ~/.config/
    ├── fish/
    │   ├── config.fish
    │   └── fish_plugins
    ├── starship.toml
    ├── zellij/                 # optional; install zellij when you want it
    │   └── config.kdl
    ├── nvim/                   # LazyVim
    └── gh/
        └── config.yml
```

## Fresh machine setup

```bash
# 1. macOS build tools and Homebrew
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Core tools
brew install fish starship neovim gh mise \
             fzf zoxide eza bat ripgrep fd jq bottom dust
brew install --cask raycast font-fira-code-nerd-font iterm2

# 3. SSH key + Keychain (skip if you already have ~/.ssh/id_ed25519)
ssh-keygen -t ed25519 -C "mikemoschitto@gmail.com" -f ~/.ssh/id_ed25519
/usr/bin/ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# Upload the public key twice on GitHub → Settings → SSH and GPG keys:
#   - Authentication Key  (git push/pull)
#   - Signing Key         (Verified commits)
# pbcopy < ~/.ssh/id_ed25519.pub

# Optional: local signature verification
mkdir -p ~/.ssh
echo "mikemoschitto@gmail.com $(cat ~/.ssh/id_ed25519.pub)" >> ~/.ssh/allowed_signers
# Then add to ~/.gitconfig (or keep in the linked copy):
#   [gpg "ssh"]
#     allowedSignersFile = ~/.ssh/allowed_signers

# 4. Make fish the login shell
FISH="$(which fish)"
echo "$FISH" | sudo tee -a /etc/shells
chsh -s "$FISH"

# 5. Clone and link (bash is fine here)
git clone https://github.com/michaelmoschitto/dotfiles.git ~/projects/dotfiles
DOTFILES="$HOME/projects/dotfiles"
mkdir -p ~/.config ~/.config/gh ~/.cursor/skills ~/.claude/skills ~/.codex/skills

ln -sf "$DOTFILES/.config/fish" ~/.config/fish
ln -sf "$DOTFILES/.config/starship.toml" ~/.config/starship.toml
ln -sf "$DOTFILES/.config/nvim" ~/.config/nvim
ln -sf "$DOTFILES/.config/zellij" ~/.config/zellij
ln -sf "$DOTFILES/.config/gh/config.yml" ~/.config/gh/config.yml
ln -sf "$DOTFILES/.gitconfig" ~/.gitconfig

# Shared skills → every agent; tool-specific → that agent only
for skill in "$DOTFILES"/skills/shared/*/; do
  [ -d "$skill" ] || continue
  name="$(basename "$skill")"
  ln -sfn "$skill" ~/.cursor/skills/"$name"
  ln -sfn "$skill" ~/.claude/skills/"$name"
  ln -sfn "$skill" ~/.codex/skills/"$name"
done
for skill in "$DOTFILES"/skills/cursor/*/; do
  [ -d "$skill" ] && ln -sfn "$skill" ~/.cursor/skills/"$(basename "$skill")"
done
for skill in "$DOTFILES"/skills/claude/*/; do
  [ -d "$skill" ] && ln -sfn "$skill" ~/.claude/skills/"$(basename "$skill")"
done
for skill in "$DOTFILES"/skills/codex/*/; do
  [ -d "$skill" ] && ln -sfn "$skill" ~/.codex/skills/"$(basename "$skill")"
done

# 6. Fish plugins — run inside fish
fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source; and fisher update'

# 7. First nvim launch installs LazyVim plugins; authenticate gh
nvim +qa
gh auth login
```

### iTerm2

- Set the profile font to **FiraCode Nerd Font**.
- For Option+Left/Right word jumps (and Zellij Alt keys later): Profiles → Keys →
  set Left/Right Option to **Esc+** or **Meta**.

### Language runtimes (mise)

Install tools on demand; this repo only activates mise from fish:

```bash
mise use -g node@lts
mise use -g python@latest
# mise use -g go@latest
# mise use -g rust@latest
```

### Optional packages

Install only when you need them:

```bash
brew install zellij          # multiplexer (config already in this repo)
# brew install --cask bitwarden
# brew install --cask claude-code@latest
# brew install --cask codex
```

## Per-tool notes

### Fish (`.config/fish/`)

Tracked **lockfile-only**: `config.fish` and `fish_plugins`. Fisher installs the
rest under `functions/`, `conf.d/`, etc. (gitignored).

Plugins: `fisher`, `patrickf1/fzf.fish`, `catppuccin/fish`, `jhillyerd/plugin-git`.

Abbreviations: `vim→nvim`, `ls→eza`, `cat→bat`, `cd→z`, `grep→rg`, `top→btm`,
`du→dust`.

### Git (`.gitconfig`)

Identity + **SSH commit signing** (`gpg.format = ssh`). Passphrases stay in the
macOS Keychain via `ssh-add --apple-use-keychain`. No GPG Suite required.

### Neovim (`.config/nvim/`) — LazyVim

Standard LazyVim layout. Extras enabled:

| Category | Extra | Notes |
| -------- | ----- | ----- |
| AI | `ai.claudecode` | Claude Code integration |
| Editor | dial, fzf, inc-rename, neo-tree, outline, snacks_picker | |
| Lang | go, json, markdown, python, rust, sql, typescript, yaml | no Java/toml |
| Test | `test.core` | neotest |
| Util | `util.dot`, `util.octo` | |

Obsidian is stubbed off until you set a vault path in
`.config/nvim/lua/plugins/obsidian.lua`.

### Zellij (`.config/zellij/`)

Config is ready; install the binary when you want a multiplexer. Works in iTerm;
tune Option-as-Meta so Alt bindings do not fight word navigation.

### AI skills (`skills/`)

One copy under `skills/shared/` is linked into Cursor, Claude, and Codex.
Tool-only skills live under `skills/{cursor,claude,codex}/`. See
[`skills/README.md`](skills/README.md).

### Raycast

Not tracked (tokens + Store extensions). Export Settings & Data from
Raycast → Settings → Advanced, then import the encrypted `.rayconfig` on a new
machine.

### Keyboard

**ZSA Moonlander** — publish your layout in Oryx and link it above.

## Updating

Edits are live through the symlinks. Save with git:

```bash
cd ~/projects/dotfiles
git pull
# edit configs...
git add -A && git commit -m "Update <tool> config" && git push

# After editing fish_plugins
fisher update

# After Neovim plugin changes
nvim +"Lazy sync" +qa
```

## What's intentionally not tracked

- Fisher-installed fish files (`fisher update` restores them)
- Neovim plugin data (`~/.local/share/nvim/`)
- Zellij `*.bak` backups
- Raycast runtime data and tokens
- Claude / Codex / Cursor app state (skills come from `skills/` via symlinks)
- Secrets (gh token lives in the system keychain)
