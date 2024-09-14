variable "account_id" {
  type = string
}

variable "role_name" {
  type = string
}

variable "bucket_name" {
  type = string
  description = "A name of a bucket where our raw data is stored"
}

variable "snow_acc" {
  type = string
}

variable "snow_usr" {
  type = string
}

variable "snow_pass" {
  type = string
}

variable "snow_role" {
  type = string
}
