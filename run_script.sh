#!/bin/zsh
clear
echo
docker run -it --rm --name php-demo -v "$PWD":/usr/src/myapp -w /usr/src/myapp php:8.2-cli php script.php
echo