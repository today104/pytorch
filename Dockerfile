FROM pytorch/pytorch:2.5.0-cuda12.1-cudnn9-devel
RUN conda install python=3.10 -y
RUN pip install torch==2.5.1 torchvision==0.20.1 torchaudio==2.5.1 --index-url https://download.pytorch.org/whl/cu121

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

RUN pip install git wget

RUN pip install packaging && \
    pip install timm && \
    pip install pytest chardet yacs termcolor
    
RUN pip install submitit tensorboardX

RUN pip install scikit-learn matplotlib thop h5py SimpleITK

RUN pip install opencv-python matplotlib tqdm wheel scipy

RUN pip install triton==2.2.0
RUN pip install "mamba-ssm @ git+https://github.com/state-spaces/mamba.git@v1.0.1"
RUN pip install "causal-conv1d @ git+https://github.com/Dao-AILab/causal-conv1d.git@v1.0.0"

COPY ./fonts/* /opt/conda/lib/python3.10/site-packages/matplotlib/mpl-data/fonts/ttf/
