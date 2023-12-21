#!bin/bash
oidc_url=$(aws eks describe-cluster --name $1 --query "cluster.identity.oidc.issuer" --output text | cut -c 9- )
oidc_arn=$(aws iam list-open-id-connect-providers | grep $oidc_url | sed 's/"//g' | sed 's/ //g' | cut -c 5- )
echo $oidc_arn
aws iam delete-open-id-connect-provider --open-id-connect-provider-arn $oidc_arn
