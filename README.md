# dot local

A tiny tool for creating a local directory in a project that should not be published.

## Idea

Sometimes it is necessary to store additional information in sources and yet not publish it to a branch. The dl helps to ingenuously organize it.

```text
/Users/vanyauhalin
├─ .dl
│  └─ my-first-project-f98fa077fe ─┐
└─ my-first-project                │
   └─ .local  # Symbolic link to ──┘
```

When the dl is executed, it:

1. Creates a directory in dl's home directory with a name consisting of the current directory name and the hashed path to it.
2. Creates a symbolic link in the current directory to the directory created in the first step.

The dl's home directory, as well as the name of the directory created within the project, can be changed. Take a look at the [environment command](#dl-env) for more information on this.

## Installation

### Using Homebrew

```sh
curl -o dl.rb https://raw.githubusercontent.com/vanyauhalin/dl/main/dl.rb
brew install --build-from-source dl.rb
```

### Using a release binary

Download the [release binary](https://github.com/vanyauhalin/dl/releases).

## Uninstallation

To uninstall dl, just delete the dl home directory and dl mention in your shell configuration, if any.

## Usage

To start using dl enough to execute:

```sh
dl
```

To see the full list of available commands, execute:

```sh
dl --help
```

```text
OVERVIEW: A tiny tool for creating a local directory in a project that should
not be published.

USAGE: dl <subcommand>

OPTIONS:
  -h, --help              Show help information.

SUBCOMMANDS:
  clean                   Clean up dl-created directories.
  env                     Print commands to set up dl environment.
  version                 Print the current dl version.

  See 'dl help <subcommand>' for detailed help.
```

### `dl clean`

```text
OVERVIEW: Clean up dl-created directories.

USAGE: dl clean [--force]

OPTIONS:
  -f, --force             Clean up dl-created directories even if it is not
                          empty.
  -h, --help              Show help information.

```

### `dl env`

```text
OVERVIEW: Print commands to set up dl environment.

This is an optional command that generates a few commands that should be
evaluated by your shell to override default values.

Each shell has its own syntax of evaluating a dynamic expression. For example:

  - in Bash and Zsh would look like `eval "$(dl env)"`
  - in Fish would look like `eval (dl env)` or `dl env | source`

For more information about evaluation, please refer to your terminal's
documentation.

USAGE: dl env [--home <DL_HOME>] [--name <DL_NAME>]

OPTIONS:
  --home <DL_HOME>        The absolute path to the home directory where the
                          project-related files will be located. (default:
                          /Users/vanyauhalin/.dl)
  --name <DL_NAME>        The target name for a symbolic link in the project.
                          (default: .local)
  -h, --help              Show help information.

```

### `dl version`

```text
OVERVIEW: Print the current dl version.

USAGE: dl version

OPTIONS:
  -h, --help              Show help information.

```

## Development

Before you start development, you should install [make](https://www.gnu.org/software/make/) and [tuist](https://tuist.io). To start development enough to execute:

```sh
make install
```

To see the full list of available commands, execute:

```sh
make
```

```text
Welcome to vanyauhalin/dl sources.

Usage: make <subcommand>

Subcommands:
  analyze     Analyze the project via SwiftLint.
  build       Build the project via Tuist.
  clean       Clean generated Tuist files except for dependencies.
  dev         Generate a development workspace via Tuist.
  help        Show this message.
  install     Install dependencies and generate a development workspace
              via Tuist.
  lint        Lint the project and Tuist directory via SwiftLint.
  test        Test the project via Tuist.
```

## License

The repository code is distributed under the [MIT License](./LICENSE).
