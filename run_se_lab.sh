#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Colour

echo -e "${YELLOW}Building se_lab docker image${NC}\n"
docker build . -t se_lab

if [ $? -eq 0 ]
then
    echo -e "${GREEN}Success. Docker build for se_lab successful. Running container...${NC}\n"
    docker run -it --name se_lab se_lab bash
else
    echo -e "${RED}Failure. Docker build for se_lab failed.${NC}"
fi