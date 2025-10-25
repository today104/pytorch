FROM pytorch/pytorch:1.13.0-cuda11.6-cudnn8-devel

RUN pip install torch==2.2.0 torchvision==0.17.0 torchaudio==2.2.0 --index-url https://download.pytorch.org/whl/cu121

RUN apt-get update && apt-get install -y libgl1-mesa-glx libpci-dev curl nano psmisc zip git && apt-get --fix-broken install -y

RUN pip install scikit-learn pandas flake8 yapf isort yacs future libgcc

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
    pip install timm==0.4.12 && \
    pip install pytest chardet yacs termcolor && \
    pip install submitit tensorboardX && \
    pip install triton==2.0.0 && \
    # pip install causal_conv1d==1.0.0 \
    # pip install mamba_ssm==1.0.1 \
    pip install scikit-learn matplotlib thop h5py SimpleITK scikit-image medpy yacs
    
RUN pip install "causal-conv1d @ git+https://github.com/Dao-AILab/causal-conv1d.git"
RUN pip install "mamba-ssm @ git+https://github.com/state-spaces/mamba.git"    

# RUN pip install --upgrade pip && python -m pip install --upgrade setuptools && \
 RUN  pip install opencv-python tb-nightly matplotlib logger_tt tabulate tqdm wheel mccabe scipy

COPY ./fonts/* /opt/conda/lib/python3.10/site-packages/matplotlib/mpl-data/fonts/ttf/
