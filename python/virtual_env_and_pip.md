# Python3 virtual environment and dependencies with pipenv

- You no longer need to use pip and virtualenv separately.
- Hashes are used everywhere, always. Security. Automatically expose security vulnerabilities.
- Give insight into dependency graph (`pipenv graph`)

#### Install

`python3 -m pip install --user pipenv`

#### Where

```bash
python3 -m site --user-base
# /Users/foobar/Library/Python/3.9
ls /Users/bobbyy/Library/Python/3.9/bin/pipenv
```

#### Set bash/zsh profile

```bash
echo -n 'export PATH=/Users/bobbyy/Library/Python/3.9/bin:$PATH' >> ~/.zshrc
echo -n 'PIPENV_IN_PROJECT_=1' >> ~/.zshrc
```

If you hit `Warning: the environment variable LANG is not set!` then add this to the terminal profile:

```bash
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
```

#### Use

```bash
pipenv shell
cat Pipfile   
```

