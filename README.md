# Desafio DevOps Apiki.

# Pré Requisitos

Instalar Ansible na maquina

``` 
$ python3 -m pip install --user ansible
```
Instalar o Terraform 

```
$ sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
$ wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
$ pg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint
 sudo apt update
 $ sudo apt-get install terraform
```

Utilizar o seguinte comando para inicialização do Terraform:

```
terraform init
```

Depois utilizar 
```
terraform plan
```

E após isso subir o terraform com o comando: 
```
terraform apply
```

Agora para executar o playbook do Ansible, utilizara o comando: 

```
 ansible-playbook -u ubuntu --private-key .../.../apiki.pem -i ec2.py provisioning.yml
 ```
 
 "-u" o nome do usuário que executará os comandos no host alvo, ubuntu;
 "--private-key" o caminho e nome da chave privada usada para conexão SSH. Observe que o caminho em seu computador pode ser diferente. Nunca commit essa chave para o git.
 "-i" indica que o inventário será o arquivo ec2.py, módulo que fornece inventário dinâmico para AWS.
 "provisioning.yml" nome do arquivo que o comando ansible-playbook irá executar, ou seja, a playbook.
 
 
 # Acesso será feito via SSH, sendo enviado por e-mail com permissionamento Root.
 
