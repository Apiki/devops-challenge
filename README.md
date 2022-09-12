# Devops Chanllenge - Apiki

Neste projeto estão sendo utilizados as seguintes stacks:
- AWS
- RDS
- Terraform
- Ansible
- Docker (Swarm)
- Wordpress


## Estrutura de Arquivos
```bash
╭─    ~/Code/devops-challenge   juam-veras ⇡2 !2 ▓▒░··································░▒▓ ✔  21:27:52 ─╮
╰─ tree -L 3                                                                                                  ─╯
.
├── ansible # Contendo as roles, vars e playbooks pro deploy da arquitetura.
│   ├── hosts
│   ├── main.yml
│   ├── roles
│   │   ├── common # Role pra pacotes basicos
│   │   ├── docker-deploy # inicio do cluster swarm e deploy dos docker-composes.
│   │   ├── docker-install # Instalação do docker e dependencias do pip
│   │   └── wordpress # Instalação e configuração do wordpress-apache
│   └── vars
│       └── main.yml # Variaveis
├── README.md
├── terraform # Arquivos do terraform pra deploy da ec2, rds, networks, security groups etc
│   ├── data.tf
│   ├── init.sh
│   ├── instances.tf
│   ├── locals.tf
│   ├── main.tf
│   ├── network.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── rds.tf
│   ├── security-group.tf
│   ├── terraform.tfstate
│   ├── terraform.tfstate.backup
│   └── variables.tf
└── Vagrantfile

8 directories, 18 files
```

## Installation
Você vai precisar do **ansible**, **terraform** e o **aws cli**  instalados e configurados na machina que irá executar o deploy.
- 1 º - Editar o arquivo "variables.tf" na pasta terraform e mudar a senha do banco da variavel "password" e respectivamente os mesmos no ansible/vars/main.yml
- 2 º - Executar o terraform init e terraform apply, no final irá gerar uma saida como á abaixo.

## Output

```bash
private_ip = "10.0.1.228"
public_dns = "ec2-23-70-46-98.compute-1.amazonaws.com"
public_ip = "52.70.31.12"
rds_endpoint = "database.jdoisajdas.us-east-1.rds.amazonaws.com:3306"
```
- 4º - Apos isso, adicionei a saida do **public_ip** referente a ec2 ao arquivo hosts na pasta ansible abaixo do campo [aws].
- 5º - E a saida do **rds_endpoint** como valor da variavel **WORDPRESS_DB_HOST** no arquivo ansible/vars/main.yml
- 6º - Execute o playbook com o seguinte comando.
```bash
ansible-playbook -i hosts main.yml -vvv
```

OBS: A automação referente aos 2 ultimos passos está em desenvolvimento.

### ToDo

- [x] RDS
- [x] Terraform 
  - [x] ec2 
  - [x] network/subnets/gateways 
  - [x] security groups
  - [x] RDS subnet groups
  - [ ] output do terraform direto para os arquivos do ansible.
- [x] Ansible 
  - [x] common packages 
  - [x] docker-install 
  - [x] wordpress/php/apache2 deploy 
  - [x] docker deploy 
- [ ] compose do nginx
- [ ] config do nginx
- [x] README.md 

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.