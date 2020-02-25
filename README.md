Terraform Cashcat
========================

This project will create a scheduled lambda to post random cash cat gliphy
images to slack.

Prerequisites
========

Get a gliphy api key from the gliphy developers website.

Get a webhook url for your slack channel

Create an AWS S3 bucket to store lambda file

Install AWS SAM CLI - https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html


Install Zappa
==================================================

Create a python3 virtual environment

``` {.sourceCode .console}
$ pip install virtualenv
$ which python3
$ /usr/local/bin/python3
$ virtualenv -p /usr/local/bin/python3 my_virtual_env
```

Activate the virtual environment


``` {.sourceCode .console}
$ source my_virtual_env/bin/activate
```

Clone github repository


``` {.sourceCode .console}
$ git clone git@github.com:rubelw/terraform_cashcat.git
```

Installation
============

Update the S3 bucket and key, giphy api key and slack url in the
variables.tf file.

Package the lambda and deploy to the S3 bucket.  From the root of the git repository, type:


``` {.sourceCode .console}
$ sam build && sam package --s3-bucket my-bucket-name
```

Deploy the terraform project.


``` {.sourceCode .console}
$ terraform init
$ terraform plan
$ terraform apply
```

Go to the AWS console and test the lambda.  It should post a message in the slack channel.