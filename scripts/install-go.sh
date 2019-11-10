#!/bin/bash

set -e

if [ -z $1 ]; then 
	echo "please pass the desired go version as an argument" 
	exit 1
fi	

GO_VER=$1
GO_PKG=go${GO_VER}.linux-amd64.tar.gz

cd /tmp
curl -LO https://dl.google.com/go/${GO_PKG}
tar -xf ${GO_PKG}
rm -f ${GO_PKG}
mv go ~/.go${GO_VER}
mkdir -p ~/go/src/github.com ~/go/bin ~/go/pkg

cat >> ~/.bashrc <<EOL

export GOPATH=\$HOME/go
export GOROOT=\$HOME/.go${GO_VER}
export PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH

EOL

echo "Go ${GO_VER} installed."
echo "Please source ~/.bashrc."