# Python3 Clean setup

##### Package Manager ( pip )

```bash
python3 -m pip install --user --upgrade pip
python3 -m pip --version
```

##### Create and Activate Virtual Environment

```bash
python3 -m pip install --user virtualenv
python3 -m venv ydvenv
source ydvenv/bin/activate 		#activate virtual environment
pip3 install -r requirements.txt
```

##### Check virtual environment pointing to correct Python

```bash
▶ source ~/ydvenv/bin/activate    
(ydvenv)
which python
```

##### Deactive Virtual Environment

```bash
deactivate
```
