# .files

## Prerequisites

* `stow` (`apt-get install stow`)

## Using It

This repo has to be checked out to `~/.dotfiles`, i.e.

```sh
git clone https://github.com/mneundorfer/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow tmux vscode # whatever you like...
# or
find . -maxdepth 1 -mindepth 1 -type d -exec stow {} +
```