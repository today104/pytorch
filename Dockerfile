# 1. 使用基础镜像
FROM pytorch/pytorch:2.1.2-cuda11.8-cudnn8-devel

# 2. 设置环境变量（解决你之前的 tzdata 挂起问题）
ENV DEBIAN_FRONTEND=noninteractive

# 3. 合并所有的 apt-get 系统依赖安装
# 将 git 和 wget 放在这里，比在 conda 中安装更快、更稳
RUN apt-get update && apt-get install -y \
    git \
    wget \
    build-essential \
    cmake \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

# 4. 更新 Conda 和 Python 环境（如果基础镜像不是 3.10，建议在这里统一）
# 删除了原有的 RUN conda install git wget -y，因为它会导致你遇到的错误
RUN conda install python=3.10 -y && \
    conda clean -ya

# 5. 合并所有的 Pip 安装（通过一条命令安装可以极大减少镜像层数）
# 按照依赖关系，先装核心库，再装从 GitHub 编译的库
RUN pip install --no-cache-dir \
    packaging \
    numpy==1.24.3 \
    scikit-learn \
    pandas \
    matplotlib \
    timm \
    pytest \
    chardet \
    yacs \
    termcolor \
    submitit \
    tensorboardX \
    thop \
    h5py \
    SimpleITK \
    opencv-python \
    tqdm \
    wheel \
    scipy \
    triton==2.1.0

# 6. 安装需要从 Git 编译的特定库
# 提前安装好依赖并开启 ninja 编译能加快速度
RUN pip install "causal-conv1d @ git+https://github.com/Dao-AILab/causal-conv1d.git@v1.1.3" && \
    pip install "mamba-ssm @ git+https://github.com/state-spaces/mamba.git@v1.1.4" && \
    pip cache purge

# 7. 拷贝字体文件
COPY ./fonts/* /opt/conda/lib/python3.10/site-packages/matplotlib/mpl-data/fonts/ttf/
