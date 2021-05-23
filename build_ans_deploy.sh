#!/bin/sh

npm run build
aws s3 rm s3://ekimarufront/ --recursive
aws s3 cp dist s3://ekimarufront/ --recursive
