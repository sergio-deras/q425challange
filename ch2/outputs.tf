output "privateIP" {
  value = aws_instance.WebServer.private_ip
}

output "publicIP" {
  value = aws_instance.WebServer.public_ip
}

output "publicDNS" {
  value = aws_instance.WebServer.public_dns
} 

/*
output "publicEIP" {
  value = aws_eip.WebIP.public_ip
}

output "publicEIPDNS" {
  value = aws_eip.WebIP.public_dns
}
*/