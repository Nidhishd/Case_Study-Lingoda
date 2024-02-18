#!/bin/bash

# Script to handle database migrations during Symfony deployment in Kubernetes

# Exit immediately if a command exits with a non-zero status
set -e

# Variables
APP_CONTAINER_NAME="symfony-demo"
NAMESPACE="case-study"

# Run migrations
echo "Running database migrations..."
kubectl exec -it $APP_CONTAINER_NAME -n $NAMESPACE -- php bin/console doctrine:migrations:migrate --no-interaction

# Verify migrations
echo "Verifying migrations..."
kubectl exec -it $APP_CONTAINER_NAME -n $NAMESPACE -- php bin/console doctrine:migrations:status --show-versions

# Exit successfully
exit 0

