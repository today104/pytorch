FROM pytorch/pytorch:2.1.2-cuda11.8-cudnn8-runtime
RUN conda install python=3.10 -y
RUN pip install torch==2.1.2+cu118 torchvision==0.16.2+cu118 torchaudio==2.1.2+cu118 -f https://mirrors.aliyun.com/pytorch-wheels/cu118
RUN pip install scikit-learn pandas
RUN pip install numpy

# RUN apt-get update && apt-get install -y \
#     libgl1-mesa-glx \
#     libglib2.0-0 \
#     libsm6 \
#     libxext6 \
#     libxrender-dev \
#     libpci-dev \
#     curl \
#     nano \
#     psmisc \
#     zip \
#     git \
#     wget \
#     build-essential \
#     && apt-get clean \
#     && rm -rf /var/lib/apt/lists/*

# RUN apt-get update && apt-get install -y \
#     git \
#     build-essential \
#     cmake \
#     ninja-build \
#     && rm -rf /var/lib/apt/lists/*


RUN export DEBIAN_FRONTEND=noninteractive \
    && export TZ=Etc/UTC \
    && apt-get update \
    && apt-get install -y \
       git \
       build-essential \
       cmake \
       ninja-build \
    && rm -rf /var/lib/apt/lists/*

# RUN pip install git wget -y

RUN pip install packaging && \
    pip install timm && \
    pip install pytest chardet yacs termcolor
    
RUN pip install submitit tensorboardX

RUN pip install scikit-learn matplotlib thop h5py SimpleITK

RUN pip install opencv-python matplotlib tqdm wheel scipy

# RUN pip install triton==2.2.0
# RUN pip install mamba-ssm>=1.0.1
# RUN pip install causal-conv1d>=1.0.0

RUN pip install triton==2.2.0
RUN pip install "causal-conv1d @ git+https://github.com/Dao-AILab/causal-conv1d.git@v1.1.3"
RUN pip cache purge
RUN pip install "mamba-ssm @ git+https://github.com/state-spaces/mamba.git@v1.1.4"

COPY ./fonts/* /opt/conda/lib/python3.10/site-packages/matplotlib/mpl-data/fonts/ttf/
