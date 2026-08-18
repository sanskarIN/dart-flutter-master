# Maintainer Commit Identity

For local maintainer commits to this repository, configure:

```bash
git config user.name "sanskarIN"
git config user.email "sanskarin@outlook.in"
```

To apply it globally on the maintainer machine instead of only this repository:

```bash
git config --global user.name "sanskarIN"
git config --global user.email "sanskarin@outlook.in"
```

The repository automation/integration used for some remote file operations may control the Git commit author metadata itself. Where an explicit author-email field is unavailable, project-generated commit messages use this trailer to retain the requested identity information:

```text
Signed-off-by: sanskarIN <sanskarin@outlook.in>
```
