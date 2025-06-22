# dotfiles

> [!CAUTION]
> This configuration was created and tested on macOS (15.4.1 on Apple Silicon). It has not been tested on other platforms or macOS versions.

## Installation and configuration

**Installation order:**

1. Install Homebrew (and set HOMEBREW_HOME in `~.profile`) and install needed formulas and casks
2. Configure terminal emulator (ghostty) and multiplexer (zellij)
3. Install and configure needed toolchains (pyenv, goenv, rustup, ghcup)
4. Install and configure additional tools (poetry, pass, git, podman desktop)
5. Setup NeoVim

### Homebrew

To install Homebrew see: https://docs.brew.sh/Installation

> [!IMPORTANT]
> After installing Homebrew, set the `HOMEBREW_HOME` variable (in `~.profile`) to the path to your Homebrew home

Once Homebrew is installed, install the necessary formulas and casks (from `Brewfile`):

```sh
brew bundle install
```

### Terminal emulator and multiplexer

#### Ghostty

Change `command` option in `~/.config/ghostty/config`:

```text
command = <Homebrew home path>/fish -lic zellij
```

> [!TIP]
> You can change the default app icon by set another one from `~/.config/ghostty/icons/` (see: https://discussions.apple.com/thread/255174964)

#### Alacritty

Replace `terminal.shell` option in `~/.config/alacritty/alacritty.toml`:

```toml
[terminal]
shell = { program = "<Homebrew home path>/fish", args = [
  "-ic",
  "zellij attach --index 0 || zellij",
] }
```

#### Zellij

Replace `theme_dir` option in `~/.config/zellij/config.kdl`:

```kdl
theme_dir "<full path to XDG config home>/zellij/themes"
```

### pyenv

Install some version of python and make it global:

```sh
pyenv install <some version> && pyenv global <some version>
```

### goenv

Install some version of golang and make it global:

```sh
goenv install <some version> && goenv global <some version> && goenv rehash
```

### rustup

Install the rust toolchains:

```sh
rustup default stable
```

### ghcup

Install the haskell toolchains by running:

```sh
ghcup tui
```

... and select the versions you want

### git

Add a `~/.config/git/user` file with your local configuration

### poetry

Install poetry (see: https://python-poetry.org/docs/#installation) and add a symlink to the XDG executable dir:

```sh
ln -s $POETRY_HOME/bin/poetry $XDG_BIN_DIR/poetry
```

### docker desktop

To install Docker desktop see https://docs.docker.com/get-started/introduction/get-docker-desktop/

### pass

_SOON_

## Overview of packages and tools

_SOON_
