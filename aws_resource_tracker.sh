#!/bin/bash

###########################################################
# Author : Rakshitha
# Date : 30/05/2025
#
# Version : v1
#
# This Script will report the AWS resource usage
# #########################################################


# AWS S3
# AWS EC2
# AWS Lambda
# AWS IAM Users


# list s3 Instances
aws s3 ls

# list EC2 Instances
aws ec2 describe-instances

# list lambda
aws lambda list-functions

# lis IAM users
aws iam list-users 
