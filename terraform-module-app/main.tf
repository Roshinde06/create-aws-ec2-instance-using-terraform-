module "dev-infra" {
  source          = "./infra-app"
  env             = "dev"
  bucket_name     = "infra-app-bucket"
  instance_count  = 1
  instance_type   = "t3.micro"
  instance_ami_id = "ami-066c4849e6b3a1e3d" #amazon linux
  hash_key        = "studentID"

}

# module "prd-infra" {
#    source =   "./infra-app"
#    env = "prd"
#    bucket_name = "infra-app-bucket"
#    instance_count =1
#    instance_type = "t3.micro"
#    instance_ami_id =  "ami-066c4849e6b3a1e3d"     #amazon linux
#    hash_key = "studentID"

# }

# module "sta-infra" {
#    source =   "./infra-app"
#    env = "sta"
#    bucket_name = "infra-app-bucket"
#    instance_count =1
#    instance_type = "t3.micro"
#    instance_ami_id =  "ami-066c4849e6b3a1e3d"     #amazon linux
#    hash_key = "studentID"

# }