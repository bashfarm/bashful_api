#!/bin/bash

# if [ -f model.ckpt ]; then
#     echo "model.ckpt file found locally."
# else
#     echo "model.ckpt file not found locally. Downloading from https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.ckpt"
#     curl --progress-bar -L -o models/Stable-diffusion/model.ckpt https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.ckpt
#     echo "Model downloaded and saved as model.ckpt."
# fi

if [ -f models/Stable-diffusion/model.ckpt ]; then
    echo "model.ckpt file found locally."
else
    echo "model.ckpt file not found locally. Downloading from https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.ckpt"
    curl --progress-bar -L -o models/Stable-diffusion/model.ckpt https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.ckpt
    echo "Model downloaded."
fi


# Call the appropriate script based on the current operating system
if [ "$(uname)" == "Darwin" ]; then
    ./webui-user.sh
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    ./webui-user.sh
elif [ "${PROCESSOR_ARCHITECTURE}" == "AMD64" ]; then
    ./webui-user.bat
elif [ "${PROCESSOR_ARCHITECTURE}" == "x86" ]; then
    ./webui-user.bat
elif [ "$(uname)" == "Mac" ]; then
    ./webui-user.sh
else
    echo "Unsupported operating system."
fi
