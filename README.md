# SilenTrace-backend
Backend APIs of the SilenTrace project: 
The idea behind this repository is to only have the backend avaible, for a lot of different reasons
- deploy on a remote server (for example with Coolify)
- create more efficently a custom front-end
- Use the API backend as Tools for an AI Agent for a complete automation


### .env configurations
In addition to the files in the project, you need to add a `.env` file with the following configuration:
```bash
APP_NAME=SilentraceGUI

VOLATILITY_PATH=/opt/volatility3/vol.py
DUMPS_PATH=/home/app/SilenTrace/dumps

ALLOWED_ORIGINS=*
PORT_BACKEND=9000
```
NOTE: you have to install Volatility3 and set the path in the .env file

### dumps folder
As you can see from the `.env` file there is a path for the folder that will contain the dumps to analyze. It is Imperative that the folder
is in the same root as the backend folder:

|

|- backend

|- dumps
    | example.mem
    | -investigation1
        | first.vmem

### docker commands
To use the docker files create the image with the following command:

```bash
docker compose build
```
And for activate the docker:
```bash
docker compose up
```

