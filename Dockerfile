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


# 基础依赖
RUN pip install \
    packaging pytest chardet termcolor \
    submitit tensorboardX \
    matplotlib thop h5py SimpleITK scikit-image medpy \
    opencv-python scipy mccabe seaborn

# VMamba 核心依赖
RUN pip install \
    causal-conv1d \
    mamba-ssm \
    triton==2.1.0 \
    timm==0.4.12 \
    einops==0.8.0 \
    numpy==1.24.4

# 其他工具
RUN pip install \
    tb-nightly logger_tt tabulate fvcore \
    ninja PyYAML==6.0.1 requests==2.28.1

# 字体和验证
RUN mkdir -p /opt/conda/lib/python3.10/site-packages/matplotlib/mpl-data/fonts/ttf/
COPY ./fonts/* /opt/conda/lib/python3.10/site-packages/matplotlib/mpl-data/fonts/ttf/ 2>/dev/null || true

RUN python -c "import torch; print(f'PyTorch: {torch.__version__}')"
RUN python -c "import mamba_ssm; print('VMamba ready')"

WORKDIR /workspace
