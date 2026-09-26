# Raycast (as code)

Raycast keeps runtime state in encrypted SQLite
(`~/Library/Application Support/com.raycast.macos/`). There is **no** official
CLI that mutates Quicklinks in-place, and you can’t usefully symlink that DB.

What *is* supported (and is the intended “as code” path):

## Quicklinks = JSON in git

Official format — an array of objects ([docs](https://manual.raycast.com/quicklinks)):

```json
[
  {
    "name": "Search DuckDuckGo",
    "link": "https://duckduckgo.com/?q={argument}"
  },
  {
    "name": "Downloads",
    "link": "~/Downloads",
    "openWith": "Finder",
    "iconName": "folder-16"
  }
]
```

| Field | Required | Notes |
|-------|----------|-------|
| `name` | yes | Title in Raycast |
| `link` | yes | URL, `~/path`, or deeplink |
| `iconName` | no | Raycast icon name |
| `openWith` | no | App name (default: browser) |

**Author in the repo → import into Raycast:**

1. Edit [`quicklinks.json`](quicklinks.json) here (or export from Raycast into this path).
2. Raycast → **Import Quicklinks** → pick this file.
3. Matching links are skipped on re-import (safe to re-run).

**Capture what you already built in the UI:**

1. Raycast → **Export Quicklinks**
2. Save as `~/projects/dotfiles/raycast/quicklinks.json`
3. Commit. From then on, prefer editing the JSON (or re-export after UI changes).

Same idea for snippets → `snippets.json` via Export/Import Snippets.

## Script Commands = fully file-native

Scripts in a folder Raycast watches. Point Settings → Script Commands →
**Add Script Directory** at e.g. `~/projects/dotfiles/raycast/scripts/`. Those
are real code in git with no import step.

## What still isn’t codeable

| Thing | Reality |
|-------|---------|
| Hotkeys / aliases / extension prefs | Encrypted `.rayconfig` export, or Pro Cloud Sync |
| Live reload of Quicklinks from disk | Not supported — re-run Import after edits |
| Writing into the SQLite DB yourself | Unsupported / fragile |

Keep `*.rayconfig` out of git (can include tokens / clipboard history).
