# terraform {
#   backend "s3" {
#     bucket         = "ANAProject"
#     key            = "global/s3/terraform.tfstate"
#     region         = "ap-southeast-2"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }

terraform {
  backend "remote" {
    organization = "learn-terraform-now"

    workspaces {
      name = "automate_terraform_PBL"
    }
  }

}
