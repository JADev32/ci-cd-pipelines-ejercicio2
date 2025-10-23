#!/bin/bash
set -e

echo "🚀 Setting up OIDC role for GitHub Actions..."

# Variables (REEMPLAZAR con tus valores)
AWS_ACCOUNT_ID="131676642371"
GITHUB_USER="JADev32"
GITHUB_REPO="ci-cd-pipelines-ejercicio2"
S3_BUCKET="bucket-s3-pipeline-e2"

# Crear política S3
echo "📝 Creating S3 deploy policy..."
aws iam create-policy \
  --policy-name GitHubActionsS3Deploy \
  --policy-document file://docs/aws-policies/s3-deploy-policy.json \
  --description "Policy for GitHub Actions to deploy to S3 via OIDC"

# Crear rol con trust relationship
echo "👤 Creating IAM role..."
aws iam create-role \
  --role-name GitHubActionsOIDCRole \
  --assume-role-policy-document file://docs/aws-policies/oidc-trust-policy.json \
  --description "Role for GitHub Actions OIDC authentication"

# Adjuntar política al rol
echo "🔗 Attaching policy to role..."
aws iam attach-role-policy \
  --role-name GitHubActionsOIDCRole \
  --policy-arn arn:aws:iam::${AWS_ACCOUNT_ID}:policy/GitHubActionsS3Deploy

echo "✅ OIDC role setup completed!"
echo "📋 Role ARN: arn:aws:iam::${AWS_ACCOUNT_ID}:role/GitHubActionsOIDCRole"