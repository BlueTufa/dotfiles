# Working with Forks and upstream repos
# Keeping the name as something like upstream is probably a best practice
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

### Gets a list of file names that are different between the branches
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

## Scorch the earth and make it just like the remote again:
`git reset --hard upstream/<branch name>`
`git push origin <branch name> --force`

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
