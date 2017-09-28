#!/bin/bash

if [[ -a /mnt/img-mnt/image ]]; then
echo "removing previous backup files"
rm /mnt/img-mnt/image
else
echo "No previous backups files"
fi

