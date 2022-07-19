output "instance_id" {
    value = "aws_instance.ec2-instance.public_ip"
} 

output "security_group" {
    value = "aws_security_group.mysg.id"
} 

output "public_ip" {
  value = aws_instance.ec2_public.public_ip
}
