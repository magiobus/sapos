#!/bin/bash

if [ "$(whoami)" != "rails" ]; then
echo "Cannot run this script as root. You must sudo to the 'rails' user."
exit -1;
fi

export HOME="/home/rails"

if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
source "$HOME/.rvm/scripts/rvm";
fi

cd /home/rails/sapos

unicorn -p 30001
