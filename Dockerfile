FROM pytorch/pytorch:1.13.0-cuda11.6-cudnn8-devel

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
    timm==0.4.12 \
    pytest chardet termcolor \
    submitit tensorboardX \
    triton==2.0.0 \
    causal_conv1d==1.0.0 \
    mamba_ssm==1.0.1 \
    matplotlib thop h5py SimpleITK scikit-image medpy \
    opencv-python tb-nightly logger_tt tabulate tqdm mccabe scipy

# 准备字体目录
RUN mkdir -p /opt/conda/lib/python3.10/site-packages/matplotlib/mpl-data/fonts/ttf/
COPY ./fonts/* /opt/conda/lib/python3.10/site-packages/matplotlib/mpl-data/fonts/ttf/

# 验证安装
RUN python -c "import torch, sklearn, matplotlib; print('All core packages installed successfully')"

WORKDIR /workspace
