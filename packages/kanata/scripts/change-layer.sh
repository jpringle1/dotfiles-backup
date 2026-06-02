#!/bin/bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <your_argument>"
    exit 1
fi

# Echo the argument inside JSON and send via nc
echo -e "{\"ChangeLayer\": { \"new\": \"$1\"}}" | nc 127.0.0.1 4039
