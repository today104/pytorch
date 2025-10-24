FROM pytorch/pytorch:1.13.0-cuda11.7-cudnn8-devel

# 设置工作目录
WORKDIR /workspace

# 安装系统依赖
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

# 创建 Python 3.8 环境（基础镜像已经是 Python 3.8+，不需要重新安装）
# 如果需要特定版本，使用 conda 创建新环境
RUN conda create -n vmunet python=3.8 && \
    conda activate vmunet
# 使用 conda 安装包
RUN conda install -y \
    faiss-gpu \
    scikit-learn \
    pandas \
    flake8 \
    yapf \
    isort \
    yacs \
    gdown \
    future \
    libgcc \
    scipy \
    h5py \
    SimpleITK \
    scikit-image \
    medpy \
    -c conda-forge

# 使用 pip 安装包
RUN pip install --upgrade pip && \
    pip install \
    opencv-python \
    tb-nightly \
    matplotlib \
    logger_tt \
    tabulate \
    tqdm \
    wheel \
    mccabe \
    timm==0.4.12 \
    packaging \
    pytest \
    chardet \
    termcolor \
    submitit \
    tensorboardX \
    triton==2.0.0 \
    thop

# 安装 Mamba 相关包（VM-UNet 核心依赖）
RUN pip install \
    causal_conv1d==1.0.0 \
    mamba_ssm==1.0.1

# 复制字体文件（如果确实需要）
# COPY ./fonts/* /opt/conda/lib/python3.10/site-packages/matplotlib/mpl-data/fonts/ttf/

# 设置环境变量
ENV PYTHONPATH=/workspace
ENV CUDA_VISIBLE_DEVICES=0

# 验证安装
RUN python -c "import torch; print(f'PyTorch: {torch.__version__}, CUDA: {torch.version.cuda}')" && \
    python -c "import mamba_ssm; print('Mamba installed successfully')" && \
    python -c "import cv2, sklearn, pandas, matplotlib; print('Basic packages installed')"

CMD ["/bin/bash"]
