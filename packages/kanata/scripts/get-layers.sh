#!/bin/bash

# Echo the argument inside JSON and send via nc
echo -e "{\"RequestLayerNames\": {}}" | nc 127.0.0.1 4039
