# Notes on Advanced Git Workflows

## Working with Forks and upstream repos
Keeping the name as something like upstream is probably a best practice
```bash
git remote -v
git remote add upstream <path to upstream repo>
```

## Workflow for syncing an upstream fork
```bash
git checkout <local branch name>
git fetch upstream <branch name>
git merge upstream/<branch name>
```
* NOTE: Be mindful here if you are working with multiple local and upstream branches, ie `master` and `future`.  It's really easy to accidentally merge upstream `future` into local `master` for example.  

### Gets a list of file names only that are different between the branches
```bash
git diff upstream/master origin/master --name-only
```

### Get just a single file out of an upstream repo:
```bash
git checkout upstream/future -- docs/breaking_changes.md
```

## Working with Patches
`git diff > my.patch`
## OR: 
```bash
git diff upstream/master origin/master > my.patch
git apply my.patch
```

## Scorch the earth in a forked repo and make it just like the remote again:
`git reset --hard upstream/<branch name>`
`git push origin <branch name> --force`
* This is extremely dangerous and the potential for loss of work is high.  Plan ahead before running this command.

## Rebasing a remote master to make it look like a new repo:
1.  Make sure you have merged the origin/upstream master and have a clean working directory.  
2.  If you are planning to rewrite a GitHub repo, it is also recommended you make a fresh clone of it into a different directory for verification and recovery purposes.  
3. Run:
```bash
git rebase --interactive --root
```

>[!NOTE] 
>Using the `--root` arg is a big time saver if you want to rebase all history.  Otherwise, you must pass in args to pick and choose as needed.

4.  As you cycle through the list of commits, pick the ones you want to squash, typically all of them but the top.  
You might need to resolve merge conflicts with `git add` and `git rebase --continue`.  

>[!NOTE]
> A rebase replays the list of commits over the current working branch, so the theirs and ours are flipped, so in the case of a rebase, ours means the master.  If you want to try to skip merge conflicts, you can try:
```bash
git rebase --interactive --root -X ours master
```

>[!NOTE]
> `git commit --amend` is handy here if you just want to rewrite the last commit message instead of re-running rebase.

5.  Once the local history looks the way that you want it to (use `git logs` to check it), it's time for the most dangerous step.  You should hopefully have a backup copy that you made in step #2, and please don't get in the habit of using `--force`.  This will take your local commit history and overwrite the GitHub repository's history to match.  Then, once others subsequently do a git pull, their version lineage will be rewritten to match it.  
```bash
git push --force
```
6.  Verification (optional).  Go to the backup of the repository you made in step #2, and remember not to get latest.  Then simply do a `git diff origin` to confirm that the rewritten history matches the previous contents of the repo.  

## resolve merge conflicts by accept theirs:
`git checkout --theirs -- <filename>`

## Ways to squash commits
`git reset --soft HEAD~3 &&`
`git commit --edit -m'blah'
`git push --force`
* where 3 is the number of commits back in history to squash

## Using GPG to sign commits
* Install GPG using `brew install gpg` or similar based on your OS.
* Add an alias to your .gitconfig file that associates `git ci` to `commit -S`
* Add the following git configuration: `git config --global user.signingkey` where signingkey is the public key signature of the GPG key. 

## Other notes
`git config --global credential.helper store`
