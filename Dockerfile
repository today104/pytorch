FROM pytorch/pytorch:2.1.2-cuda11.8-cudnn8-runtime

# 1. 一次性安装所有系统依赖
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libpci-dev \
    curl \
    nano \
    psmisc \
    zip \
    git \
    build-essential \
    cmake \
    ninja-build \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 2. 确保 Python 版本（基础镜像可能已经是 3.10）
RUN conda install python=3.10 -y

# 3. PyTorch 相关（基础镜像已有，这是升级）
RUN pip install torch==2.1.2+cu118 torchvision==0.16.2+cu118 torchaudio==2.1.2+cu118 -f https://mirrors.aliyun.com/pytorch-wheels/cu118

# 4. 一次性安装所有 Python 包
RUN pip install --upgrade pip setuptools wheel && \
    pip install \
    scikit-learn \
    pandas \
    numpy \
    scipy \
    matplotlib \
    opencv-python \
    tqdm \
    scikit-image \
    thop \
    h5py \
    SimpleITK \
    timm \
    pytest \
    chardet \
    yacs \
    termcolor \
    submitit \
    tensorboardX \
    medpy \
    tb-nightly \
    logger_tt \
    tabulate \
    mccabe

# 5. Conda 包（只安装 pip 没有的）
RUN conda install -y \
    faiss-gpu \
    flake8 \
    yapf \
    isort \
    gdown \
    future \
    libgcc \
    -c conda-forge

# 6. 清理缓存
RUN pip cache purge && \
    conda clean -a -y

RUN pip install triton==2.2.0

# RUN pip install causal-conv1d>=1.0.0
# RUN pip cache purge
# RUN pip install mamba-ssm>=1.0.1

RUN pip install "causal-conv1d @ git+https://github.com/Dao-AILab/causal-conv1d.git@v1.1.3"
RUN pip cache purge
RUN pip install "mamba-ssm @ git+https://github.com/state-spaces/mamba.git@v1.1.4"

COPY ./fonts/* /opt/conda/lib/python3.10/site-packages/matplotlib/mpl-data/fonts/ttf/
