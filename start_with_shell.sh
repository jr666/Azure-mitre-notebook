#!/bin/bash

docker run -it --rm --gpus all --name jr666_mitre_notebook -p 8888:8888 jr666/mitre-notebook:latest /bin/bash

