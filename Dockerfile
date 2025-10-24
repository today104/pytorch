FROM pytorch/pytorch:1.13.1-cuda11.6-cudnn8-devel

RUN apt-get update && apt-get install -y libgl1-mesa-glx libpci-dev curl nano psmisc zip git && apt-get --fix-broken install -y

RUN pip install torch==1.13.0 torchvision==0.14.0 torchaudio==0.13.0 --extra-index-url https://download.pytorch.org/whl/cu117 && \
    pip install packaging && \
    pip install timm==0.4.12 && \
    pip install pytest chardet yacs termcolor && \
    pip install submitit tensorboardX && \
    pip install triton==2.0.0 && \
    pip install causal_conv1d==1.0.0  && \ 
    pip install mamba_ssm==1.0.1  && \
    pip install scikit-learn matplotlib thop h5py SimpleITK scikit-image medpy yacs

RUN conda install -y faiss-gpu scikit-learn pandas flake8 yapf isort yacs gdown future libgcc -c conda-forge

RUN pip install --upgrade pip && python -m pip install --upgrade setuptools && \
    pip install opencv-python tb-nightly matplotlib logger_tt tabulate tqdm wheel mccabe scipy

COPY ./fonts/* /opt/conda/lib/python3.10/site-packages/matplotlib/mpl-data/fonts/ttf/
