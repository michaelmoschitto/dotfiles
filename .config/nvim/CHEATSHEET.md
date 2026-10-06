# Neovim cheatsheet (LazyVim)

For someone who already uses **vim motions in Cursor**. Motions (`hjkl`, `w`, `ci"`, visual mode, etc.) work the same. What changes is the **plugin layer**: Space is leader, and most features live under leader prefixes with a popup menu.

**Discoverability:** press `Space` and wait — [which-key](https://github.com/folke/which-key.nvim) lists available bindings. Press `?` inside neo-tree for tree help.

Leader = `Space`. Examples below write `Space e` meaning press Space, then `e`.

---

## Cursor vim → Neovim

| In Cursor | In this Neovim setup |
| --------- | -------------------- |
| Vim motions / operators | Same |
| Cmd/Ctrl palette, sidebar clicks | Leader keys + neo-tree |
| Multi-cursor (editor) | Multicursor plugin (`Space m…`, arrows) |
| Go to file / fuzzy find | `Space Space` |
| Project search | `Space /` |
| Sidebar file tree | `Space e` |
| Tabs / editors | Buffers (`Shift+h` / `Shift+l`) |

Open a project: `cd` then `nvim` (or `nvim .`). Fish aliases `vim` → `nvim`.

---

## Everyday starters

| Keys | Action |
| ---- | ------ |
| `Space Space` | Find files (project root) |
| `Space /` | Grep project |
| `Space ,` | Buffer picker |
| `Space e` | Toggle file tree (root) |
| `Space E` | File tree (cwd) |
| `Space B` | Harpoon: mark current file |
| `Space 1`…`9` | Harpoon: jump to mark |
| `Ctrl+s` | Save |
| `Space qq` | Quit all |
| `Space l` | Lazy plugin manager |

---

## File tree (neo-tree)

Open/close: `Space e`. Focus stays in the tree until you open a file or press `q`.

### Navigate & open

| Keys | Action |
| ---- | ------ |
| `j` / `k` | Move |
| `Enter` | Open file / toggle dir |
| `l` | Focus preview (when preview open) |
| `s` | Open in **vertical** split |
| `S` | Open in **horizontal** split |
| `t` | Open in new tab |
| `P` | Toggle preview |
| `q` | Close neo-tree |
| `?` | Help |

### Expand / collapse

| Keys | Action |
| ---- | ------ |
| `z` | Collapse all nodes |
| `Z` | Expand all nodes *(custom)* |
| `C` | Close current node |
| `Backspace` | Go up a directory |
| `.` | Set current dir as root |

### Files & folders

| Keys | Action |
| ---- | ------ |
| `a` | Add file (prompts; use trailing `/` for dir) |
| `A` | Add directory |
| `d` | Delete |
| `r` | Rename |
| `y` / `x` / `p` | Copy / cut / paste (clipboard) |
| `c` / `m` | Copy / move (prompt for path) |
| `H` | Toggle hidden files |
| `/` | Fuzzy find in tree |
| `R` | Refresh |
| `[g` / `]g` | Prev / next git-modified |

Also: `Space ge` git status tree, `Space be` buffers tree.

---

## Find & search

| Keys | Action |
| ---- | ------ |
| `Space Space` / `Space ff` | Files (root) |
| `Space /` | Live grep (root) |
| `Space sw` | Grep word under cursor |
| `Space ,` | Open buffers |
| `Space fr` | Recent files |
| `Space ss` | LSP document symbols |
| `Space sS` | LSP workspace symbols |
| `Space st` | Todo comments |
| `Space sR` | Resume last picker |
| `Space sg` / git pickers | Via `Space g…` / search menu |

In pickers: type to filter, `Enter` to open, `Ctrl+j`/`Ctrl+k` often move (depends on picker). Esc closes.

---

## Buffers & windows

| Keys | Action |
| ---- | ------ |
| `Shift+h` / `Shift+l` | Prev / next buffer |
| `Space bd` | Close buffer |
| `Space bo` | Close other buffers |
| `Space bn` / `Space bp` | Next / prev *(custom)* |
| `Ctrl+h/j/k/l` | Move between splits |
| `Ctrl+arrows` | Resize splits |
| `Space sv` / `Space sh` | Vertical / horizontal split *(custom)* |
| `Space \|` / `Space -` | Split right / below (LazyVim) |
| `Space wd` | Close window |
| `Ctrl+/` | Toggle terminal |

---

## LSP / code intelligence

Works in files with a language server (Rust, Python, TS, etc. from your LazyVim extras).

| Keys | Action |
| ---- | ------ |
| `gd` | Go to definition |
| `gr` | References |
| `gp` | Peek definition (lspeek) |
| `gP` | Peek type definition (lspeek) |
| `K` | Hover docs |
| `Space ca` | Code action |
| `Space cr` | Rename (inc-rename) |
| `Space cf` | Format |
| `Space cd` | Line diagnostics |
| `]d` / `[d` | Next / prev diagnostic |
| `]e` / `[e` | Next / prev error |
| `Space cs` | Outline (symbols) |
| `Space td` | Toggle diagnostics *(custom)* |

**lspeek peek window:** `q` close, `Enter` jump, `s`/`v` split, `t` tab, `[`/`]` stack.

Completion (blink.cmp): `Ctrl+j` / `Ctrl+k` next / prev item *(custom)*.

---

## Git

| Keys | Action |
| ---- | ------ |
| `Space gD` | Diff (stock LazyVim picker — line-by-line) |
| `Space ghs` | Stage hunk |
| `Space ghr` | Reset hunk |
| `Space ghp` | Preview hunk |
| `Space ghb` | Blame line |
| `]h` / `[h` | Next / prev hunk (gitsigns) |
| `Space ge` | Neo-tree git status |
| `Space gg` | Lazygit *(needs `brew install lazygit` — not in setup.sh yet)* |

---

## Harpoon (pinned files)

| Keys | Action |
| ---- | ------ |
| `Space B` | Add current file |
| `Space bq` | Quick menu |
| `Space 1`…`9` | Jump to slot |

---

## Multicursor

| Keys | Action |
| ---- | ------ |
| `↑` / `↓` | Add cursor on line above / below |
| `Space ↑` / `Space ↓` | Skip line above / below |
| `Space mn` / `Space mN` | Add cursor at next / prev match |
| `Space ms` / `Space mS` | Skip next / prev match |
| `Space ma` or `Ctrl+q` | Toggle cursor at position |
| `←` / `→` | Cycle main cursor (multi only) |
| `Esc` | Clear / re-enable cursors (multi only) |

---

## Editing extras

| Keys | Action |
| ---- | ------ |
| `gcc` / `gc` (visual) | Comment toggle (mini.comment) |
| `gsa` / `gsd` / `gsr` | Surround add / delete / replace |
| `Ctrl+a` / `Ctrl+x` | Increment / decrement (dial) |
| `Space mj` / `Space mk` | Move line / selection down / up |
| `Space p` (visual) | Paste without yanking |
| `Space x` | Delete without yanking *(overrides LazyVim `Space x` diagnostics prefix for that key)* |
| `Space h` | Clear search highlights |
| `Space pa` | Copy full file path to clipboard |
| Insert abbrevs | `todo`, `fixme`, `note`, … → tagged comments |

---

## Tests (neotest)

| Keys | Action |
| ---- | ------ |
| `Space tt` | Run tests in file |
| `Space tr` | Run nearest |
| `Space tT` | Run all in cwd |
| `Space tl` | Run last |
| `Space ts` | Summary panel |
| `Space to` | Show output |
| `Space tw` | Watch file |

Note: LazyVim also binds `Space td` to “debug nearest”; your custom `Space td` toggles diagnostics — if one wins unexpectedly, check which-key after `Space t`.

---

## AI (Claude Code extra)

| Keys | Action |
| ---- | ------ |
| `Space ac` | Toggle Claude |
| `Space af` | Focus Claude |
| `Space ab` | Add current buffer |
| `Space as` (visual) | Send selection |

---

## Mental model tips

1. **When stuck, press `Space` and read the menu** — groups: `f` find, `s` search, `g` git, `c` code, `b` buffer, `u` UI, `t` test, `a` AI.
2. **Neo-tree is modal to the sidebar** — tree keys only apply when that window is focused; `?` lists them.
3. **Buffers ≠ Cursor tabs** — many files stay open; `Shift+l`/`h` cycles; `Space bd` closes.
4. **Root vs cwd** — many pickers use LazyVim “root” (git/project); uppercase variants often mean cwd (`Space E`, `Space fE`, …).
5. **Config lives in** `.config/nvim/lua/` — `plugins/` for extras, `config/keymaps.lua` for your maps. After edits: reopen nvim or `:Lazy sync` if plugins changed.
