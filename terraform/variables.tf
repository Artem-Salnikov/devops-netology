variable "yc_token" {
  default = ""
}

variable "yc_cloud_id" {
  default = ""
}

variable "yc_folder_id" {
  default = ""
}

variable "access_key" {
  default = ""
}

variable "secret_key" {
  default = ""
}

variable "yc_region" {
  default = "ru-central1-a"
}

variable count_offset { 
  default = 0 
} #start numbering from X+1 (e.g. name-1 if '0', name-3 if '2', etc.)

variable count_format { 
  default = "%01d" 
} #server number format (-1, -2, etc.)

variable "instance_name" {
  default = "Node"
}
