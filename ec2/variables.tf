variable "ingressrule" {
  type    = list(number)
  default = [80, 443]
}

variable "egressrule" {
  type    = list(number)
  default = [80, 443, 22]
}