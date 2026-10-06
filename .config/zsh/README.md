~/.zshrc loads zshrc in this directory. Run `exec zsh` after changes.

Files:
- zshrc: environment, history, completion initialization, utilities, aliases,
  secrets, and the yellow-directory prompt with a vi mode indicator.
- interactive.zsh: vi bindings, abbreviation widgets, suggestions, pairing,
  and cursor changes.
- shortcuts.zsh: 149 abbreviations, also registered as aliases.
- git.zsh: custom Git helpers.
- plugins/: vendored autosuggestions and autopair, with upstream licenses.

Completion paths are configured before `autoload -Uz compinit` and `compinit`.
Kubectl completion is loaded afterward. Homebrew supplies other tool completions.

FZF: Ctrl+R searches history, Ctrl+T selects files, Alt+C selects directories.
Vi insert mode: Space/Enter expand command abbreviations; Ctrl+Y accepts and
executes a suggestion; Alt+Y accepts a word. Escape enters vi command mode. The prompt starts with I, N, or V for insert, normal, or visual mode;
`i` returns to insert mode, and `v` selects text in normal mode.
Syntax highlighting is disabled.

Secrets load from ~/.secrets.zsh, or exported values from ~/.secrets.fish.
Abbreviations are a snapshot; future fish changes do not automatically sync.
Git branch cleanup protects current/default branches as well as main/master/develop.

Old configs, backups, Tide files, and the disabled highlighting plugin were moved
to ~/.local/state/zsh/archive/. No archived files are loaded.

Upstream plugins:
https://github.com/zsh-users/zsh-autosuggestions
https://github.com/hlissner/zsh-autopair
