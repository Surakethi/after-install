#!/bin/bash

### Your default information
SUDO_USER='widiastono'

### root vim install
sh vim.install.sh

### SUDO_USER vim install
su - $SUDO_USER sh vim.install