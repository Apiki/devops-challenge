
output "key_name" {
  value = "Chave SSH  ${module.ssh-key.key_name}.pem "
  description = "Chave SSH da instância"
}

output "public_ip" {
  value = "Conect ssh -i ${module.ssh-key.key_name}.pem ubuntu@${module.ec2-instance.public_ip} "
  description = "IP público para a instância"
}

output "web" {
  value = "Aguarde alguns minutos e acesse http://${module.ec2-instance.public_ip} "
  description = "Acesso público ao projeto"
}


