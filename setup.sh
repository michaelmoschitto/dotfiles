#!/usr/bin/env bash
# Fresh-machine setup for ~/projects/dotfiles
# Run in iTerm:  bash ~/projects/dotfiles/setup.sh
set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/projects/dotfiles}"

if [[ ! -d "$DOTFILES" ]]; then
  echo "Dotfiles not found at $DOTFILES" >&2
  exit 1
fi

echo "==> Installing core brew packages"
brew install fish starship neovim fzf zoxide eza bat ripgrep fd bottom dust jq zellij
brew install --cask font-fira-code-nerd-font
# iTerm + Raycast already present on this machine; install via cask only if missing
[[ -d /Applications/iTerm.app ]] || brew install --cask iterm2
[[ -d /Applications/Raycast.app ]] || brew install --cask raycast

echo "==> SSH key + Keychain"
if [[ ! -f "$HOME/.ssh/id_ed25519" ]]; then
  ssh-keygen -t ed25519 -C "mikemoschitto@gmail.com" -f "$HOME/.ssh/id_ed25519" -N ""
fi
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
if [[ ! -f "$HOME/.ssh/config" ]]; then
  cat > "$HOME/.ssh/config" <<'EOF'
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
EOF
  chmod 600 "$HOME/.ssh/config"
fi
/usr/bin/ssh-add --apple-use-keychain "$HOME/.ssh/id_ed25519" 2>/dev/null || /usr/bin/ssh-add "$HOME/.ssh/id_ed25519"
touch "$HOME/.ssh/allowed_signers"
if ! grep -q "mikemoschitto@gmail.com" "$HOME/.ssh/allowed_signers" 2>/dev/null; then
  echo "mikemoschitto@gmail.com $(cat "$HOME/.ssh/id_ed25519.pub")" >> "$HOME/.ssh/allowed_signers"
fi

echo
echo ">>> Add this public key to GitHub twice (Authentication Key + Signing Key):"
echo "    https://github.com/settings/ssh/new"
cat "$HOME/.ssh/id_ed25519.pub"
echo

echo "==> Fish as login shell"
FISH="$(command -v fish)"
if ! grep -qx "$FISH" /etc/shells; then
  echo "$FISH" | sudo tee -a /etc/shells >/dev/null
fi
if [[ "$SHELL" != "$FISH" ]]; then
  chsh -s "$FISH"
  echo "Login shell set to $FISH (new terminal tabs will use fish)"
fi

echo "==> Symlinks (backing up existing files)"
mkdir -p "$HOME/.config" "$HOME/.config/gh" \
  "$HOME/.cursor/skills" "$HOME/.claude/skills" "$HOME/.codex/skills"

backup() {
  local path="$1"
  if [[ -e "$path" && ! -L "$path" ]]; then
    local bak="${path}.bak.$(date +%Y%m%d%H%M%S)"
    mv "$path" "$bak"
    echo "  backed up $path -> $bak"
  elif [[ -L "$path" ]]; then
    rm "$path"
  fi
}

backup "$HOME/.config/fish"
backup "$HOME/.config/starship.toml"
backup "$HOME/.config/nvim"
backup "$HOME/.config/zellij"
backup "$HOME/.config/gh/config.yml"
backup "$HOME/.gitconfig"
backup "$HOME/.config/mise/config.toml"
backup "$HOME/.zshrc"

mkdir -p "$HOME/.config/mise"

ln -sfn "$DOTFILES/.config/fish" "$HOME/.config/fish"
ln -sfn "$DOTFILES/.config/starship.toml" "$HOME/.config/starship.toml"
ln -sfn "$DOTFILES/.config/nvim" "$HOME/.config/nvim"
ln -sfn "$DOTFILES/.config/zellij" "$HOME/.config/zellij"
ln -sfn "$DOTFILES/.config/gh/config.yml" "$HOME/.config/gh/config.yml"
ln -sfn "$DOTFILES/.gitconfig" "$HOME/.gitconfig"
ln -sfn "$DOTFILES/.config/mise/config.toml" "$HOME/.config/mise/config.toml"
ln -sfn "$DOTFILES/.zshrc" "$HOME/.zshrc"

# Skills: shared → all agents; tool-specific → that agent
link_skills() {
  local src_dir="$1"
  local dest_dir="$2"
  shopt -s nullglob
  for skill in "$src_dir"/*/; do
    [[ -d "$skill" ]] || continue
    local name
    name="$(basename "$skill")"
    [[ "$name" == .* ]] && continue
    ln -sfn "$skill" "$dest_dir/$name"
    echo "  linked skill $name -> $dest_dir"
  done
  shopt -u nullglob
}
link_skills "$DOTFILES/skills/shared" "$HOME/.cursor/skills"
link_skills "$DOTFILES/skills/shared" "$HOME/.claude/skills"
link_skills "$DOTFILES/skills/shared" "$HOME/.codex/skills"
link_skills "$DOTFILES/skills/cursor" "$HOME/.cursor/skills"
link_skills "$DOTFILES/skills/claude" "$HOME/.claude/skills"
link_skills "$DOTFILES/skills/codex" "$HOME/.codex/skills"

echo "==> Fisher plugins"
fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source; and fisher update'

echo "==> Neovim plugin sync (first launch)"
nvim --headless +"Lazy sync" +qa || nvim +qa || true

echo
echo "Done. Next:"
echo "  1. Open a new iTerm tab (should be fish + starship)"
echo "  2. Set iTerm font to FiraCode Nerd Font"
echo "  3. Paste the SSH public key into GitHub (auth + signing)"
echo "  4. Try:  git -C \"$DOTFILES\" log -1 --show-signature"
echo "  5. Try:  nvim"
