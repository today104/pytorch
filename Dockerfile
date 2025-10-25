FROM pytorch/pytorch:2.2.0-cuda11.8-cudnn8-devel

# 设置环境变量
ENV DEBIAN_FRONTEND=noninteractive

# 一次性安装所有系统依赖
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

# Conda 安装
RUN conda install -y scikit-learn pandas flake8 yapf isort yacs future libgcc
    

# 升级 pip
RUN pip install --upgrade pip setuptools wheel

# 安装 Python 依赖
RUN pip install \
    packaging \
    pytest chardet termcolor \
    submitit tensorboardX \
    matplotlib thop h5py SimpleITK scikit-image medpy \
    opencv-python tb-nightly logger_tt tabulate seaborn fvcore mccabe scipy \
    certifi==2022.12.7 \
    charset-normalizer==2.1.1 \
    einops==0.8.0 \
    filelock==3.13.1 \
    fsspec==2024.2.0 \
    huggingface-hub==0.23.0 \
    idna==3.4iopath==0.1.10 \
    hydra-core \
    pytorch_lightning \
    MarkupSafe==2.1.5 \
    mpmath==1.3.0 \
    networkx==3.2.1 \
    ninja \
    numpy==1.24.4 \
    pillow==10.2.0 \
    portalocker==2.8.2 \
    PyYAML==6.0.1 \
    requests==2.28.1 \
    safetensors==0.4.3 \
    selective-scan  \
    sympy==1.12tabulate==0.9.0 \
    termcolor==2.4.0 \
    timm==0.4.12 \
    tqdm==4.66.4 \
    triton==2.1.0 \
    typing_extensions==4.9.0 \
    urllib3==1.26.13
    
   
# 准备字体目录
RUN mkdir -p /opt/conda/lib/python3.10/site-packages/matplotlib/mpl-data/fonts/ttf/
COPY ./fonts/* /opt/conda/lib/python3.10/site-packages/matplotlib/mpl-data/fonts/ttf/

# 验证安装
RUN python -c "import torch, sklearn, python, matplotlib; print('All core packages installed successfully')"

WORKDIR /workspace
