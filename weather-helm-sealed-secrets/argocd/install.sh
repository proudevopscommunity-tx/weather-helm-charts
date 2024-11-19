#!/bin/bash
 
# Create namespace argocd or skip if already exist.
kubectl create ns argocd || true
 
# Install using kubectl
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
 
# Patch argocd-server service to type NodePort
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'
 
# RETRIEVE argocd PASSWORD
#argocd admin initial-password -n argocd
sleep 10
kubectl -n argocd get secrets argocd-initial-admin-secret -o json | jq -r .data.password | base64 -d && echo
 