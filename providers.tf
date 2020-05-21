provider "aws" {
  version = "~> 2.62"
  region  = "us-east-2"
}

provider "aws" {
  alias   = "west"
  version = "~> 2.62"
  region  = "us-west-2"
}

