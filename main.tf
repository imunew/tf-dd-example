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
    bucket = "yields-tf-state"
    region = "ap-northeast-1"
    key = "terraform.tfstate"
    encrypt = true
  }
}

resource "datadog_monitor" "cpumonitor" {
  name    = "cpu monitor"
  type    = "metric alert"
  message = "CPU usage alert"
  query   = "avg(last_1m):avg:system.cpu.system{*} by {host} > 60"
}
