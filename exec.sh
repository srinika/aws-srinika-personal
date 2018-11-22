#!/usr/bin/env bash

if [ $# -lt 2 ]
  then
    echo "Please provide following four(2) arguments to run the script."
    echo ""
    echo "${0} <section> <operation> [<.tfvar file>]"
    echo ""
    echo "1. Section  [infra | state]"
    echo "2. Operation [init | plan | apply | destroy]"
    echo "3. tfvar file location (optional). Defaults to ~/.ssh/cloud_keys/terraform/aws-personal.tfvars"

    exit 1
fi

SECTION=$1
OPERATION=$2
TFVAR_FILE=$3
# BACKEND_TFVAR_FILE=$4


if [ -z "" ${TFVAR_FILE} ]; then
    TFVAR_FILE="~/.ssh/cloud_keys/terraform/aws-personal.tfvars"
fi

# if [ -z "" ${BACKEND_TFVAR_FILE} ]; then
#     BACKEND_TFVAR_FILE="~/.ssh/${ACCOUNT}/terraform/${ENV}/dep-bot-backend.tfvars"
# fi

echo "Parameters provided : section=${SECTION}, operation=${OPERATION}, tfvar file=${TFVAR_FILE}"

case ${SECTION} in
    infra)
        cd ./infrastructure/
        ;;
    state)
        cd ./state/
        ;;
    *)
        exit 1
        ;;
esac


case ${OPERATION} in
    init)
        rm -rf .terraform
        # terraform init --backend-config="${BACKEND_TFVAR_FILE}"
        terraform init
        ;;
    plan)
        terraform plan -var-file="${TFVAR_FILE}" -out=terraform.tfplan
        ;;
    apply)
        terraform apply "terraform.tfplan"
        ;;
    destroy)
        terraform destroy --var-file="${TFVAR_FILE}"
        ;;
    *)
        echo "Sorry, I don't understand the operation ${OPERATION}."
        exit 1
        ;;
esac