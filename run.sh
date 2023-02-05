#!/bin/bash

#docker run -it --rm --gpus all --name jr666_mitre_notebook -v $(pwd):/app -p 8888:8888 jr666/mitre-notebook:latest /bin/bash
#docker run -it --rm --gpus all --name jr666_mitre_notebook -v $(pwd):/app -p 8888:8888 jr666/mitre-notebook:latest jupyter notebook --no-browser --ip 0.0.0.0 --port 8888 --allow-root
docker run -it --rm --gpus all --name jr666_mitre_notebook -v $(pwd)/notebook:/notebook -p 8888:8888 jr666/mitre-notebook:latest

