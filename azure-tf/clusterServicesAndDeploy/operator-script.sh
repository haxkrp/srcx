#! /bin/bash
echo "Deploying Stocktrader Operator via Bash"
operator-sdk olm install
operator-sdk run bundle docker.io/ibmstocktrader/stocktrader-operator-bundle:v1.0.0