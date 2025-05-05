terraform {
  backend "s3" {
    bucket = "jenkins-s3-bucket-for-backend-mine"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}
