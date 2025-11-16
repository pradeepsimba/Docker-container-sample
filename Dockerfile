# Use full Python (needed for build tools)
FROM python:3.10

ENV DEBIAN_FRONTEND=noninteractive

# ===== System dependencies =====
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget git build-essential cmake libglib2.0-dev libgl1 \
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

# ===== Install Python packages that are easier via pip (inside the env) =====
# - CLIP (OpenAI) from github
# - facenet-pytorch (ArcFace implementation + MTCNN)
# - small deps for unicode/regex handling
RUN /opt/conda/envs/dup/bin/pip install --no-cache-dir \
    ftfy regex \
    git+https://github.com/openai/CLIP.git \
    facenet-pytorch

RUN /opt/conda/envs/dup/bin/pip install --no-cache-dir -r req.txt
