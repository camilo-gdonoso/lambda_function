#!/bin/bash
rm -rf package
mkdir package
pip install --target ./package -r requirements.txt
cp lambda_function.py package/
cd package
zip -r ../lambda_function.zip .
cd ..
