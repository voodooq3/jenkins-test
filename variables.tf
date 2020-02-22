
variable region {
  description = "Region"
  # type = string
  default = "eu-central-1"
}

variable shared_credentials_file_path {
  description = "Shared Credentials File Path"
  # type = "string"
  default = "./key/cred.txt"
}

variable private_key_path {
  description = "Pivate Key"
  # type = "string"
  default = "./key/voodookey.pem"
}