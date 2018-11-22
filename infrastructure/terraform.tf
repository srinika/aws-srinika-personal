provider "aws" {
    version = "~> 1.46"
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "ap-southeast-2"
}

terraform {
    required_version = "> 0.10.0"
}