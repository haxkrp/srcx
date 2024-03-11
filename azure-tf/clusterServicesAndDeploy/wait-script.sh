#!/bin/bash
echo "Checking Pod Readiness of deployment in namespace $1"
sleep 10
echo "Running kubectl wait..."
kubectl wait --for=condition=Ready pods --all -n stocktrader --timeout=5m --kubeconfig $2