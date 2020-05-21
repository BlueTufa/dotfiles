# Notes on Advanced Git Workflows
## Working with Forks and upstream repos
Keeping the name as something like upstream is probably a best practice
```
git remote -v
git remote add upstream <path to upstream repo>
```

## Workflow for syncing an upstream fork
```
git checkout <local branch name>
git fetch upstream <branch name>
git merge upstream/<branch name>
```

### Gets a list of file names only that are different between the branches
`git diff upstream/master origin/master --name-only`

### Get just a single file out of an upstream repo:
`git checkout upstream/future -- docs/breaking_changes.md`

## Working with Patches
`git diff > my.patch`
## OR: 
```
git diff upstream/master origin/master > my.patch
git apply my.patch
```

## Scorch the earth in a forked repo and make it just like the remote again:
`git reset --hard upstream/<branch name>`
`git push origin <branch name> --force`
* This is extremely dangerous and the potential for loss of work is high.  Plan ahead before running this command.

## Rebasing a remote master to make it look like a clean repo:
Make sure you have merged the origin/upstream master and have a clean working directory.  
If you are planning to rewrite a GitHub repo, it is also recommended you make a fresh clone of it into a different directory for verification and recovery purposes.  
Then run:
```bash
git rebase --interactive --root
```
Using the `--root` arg is a big time saver if you want to rebase all history.  Otherwise, you must pick and choose as needed.
As you cycle through the list of commits, pick the ones you want to squash, typically all of them but the top.  
You might need to resolve merge conflicts with `git add` and `git rebase --continue`.  
If you are feeling brave and want to try to skip merge conflicts, go for it:
```bash
git rebase --interactive --root -X ours master
```
* Note that a rebase replays the list of commits over the current working branch, so the theirs and ours are flipped, so in the case of a rebase, ours means the master.  
Iterate on this until you get the history looking the way you want.  
Note that `git commit --amend` is handy here instead of re-running rebase.

Once the local history looks the way that you want it to, It's time for the most dangerous step.  The consequences of this cannot be understated, and you should not be using this on a regular basis.  This is why you hopefully made a backup clone of your repo just in case.  This will take your local commit history and overwrite the github repository's history to match.  When others subsequently do a git pull they will also lose that version lineage.  
```bash
git push --force
```

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
