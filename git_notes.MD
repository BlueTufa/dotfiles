# Working with Forks
git remote -v
git remote add upstream <path to upstream repo>

## Workflow for syncing an upstream fork
git checkout <local branch name>
git fetch upstream <branch name>
git merge upstream 
### Gets a list of file names that are different between the branches
git diff upstream/master origin/master --name-only

## Working with Patches
git diff > my.patch
git apply my.patch

## Scorch the earth and make it just like the remote again:
`git reset --hard upstream/<branch name>`
`git push origin <branch name> --force`
