# dotfiles

## Tools

- General:

  - Package manager: [Homebrew](https://github.com/Homebrew/brew)
  - Shell: [fish](https://github.com/fish-shell/fish-shell)
  - Shell prompt: [Starship](https://github.com/starship/starship)
  - Terminal emulator: [ghostty](https://github.com/ghostty-org/ghostty) (spare: [alacritty](https://github.com/alacritty/alacritty))
  - Terminal multiplexer: [Zellij](https://github.com/zellij-org/zellij)
  - Code editor: [Neovim](https://github.com/neovim/neovim) with [AstroNvim config](https://github.com/AstroNvim/AstroNvim) (+ vim)
  - Password manager: [pass](https://www.passwordstore.org)

- Python:

  - Deps manager: [Poetry](https://github.com/python-poetry/poetry)
  - Version manager: [pyenv](https://github.com/pyenv/pyenv)

- Go:

  - Version manager: [goenv](https://github.com/go-nv/goenv)

- Git:

  - TUI: [lazygit](https://github.com/jesseduffield/lazygit)

- Containers:

  - [Docker desktop](https://www.docker.com/products/docker-desktop/)
  - [Podman desktop](https://github.com/podman-desktop/podman-desktop)

## Working environment configuration

Fish shell loads the `$HOME/.profile` file at startup. So this is a good place to define the necessary environment variables.

Template:

```
export HOMEBREW_HOME=/opt/homebrew
```

## Packages (via Homebrew)

Necessary packages:

```
brew install \
      duckdb \
      eza \
      fish \
      fx \
      git \
      goenv \
      httpie \
      kubernetes-cli \
      kubectx \
      lazydocker \
      lazygit \
      lua \
      luarocks \
      neovim \
      pass \
      pgcli \
      pyenv \
      starship \
      sqlite \
      typst \
      zellij
```

Casks:

```
brew install --cask \
        ghostty \
        podman-desktop \
        stats \
        vivaldi
```
