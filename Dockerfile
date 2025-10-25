FROM pytorch/pytorch:1.13.0-cuda11.6-cudnn8-devel
RUN pip install torch==2.2.0 torchvision==0.17.0 torchaudio==2.2.0 --index-url https://download.pytorch.org/whl/cu121
RUN apt-get update && apt-get install -y libgl1-mesa-glx libpci-dev curl nano psmisc zip git && apt-get --fix-broken install -y

RUN pip install scikit-learn pandas

RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libpci-dev \
    curl \
    nano \
    psmisc \
    zip \
    git \
    wget \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install packaging && \
    pip install timm && \
    pip install pytest chardet yacs termcolor && \
    pip install tensorboardX && \
    pip install triton
    
RUN pip install scikit-learn matplotlib thop h5py SimpleITK

RUN pip install opencv-python matplotlib tqdm wheel scipy

RUN pip install "mamba-ssm @ git+https://github.com/state-spaces/mamba.git@v1.0.1"
RUN pip install "causal-conv1d @ git+https://github.com/Dao-AILab/causal-conv1d.git@v1.0.0"

COPY ./fonts/* /opt/conda/lib/python3.10/site-packages/matplotlib/mpl-data/fonts/ttf/
