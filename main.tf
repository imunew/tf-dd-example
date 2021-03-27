variable "state_s3_bucket" {}

terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = var.state_s3_bucket
    region = "ap-northeast-1"
    key = "terraform.tfstate"
    encrypt = true
  }
}

resource "datadog_monitor" "cpumonitor" {
  name    = "cpu monitor"
  type    = "metric alert"
  message = "CPU average usage alert"
  query   = "avg(last_1m):avg:system.cpu.system{*} by {host} > 60"
}
