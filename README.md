# wt

Git worktree manager. Simplifies creating, switching between, and cleaning up worktrees.

## Installation

```bash
/path/to/wt --install
```

This adds a shell function to your config file (`~/.bashrc`, `~/.zshrc`, or `~/.config/fish/config.fish`). Reload your shell:

```bash
source ~/.bashrc  # or ~/.zshrc or: source ~/.config/fish/config.fish
```

## Usage

```bash
wt -c <branch> [base]      # Create worktree (base defaults to current branch)
wt --rm <branch>           # Remove worktree
wt --nuke                  # Remove current worktree and return to main repo
wt --clean                 # Interactive cleanup of all worktrees
wt --ls                    # List worktrees
```

### Flags

- `--skip-bootstrap` - Skip running the bootstrap script

## Project Bootstrap

When creating a worktree, `wt` looks for `scripts/wt_bootstrap.sh` in your repository. If present, it runs automatically after worktree creation.

The script receives two arguments:
1. Path to the main repository
2. Path to the new worktree

### Example bootstrap script

```bash
#!/bin/bash
# scripts/wt_bootstrap.sh

MAIN_REPO="$1"
WORKTREE="$2"

cd "$WORKTREE"
npm ci
```

Skip bootstrap with:

```bash
wt -c my-branch --skip-bootstrap
```
