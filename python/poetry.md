# Python3

## Poetry dependency manager

#### Install

`curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3`

#### Set bash/zsh profile

< `export PATH="$HOME/.poetry/bin:$PATH"` not required >

Pycharm integration

#### Add to existing project

`poetry init`

#### Add

```bash
poetry --version
poetry check
poetry install
poetry build
```

#### Show latest versions available

`poetry show --latest`

#### Dependencies and sub-dependencies

`poetry show --tree`
