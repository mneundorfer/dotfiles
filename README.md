# .files

## Using It

This repo has to be checked out to `~/.dotfiles`, i.e.

```sh
git clone PATH ~/.dotfiles
cd ~/.dotfiles
stow tmux vscode # whatever you like...
# or
find . -maxdepth 1 -mindepth 1 -type d -exec stow {} +
```