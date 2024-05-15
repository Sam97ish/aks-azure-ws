#!/bin/env bash

location="${1:-eastus}"

az deployment sub create --location $location --template-file ./azure-infra/main.bicep