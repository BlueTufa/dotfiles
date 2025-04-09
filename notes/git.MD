# Advanced Git Workflows Reference Guide

This guide contains advanced Git operations that are useful but infrequently used. Each section includes practical examples and important warnings about potentially destructive operations.

## Managing Remote Repositories

### Working with Upstream Repositories

When working with forked repositories, it's essential to track the original repository as an "upstream" remote.

```bash
# View existing remotes
git remote -v

# Add the upstream repository
git remote add upstream https://github.com/original-owner/original-repository.git
```

### Syncing Your Fork with Upstream

Keep your fork in sync with the original repository to incorporate the latest changes.

```bash
# Update your local branch
git checkout your-branch
git pull

# Fetch upstream changes
git fetch upstream main

# Merge upstream changes into your local branch
git merge upstream/main
```

⚠️ **Warning**: Be careful when working with multiple branches. Always verify which branches you're merging to avoid mixing content (e.g., merging upstream `develop` into local `main`).

### Comparing Differences Between Branches

```bash
# List files that differ between branches
git diff upstream/main origin/main --name-only

# Get detailed changes
git diff upstream/main origin/main
```

### Retrieving Specific Files from Another Branch

```bash
# Get a single file from upstream branch
git checkout upstream/develop -- path/to/file.md
```

## Working with Patches

Create, share, and apply changes between repositories or branches.

```bash
# Create a patch file from current changes
git diff > changes.patch

# Create a patch between two branches
git diff upstream/main origin/main > branch-diff.patch

# Apply a patch
git apply changes.patch

# Apply patch with conflict resolution options
git apply --reject --whitespace=fix changes.patch
```

## Reset and Rebase Operations

### Reset Local Repository to Match Remote

⚠️ **Danger Zone**: These commands can cause permanent data loss. Always back up your work first.

```bash
# Reset local branch to match upstream
git reset --hard upstream/main

# Force push to update your remote fork (use with extreme caution)
git push origin main --force
```

### Rebasing to Rewrite History

Used to clean up commit history before sharing your work.

```bash
# Interactive rebase from the root of the repository
git rebase --interactive --root

# Interactive rebase with conflict resolution strategy
git rebase --interactive --root -X ours main
```

**Rebase Workflow**:

1. Make sure your working directory is clean
2. Create a backup of your repository
3. Start the interactive rebase
4. Choose which commits to keep, squash, or edit
5. Resolve any conflicts that arise
6. Verify the new history with `git log`
7. Force push only if necessary and you understand the consequences

### Amending Recent Commits

```bash
# Change the last commit message
git commit --amend

# Add more changes to the last commit
git add .
git commit --amend --no-edit
```

### Squashing Commits

```bash
# Squash last 3 commits
git reset --soft HEAD~3
git commit -m "New combined commit message"
```

## Resolving Merge Conflicts

```bash
# Accept changes from the current branch ('ours')
git checkout --ours -- conflicted-file.txt

# Accept changes from the other branch ('theirs')
git checkout --theirs -- conflicted-file.txt
```

**Note**: During a rebase, 'ours' and 'theirs' are reversed since rebase replays your changes on top of the target branch.

## Signing Commits with GPG

Verify your identity when contributing to projects.

```bash
# Set up signing
git config --global user.signingkey YOUR_GPG_KEY_ID
git config --global commit.gpgsign true

# Sign a commit
git commit -S -m "Signed commit message"
```

### GPG Key Management

```bash
# List installed GPG keys
gpg --list-keys

# Import a GPG key
gpg --import path/to/private.key

# Change GPG key passphrase
gpg --edit-key KEY_ID
# Type "passwd", follow prompts, then "save"
```

## Credential Management

```bash
# Store credentials in system keychain
git config --global credential.helper store
```

## Git Configuration Tips

```bash
# Create useful aliases
git config --global alias.ci "commit -S"
git config --global alias.st "status"
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Set default branch name
git config --global init.defaultBranch main
```

## Best Practices

1. **Back up before destructive operations**: Create a separate clone before rebasing or force pushing
2. **Avoid force push on shared branches**: Only use force push on your personal branches
3. **Commit atomically**: Each commit should represent a single logical change
4. **Write meaningful commit messages**: Explain why, not just what
5. **Regularly sync with upstream**: Keep your fork updated to minimize merge conflicts