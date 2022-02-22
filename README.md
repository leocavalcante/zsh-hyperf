# zsh-hyperf

This plugin adds an `hyperf` shell command with the following features:

* It will find and execute `php bin/hyperf.php` from anywhere within the project file tree
  (and you don't need to prefix it with `php` or `./`)
* It provides auto-completion for `php bin/hyperf.php` commands (that also work anywhere
  within the project).
* You can specify an editor to automatically open new files created by `php bin/hyperf.php
  gen:*` commands

## Requirements

* [zsh](https://www.zsh.org/)
* [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
* A [Hyperf](https://hyperf.io/) project

## Installation

### [Antigen](https://github.com/zsh-users/antigen)

Add the following bundle to your `.zshrc`:

```zsh
antigen bundle leocavalcante/zsh-hyperf
```

### Oh-my-zsh

First download the plugin to your oh-my-zsh custom plugin location:

```zsh
git clone https://github.com/leocavalcante/zsh-hyperf.git ~/.oh-my-zsh/custom/plugins/hyperf
```

> Note that the repository name is prefixed with `zsh-`, however the plugin
> directory name should just be "hyperf".

Then enable the plugin in your `.zshrc` file. For example:

```zsh
plugins=(
    hyperf
    composer
    git
)
```

## Configuration

If you wish to automatically open new files created by `php bin/hyperf.php gen:*` commands
then you will need to configure the `HYPERF_OPEN_ON_GEN_EDITOR` environment
variable. The best place for this is probably your `.zshrc` file. For example:

```zsh
HYPERF_OPEN_ON_GEN_EDITOR=vim
#HYPERF_OPEN_ON_GEN_EDITOR=subl   # Sublime Text
#HYPERF_OPEN_ON_GEN_EDITOR=pstorm # PHPStorm
#HYPERF_OPEN_ON_GEN_EDITOR=atom   # Atom (May require shell commands to be enabled)
#HYPERF_OPEN_ON_GEN_EDITOR=code   # VSCode (May require shell commands to be enabled)
```

> The author uses [mhinz/neovim-remote](https://github.com/mhinz/neovim-remote),
combined with a wrapper script, to automatically open files in an existing neovim
session within the same tmux session, and automatically switch to the correct
tmux window (tab).

Note that you will need to re-source your `.zshrc` or restart `zsh` to pick up
the changes.

## Usage

Simply use the command `hyperf` from anywhere within the directory structure of
a Hyperf project and it will search up the tree for the `bin/hyperf.php` command and
execute it. E.g:

```zshrc
$ pwd
~/MyProject/tests/Feature

$ hyperf gen:model MyAwesomeModel
Model created successfully.
```

Tab-completion will work anywhere that `hyperf` can be found, and the available
commands are retrieved on-demand. This means that you will see any Hyperf
commands that are available to you, including any custom commands that have
been defined.

If you configured the `HYPERF_OPEN_ON_GEN_EDITOR` environment variable, any
files created by `hyperf gen:*` commands should automatically be opened,
including when multiple files are created (E.g. by `hyperf gen:model -m -c -r`)

The plugin does not create any aliases for you, but the author would like to
offer some suggestions:

```zsh
alias h="hyperf"
alias serve="hyperf start"
```

## License

This project is open-sourced software licensed under the MIT License - see the
[LICENSE](LICENSE) file for details

## Acknowledgements

* [jessarcher/zsh-artisan](https://github.com/jessarcher/zsh-artisan)
  for the initial Zsh plugin
* [antonioribeiro/artisan-anywhere](https://github.com/antonioribeiro/artisan-anywhere)
  for some of the initial artisan location logic
* The `laravel5` plugin that comes with oh-my-zsh for the initial completion
  logic
* [ahuggins/open-on-make](https://github.com/ahuggins/open-on-make) for the
  "open on make" functionality idea. Unfortunately, adding a dev dependency like
  this isn't an option on some of the projects I work on.
