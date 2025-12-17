FROM pytorch/pytorch:2.1.2-cuda11.8-cudnn8-devel
RUN conda install python=3.10 -y
RUN pip install torch==2.1.2 torchvision==0.16.2 torchaudio==2.1.2 --index-url https://download.pytorch.org/whl/cu118
RUN pip install scikit-learn pandas
RUN pip install numpy==1.24.3
RUN pip install transformers==4.36.0




RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    cmake \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

RUN conda install git wget -y

RUN pip install packaging && \
    pip install timm && \
    pip install pytest chardet yacs termcolor
    
RUN pip install submitit tensorboardX

RUN pip install scikit-learn matplotlib thop h5py SimpleITK

RUN pip install opencv-python matplotlib tqdm wheel scipy

RUN pip install triton==2.1.0
RUN pip install "causal-conv1d @ git+https://github.com/Dao-AILab/causal-conv1d.git@v1.1.3"
RUN pip cache purge
RUN pip install "mamba-ssm @ git+https://github.com/state-spaces/mamba.git@v1.1.4"

COPY ./fonts/* /opt/conda/lib/python3.10/site-packages/matplotlib/mpl-data/fonts/ttf/
