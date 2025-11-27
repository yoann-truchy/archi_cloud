provider "github" {
  token = "GITHUB_TOKEN"
  owner = "yoann-truchy"
}

resource "github_repository" "demo_repo" {
  name        = "my-terraform-repo"
  description = "Repository created by Terraform"

  visibility  = "private"
}