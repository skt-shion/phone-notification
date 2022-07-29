# Variable settings
variable "system_name" {
  type        = string
  description = "Your system name"
  default     = "mysystem"
}

variable "connect_source_phone_number" {
  type        = string
  description = "Caller phone number in E.164 format."
  default     = "+810000000000"
}
