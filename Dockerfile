# Use full Python (needed for build tools)
FROM python:3.10

ENV DEBIAN_FRONTEND=noninteractive

# ===== System dependencies =====
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget git build-essential cmake libglib2.0-dev libgl1 \
    python3-dev libpq-dev libjpeg-dev libpng-dev poppler-utils \
    && rm -rf /var/lib/apt/lists/*

# ===== Install Miniforge (NO TOS required) =====
RUN wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh -O miniforge.sh \
    && bash miniforge.sh -b -p /opt/conda \
    && rm miniforge.sh

ENV PATH="/opt/conda/bin:$PATH"

# ===== Install mamba (FASTER than conda) =====
RUN conda install -y -n base -c conda-forge mamba

# ===== Create environment using mamba (VERY FAST) =====
RUN mamba create -y -n dup python=3.10 \
    faiss-cpu \
    pytorch \
    torchvision \
    numpy \
    pillow \
    tqdm \
    opencv \
    git

# ===== Install CLIP + ArcFace + Extra Python Packages =====
RUN /opt/conda/envs/dup/bin/pip install --no-cache-dir \
    ftfy regex \
    git+https://github.com/openai/CLIP.git \
    facenet-pytorch \
    alembic \
    asgiref \
    beautifulsoup4 \
    bcrypt \
    bitarray \
    boto3 \
    bs4 \
    certifi \
    charset-normalizer \
    django-cors-headers \
    django-environ \
    django-extensions \
    djangorestframework \
    Django \
    distro \
    fastapi \
    firebase-admin \
    gunicorn \
    idna \
    JPype1 \
    mysql-connector-python \
    openpyxl \
    opencv-python \
    packaging \
    pandas \
    pdf2image \
    pdfplumber \
    pdfreader \
    PyPDF2 \
    protobuf \
    psycopg2-binary \
    pycryptodome \
    pymupdf \
    pyOpenSSL \
    python-dateutil \
    python-dotenv \
    python-multipart \
    pytz \
    reportlab \
    requests \
    scikit-image \
    six \
    soupsieve \
    sqlalchemy \
    sqlparse==0.4.4 \
    python-dotenv \
    typing_extensions \
    tzdata \
    urllib3 \
    uvicorn \
    Werkzeug \
    scikit-learn
