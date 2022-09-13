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
╭─    ~/Code/devops-challenge   juam-veras !16 ?5 ▓▒░···························································································░▒▓ ✔  16:29:06 ─╮
╰─ tree -L 3
.
├── ansible # Contendo as roles, vars e playbooks pro deploy da arquitetura.
│   ├── bkp-hosts
│   ├── hosts
│   ├── main.yml
│   ├── roles
│   │   ├── common # Role pra pacotes basicos
│   │   ├── docker-cluster  # Inicia o cluster do swarm
│   │   ├── docker-deploy # Faz o deploy dos docker-composes.
│   │   ├── docker-install # Instala o docker, pip requeriments e add user aos grupos
│   │   ├── wordpress # Instalação e configuração do wordpress-apache
│   │   └── wp-ports
│   └── vars
│       ├── main.yml
│       └── tf_ansible_vars_file.yml # Variaveis geradas pelo ansible
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
│   └── variables.tf # Arquivo pra definir as variaveis do terraform
├── terraform.tfstate
└── Vagrantfile

10 directories, 21 files

```

## Installation
Você vai precisar do **ansible**, **terraform** e o **aws cli**  instalados e configurados na machina que irá executar o deploy.
- 1 º - Editar o arquivo "variables.tf" na pasta terraform e mudar a senha do banco da variavel "password"
- 2 º - Executar o terraform init e terraform apply e aguardo o provisionamento do ambiente.
- 3 º - O terraform gerará o arquivo de hosts e variaveis com o output automaticamente, então execute o playbook com o seguinte comando.
```bash
ansible-playbook -i hosts main.yml -vvv
```

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
- [x] compose do nginx
- [x] config do nginx
- [x] README.md 

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.