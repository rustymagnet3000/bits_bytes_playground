## Python3 Clean setup
##### Package Manager ( pip )
```
python3 -m pip install --user --upgrade pip
python3 -m pip --version
```
##### Create and Activate Virtual Environment
```
python3 -m pip install --user virtualenv
python3 -m venv ydvenv
source ydvenv/bin/activate 		#activate virtual environment
pip3 install -r requirements.txt
```
##### Check virtual environment pointing to correct Python
```
▶ source ~/ydvenv/bin/activate    
(ydvenv)
which python
```
##### Deactive Virtual Environment
```
deactivate
```

