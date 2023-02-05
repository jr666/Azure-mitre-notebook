FROM python:3.8-slim-buster
#FROM jupyter/base-notebook

USER root

WORKDIR /app

# Set desired Python version
ENV python_version 3.8

RUN apt-get update

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

COPY utils-1.1.1-py3-none-any.whl utils-1.1.1-py3-none-any.whl
RUN pip install utils-1.1.1-py3-none-any.whl

CMD ["jupyter" , "notebook", "--no-browser", "--ip", "0.0.0.0", "--port", "8888", "--allow-root", "/notebook" ]

# Only needed for Jupyter
EXPOSE 8888


