FROM python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    bash \
    git \
    curl \
    build-essential \
    gcc \
    make \
    python3-dev \
    libffi-dev \
    libssl-dev \
    rustc \
    cargo \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip setuptools wheel

# ----------------------------
# VOLATILITY3 in /opt
# ----------------------------
RUN git clone https://github.com/Frascott05/volatility3 /opt/volatility3

#ENV PYTHONPATH="/opt/volatility3"

WORKDIR /home/app/SilenTrace/
#RUN chmod +x /home/app/SilenTrace/start.sh

# Porta FastAPI
EXPOSE 9000

# Avvio
CMD ["/home/app/SilenTrace/start.sh"]
