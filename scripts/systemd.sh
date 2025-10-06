#!/bin/bash

echo -e "# Systemctl enable and starting services"
cat $AKIRA_PKG_PATH/systemctl-enable.txt | xargs sudo systemctl enable --now
