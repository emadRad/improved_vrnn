FROM nvidia/cuda:9.2-runtime-ubuntu18.04

RUN apt-get update && apt-get install -y \
		curl \
		sudo \
		build-essential \
		vim \
		wget \
		python3-yaml \
		git \
		unzip \
		ca-certificates \
		bzip2 \
        ffmpeg \
        libsm6 \
       libxext6

RUN mkdir /src
RUN chmod 755 /src

# Install Miniconda and create main env
ADD https://repo.anaconda.com/miniconda/Miniconda3-py37_4.9.2-Linux-x86_64.sh miniconda3.sh
RUN /bin/bash miniconda3.sh -b -p /conda \
    && echo export PATH=/conda/bin:$PATH >> .bashrc \
    && rm miniconda3.sh
ENV PATH="/conda/bin:${PATH}"

# Switch to bash shell
SHELL ["/bin/bash", "-c"]


RUN conda install pytorch=0.4.1 cuda92 -c pytorch
RUN conda install imageio=2.4.1 joblib=0.12.5 matplotlib=3.0.1 numpy=1.15.4 opencv=3.4.2
RUN conda install scikit-image=0.14.0 scipy=1.1.0 torchvision=0.2.1 tqdm=4.28.1 pillow=5.3.0
RUN pip install parse

ENV HOME=/src
ENV PYTHONPATH=/src
WORKDIR /src