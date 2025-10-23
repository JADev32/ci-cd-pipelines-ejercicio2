#!/bin/bash
set -e

echo "🔍 Verifying deployment..."

# Variables (ajustar según necesidad)
S3_BUCKET="tu-bucket-deploy"
AWS_REGION="us-east-1"

# Verificar que el bucket existe
echo "📦 Checking S3 bucket access..."
aws s3 ls s3://$S3_BUCKET || {
    echo "❌ Bucket no existe o no accessible"
    exit 1
}

# Listar archivos de deployment
echo "📁 Deployment files:"
aws s3 ls s3://$S3_BUCKET/deployments/ --recursive --human-readable

# Descargar y mostrar latest deployment
echo "📄 Latest deployment info:"
aws s3 cp s3://$S3_BUCKET/deployments/latest.json - | jq . || {
    echo "⚠️  Could not download latest.json"
}

echo "✅ Verification completed successfully"