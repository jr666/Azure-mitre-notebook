FROM python:3.8-slim-buster
#FROM jupyter/base-notebook

USER root

WORKDIR /app

# Set desired Python version
ENV python_version 3.8

RUN apt-get update

# Install desired Python version (the current TF image is be based on Ubuntu at the moment)
#RUN apt install -y python${python_version}

# Set default version for root user - modified version of this solution: https://jcutrer.com/linux/upgrade-python37-ubuntu1810
#RUN update-alternatives --install /usr/local/bin/python python /usr/bin/python${python_version} 1

# Update pip: https://packaging.python.org/tutorials/installing-packages/#ensure-pip-setuptools-and-wheel-are-up-to-date
RUN python -m pip install --upgrade pip setuptools wheel

# By copying over requirements first, we make sure that Docker will "cache"
# our installed requirements in a dedicated FS layer rather than reinstall
# them on every build
COPY requirements.txt requirements.txt

# Install Torch with it's weird requirements
RUN pip install torch==1.12.0 --extra-index-url https://download.pytorch.org/whl/cu116

# Install the requirements
RUN python -m pip install -r requirements.txt

RUN jupyter notebook --generate-config

# Add curl for testing
RUN apt-get install -y curl 

#COPY images images
#ARG src="MitreMap - Infer MITRE technique from Threat Intel Data.ipynb"
#COPY ${src} ${src}

COPY utils-1.1.1-py3-none-any.whl utils-1.1.1-py3-none-any.whl
RUN pip install utils-1.1.1-py3-none-any.whl

# Install ML model w&b
#RUN mkdir distilgpt2-512
#RUN cd distilgpt2-512
#RUN curl -L https://github.com/microsoft/msticpy-data/blob/mitre-inference/mitre-inference-models/distilgpt2-512/labels.json?raw=true -o "labels"
#RUN curl -L https://github.com/microsoft/msticpy-data/blob/mitre-inference/mitre-inference-models/distilgpt2-512/tokenizer?raw=true -o "tokenizer"
#RUN curl -L https://github.com/microsoft/msticpy-data/blob/mitre-inference/mitre-inference-models/distilgpt2-512/model_state_dicts?raw=true -o "model_state_dicts"
#RUN cd ..

CMD ["jupyter" , "notebook", "--no-browser", "--ip", "0.0.0.0", "--port", "8888", "--allow-root", "/notebook" ]

# Only needed for Jupyter
EXPOSE 8888


