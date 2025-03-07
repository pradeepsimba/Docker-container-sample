# Use an official Python image
FROM python:latest

# Set up a global virtual environment
RUN python -m venv /opt/venv

# Activate the virtual environment
ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /app

COPY . /app/

RUN pip install --upgrade pip

RUN pip install --no-cache-dir -r req.txt
