# Zellij cheatsheet (this setup)

Zellij is a terminal **multiplexer**: one window holds panes (split terminals) and tabs. You type shell commands as usual; Zellij keys control the *layout around* them.

**Mental model:** most power keys put you in a short-lived **mode**. The status bar shows the mode. Do the action, then you’re back to typing in the shell.

On Mac / iTerm: **Alt = Option (⌥)**. Option keys only work if iTerm → Profiles → Keys → Left/Right Option → **Esc+**.

Config: [`.config/zellij/config.kdl`](config.kdl). Defaults were cleared; bindings below are what’s actually enabled.

---

## Start / stop

| Command / keys | Action |
| -------------- | ------ |
| `zellij` | Start a session |
| `zellij attach` | Reattach to a running session |
| `Ctrl+q` | Quit Zellij entirely |
| `Ctrl+a` then `d` | Detach (session keeps running) |
| `Ctrl+a` then `w` | Session manager UI |

---

## Everyday starters

Do these without entering a named mode:

| Keys | Action |
| ---- | ------ |
| `⌥+h` / `⌥+l` | Focus pane (or tab) left / right |
| `⌥+j` / `⌥+k` | Focus pane down / up |
| `⌥+n` | New pane |
| `⌥+f` | Toggle floating panes |
| `⌥+=` / `⌥+-` | Grow / shrink focused pane |
| `Ctrl+s` | **Scroll mode** (copy / browse history) |
| `Ctrl+p` | Pane mode |
| `Ctrl+t` | Tab mode |
| `Ctrl+n` | Resize mode |
| `Ctrl+m` | Move-pane mode |
| `Ctrl+g` | Lock (ignore Zellij keys) / unlock |

Leave most modes with `Esc` or `Enter`.

**⌥+Left/Right are not Zellij** — they’re reserved for fish word jumps on the command line.

---

## Scroll / copy mode (`Ctrl+s`)

Like tmux “copy mode”: browse scrollback above the prompt.

| Keys | Action |
| ---- | ------ |
| `j` / `k` | Scroll down / up one line |
| `u` / `d` | Half page up / down |
| `h` / `l` (or arrows) | Page up / down |
| `s` | Search scrollback → type query → Enter |
| `n` / `p` | Next / previous search hit |
| `e` | Open scrollback in `$EDITOR` (nvim) |
| mouse drag | Select text (copies on release) |
| `Ctrl+c` or `Ctrl+s` | Exit to normal |

---

## Pane mode (`Ctrl+p`)

| Keys | Action |
| ---- | ------ |
| `h` `j` `k` `l` | Move focus |
| `n` | New pane |
| `d` / `r` | New pane down / right |
| `s` | New stacked pane |
| `f` | Fullscreen focused pane |
| `w` | Toggle floating panes |
| `e` | Embed ↔ floating |
| `c` | Rename pane |
| `x` | Close focused pane |
| `z` | Toggle pane frames |
| `Ctrl+p` / `Esc` | Back to normal |

---

## Tab mode (`Ctrl+t`)

| Keys | Action |
| ---- | ------ |
| `h` / `l` (or `j` / `k`) | Previous / next tab |
| `1`…`9` | Jump to tab N |
| `n` | New tab |
| `x` | Close tab |
| `r` | Rename tab |
| `s` | Sync input across panes in tab |
| `Ctrl+t` / `Esc` | Back to normal |

Move tabs without a mode: `⌥+i` left, `⌥+o` right.

---

## Resize mode (`Ctrl+n`)

| Keys | Action |
| ---- | ------ |
| `h` `j` `k` `l` | Grow toward that edge |
| `H` `J` `K` `L` | Shrink from that edge |
| `+` / `-` | Grow / shrink |
| `Ctrl+n` / `Esc` | Back to normal |

Quick resize without a mode: `⌥+=` / `⌥+-`.

---

## Move mode (`Ctrl+m`)

Rearrange which pane sits where (not just focus).

| Keys | Action |
| ---- | ------ |
| `h` `j` `k` `l` | Move pane that direction |
| `n` / `Tab` | Cycle pane position |
| `p` | Move backwards |
| `Ctrl+m` / `Esc` | Back to normal |

---

## Session mode (`Ctrl+a`)

| Keys | Action |
| ---- | ------ |
| `w` | Session manager |
| `c` | Configuration UI |
| `p` | Plugin manager |
| `l` | Layout manager |
| `d` | Detach |
| `a` | About |
| `Ctrl+a` / `Esc` | Back to normal |

---

## Locked mode (`Ctrl+g`)

Zellij stops intercepting keys so apps that want Ctrl chords can use them. Press `Ctrl+g` again to unlock.

---

## Tmux-compat prefix (`Ctrl+b`)

Optional muscle-memory layer. After `Ctrl+b`:

| Keys | Action |
| ---- | ------ |
| `"` / `%` | Split down / right |
| `c` | New tab |
| `[` | Scroll mode |
| `h` `j` `k` `l` | Focus pane |
| `n` / `p` | Next / previous tab |
| `z` | Fullscreen |
| `x` | Close pane |
| `d` | Detach |

---

## First-day practice

1. `zellij`
2. `⌥+n` — second pane; `⌥+hjkl` to move between them
3. Run something noisy (`ls`, `git log`); `Ctrl+s` → `k`/`j` → mouse-select → `Ctrl+c`
4. `Ctrl+t` → `n` for a new tab; `1`/`2` to jump
5. `Ctrl+q` when done (or `Ctrl+a` `d` to detach and keep it)

If a key does nothing, check the status bar mode and whether you’re still inside scroll/pane/tab mode.