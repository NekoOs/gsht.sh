#!/usr/bin/env bash


echo "Setting up environment..."


export APP_ENV="production"
export DB_HOST="localhost"

setup_logs_directory() {
    mkdir -p /var/logs/deployment
    echo "Logs directory created at /var/logs/deployment"
}

setup_logs_directory

log_message() {
    echo "$(date +"%Y-%m-%d %T") - $1"
}

log_message "Deployment process started."
