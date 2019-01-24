#!/bin/bash
aws ec2 describe-instances --filters "Name=tag:Name,Values=propist-web" \
  --query 'Reservations[].Instances[].[PublicIpAddress]' | jq -r .[][]
