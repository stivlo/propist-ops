#!/bin/bash
echo [web] > web-hosts
aws ec2 describe-instances --filters "Name=tag:Name,Values=propist-web" \
  --query 'Reservations[].Instances[].[PublicIpAddress]' | jq -r .[][] >> web-hosts
