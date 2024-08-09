# change the default value to your own snowflake log-in credentials

variable "snowflake_account" {
  description   = "The Snowflake account for resources to be loaded into"
  type          = string
  default       = ""
}

variable "snowflake_user" {
  description   = "The username for the Snowflake user"
  sensitive     = true
  type          = string
  default       = ""
}

variable "snowflake_user_password" {
  description   = "The password for the Snowflake user"
  sensitive     = true
  type          = string
  default       = ""
}

variable "snowflake_user_role" {
  description   = "The role of the Terraform user"
  type          = string
  default       = ""
}