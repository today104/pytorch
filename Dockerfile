FROM pytorch/pytorch:2.1.2-cuda11.8-cudnn8-runtime

# ========== 【关键修复】非交互式环境 ==========
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai
# ===========================================

# ========== GPU优化环境变量 ==========
ENV CUDA_VISIBLE_DEVICES=0
ENV TF_GPU_ALLOCATOR=cuda_malloc_async
ENV TF_FORCE_GPU_ALLOW_GROWTH=true
ENV OMP_NUM_THREADS=1
ENV MKL_NUM_THREADS=1
ENV PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:128
ENV NCCL_DEBUG=WARN
ENV NCCL_IB_DISABLE=1
ENV NCCL_SOCKET_IFNAME=eth0
# ====================================

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

# 设置时区（避免后续问题）
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

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

RUN pip install "causal-conv1d @ git+https://github.com/Dao-AILab/causal-conv1d.git@v1.1.3"
RUN pip cache purge
RUN pip install "mamba-ssm @ git+https://github.com/state-spaces/mamba.git@v1.1.4"

# GPU优化配置文件
RUN echo 'import torch\n\
torch.backends.cuda.matmul.allow_tf32 = True\n\
torch.backends.cudnn.allow_tf32 = True\n\
torch.backends.cudnn.benchmark = True\n\
torch.backends.cudnn.deterministic = False\n\
torch.set_float32_matmul_precision("high")\n\
print("GPU优化配置已启用: TF32=True, cudnn.benchmark=True")\n\
' > /opt/gpu_optimize.py

COPY ./fonts/* /opt/conda/lib/python3.10/site-packages/matplotlib/mpl-data/fonts/ttf/
