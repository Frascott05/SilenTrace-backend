#!/bin/bash

# Carica variabili dal .env
export $(grep -v '^#' .env | xargs)

# Setup backend (Python)
echo "Installazione dipendenze backend..."
(
    cd backend || exit
    pip install -r requirements.txt --break-system-packages
)

# Avvia il backend FastAPI
echo "Avvio backend..."
(
    cd backend || exit
    uvicorn app.main:app --host 0.0.0.0 --port $PORT_BACKEND --reload
) &

BACKEND_PID=$!


echo "Backend PID: $BACKEND_PID"
echo "Premi CTRL+C per terminare."

trap "echo 'Interruzione...'; kill $BACKEND_PID; exit" INT

wait