#!/bin/sh

if ! curl -sL --fail https://google.com -o /dev/null; then
    echo 'Error: curl command is not installed' >&2
    exit 1
fi

if ! [ -x "$(command -v unzip)" ]; then
    echo 'Error: unzip command is not installed' >&2
    exit 1
fi

curl -LO https://github.com/testappio/cli/releases/latest/download/ta-cli_linux.zip

unzip ta-cli_linux.zip
rm -rf ta-cli_linux.zip

chmod +x ta-cli_linux/ta-cli

INSTALL_PATH=/usr/local/bin/ta-cli

mv ta-cli_linux/ta-cli $INSTALL_PATH

if ! [ $? -eq 0 ]; then
    echo "Failed to copy to $INSTALL_PATH - please use sudo with this command or contact us for more help"
    rm -rf ta-cli_linux
    exit
fi

rm -rf ta-cli_linux

echo
echo 'Running ta-cli config'

ta-cli config

echo "ta-cli successfully installed in $INSTALL_PATH"
