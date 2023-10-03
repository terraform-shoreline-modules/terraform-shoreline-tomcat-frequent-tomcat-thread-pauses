terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "frequent_tomcat_thread_pauses" {
  source    = "./modules/frequent_tomcat_thread_pauses"

  providers = {
    shoreline = shoreline
  }
}