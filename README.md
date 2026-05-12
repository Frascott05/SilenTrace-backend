# SilenTrace-backend
Backend APIs of the SilenTrace project: https://github.com/Frascott05/SilenTrace
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
NOTE: If you don't use docker, you have to install Volatility3 and set the path in the .env file

### dumps folder
As you can see from the `.env` file there is a path for the folder that will contain the dumps to analyze. It is Imperative that the folder
is in the same root as the backend folder

### docker commands
To use the docker files create the image with the following command:

```bash
docker compose build
```
And for activate the docker:
```bash
docker compose up
```




## API DOCUMENTATION

### GET /
This one is just a check for see if the service is up

### POST /run

Starting the execution of Volatility plugin on a memory dump.

**Request body:**

```json
{
  "memory_file": "/path/to/memory.dmp",
  "plugins": ["pslist", "netscan", "registry.printkey"],
  "os": "windows",
  "address": null,
  "dump": false,
  "process": null
}
```
Note that the plugins in the plugin list must be used like that, not with the full name of the plugin (for example windows.pslist.Pslist become just pslist)
The "address" value can be a virtual memory address or null
The "process" value can be a process pid or null
The "dump" value can be used for dumping results but i suggest to set it to false always
**Response:**

```json
{
  "job_id": "abc123"
}
```

---

### GET /status/{job_id}

Job results state.

**Response:**

```json
{
  "job_id": "abc123",
  "status": "running | done"
}
```

---

### GET /results/{job_id}

Getting analysis result.

**Response:**

```json
{
  "results": {
    "pslist": [
      {
        "pid": 1234,
        "name": "explorer.exe"
      }
    ]
  }
}
```

---

### POST /plugin-list

Gaining the plugin list avaible for the operative system.

**Request:**

```json
{
  "os": "windows"
}
```

**Response:**

```json
{
  "plugins": ["pslist", "netscan", "malfind"]
}
```

---

### POST /timeline

Starts the parsing for the timeline on a memory dump (windows only for now).

**Request:**

```json
{
  "memory_file": "/path/to/memory.dmp",
  "os": "windows"
}
```

**Response:**

```json
{
  "job_id": "abc123"
}
```

---

## 🔄 Workflow

1. `/plugin-list`
2. `/run` o `/timeline`
3. `/status/{job_id}`
4. `/results/{job_id}`

---

## ▶️ Server started (if you don't use docker)

```bash
uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
```
