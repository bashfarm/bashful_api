#!/bin/bash
#!/bin/bash

# Check if Python is already installed
if command -v python3 &>/dev/null; then
    echo "Python is already installed"
else
    # Install Python 3.10.6 and add it to PATH
    curl -LO https://www.python.org/ftp/python/3.10.6/python-3.10.6-amd64.exe
    msiexec /i python-3.10.6-amd64.exe /quiet TARGETDIR=C:\Python3106
    export PATH=$PATH:/c/Python3106:/c/Python3106/Scripts
fi

# Check if Git is already installed
if command -v git &>/dev/null; then
    echo "Git is already installed"
else
    # Install Git
    curl -LO https://github.com/git-for-windows/git/releases/download/v2.34.1.windows.1/Git-2.34.1-64-bit.exe
    cmd.exe /c Git-2.34.1-64-bit.exe /VERYSILENT
fi


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
