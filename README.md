# Desafio DevOps APIKI.
Objetivo é criar um processo automatizado para construção de um servidor web para WordPress em sua última versão.

# Instruções de configurações do Terraform e AWS. 
O projeto foi desenvolvido com o Terraform e Docker Compose, através destas ferramentas ocorre toda a automatização para criação do ambiente.
<br>Para conseguir efetuar a criação da instância e demais configurações no servidor é necessário  seguir as seguintes orientações:
  - Possuir o Terraform instalado em seu computador; [Terraform](https://developer.hashicorp.com/terraform/downloads).
  - Possuir a access key ID e secret key com permições para criação no EC2 e RDS;
  - Criar uma key pair para acessos ssh e tranferência de arquivos que ocorrem durante a criação da instância, exportar a mesmo como arquivo .pem;

# Configurações dos arquivos.
No arquivo provider.tf é necessário que seja alterado os campos "access_key = access key ID"  e "secret_key = secret key" com os dados gerados na AWS;<br>
No arquivo main.tf é necessário alterar a key name conforme foi criada no Key Pair na AWS;<br>
Na linha 31 do main.tf deve ser alterado o local do arquivo onde esta salvo o Key pair;<br>
O Terraform, juntamente com o Docker Compose e Shell Script irá realizar todas as instalações e configurações necessárias para rodar o nginx, apache e WordPress.

# Iniciando o Terraforme.
1º Para iniciar o deploy do Terraform execute o seguinte comando "terraform -chdir='local_da_pasta_projeto' init";<br>
2º Para o Terraform criar a instância digite em seu terminal "terraform -chdir='local_da_pasta' apply";<br>
3º Após ele finalizar ele retornará os endereços DNS do RDS e da instância criada.<br>

# Acessando o WordPress.
Copie a endereço que retornou no final da criação da instância e acesse em seu browser, ele irá direcionar diretamente para o configurador do WordPress;
- Nesse caso o link é: http://dns-do-servidor/ <br>
As configurações do DB criado podem ser encontradas no arquivo main.tf;<br>
<br>Nesse caso os dados de acesso são:
    * db_name  = wordpress
    * username = wordpress
    * password = wordpress

# Ferramentas Utilizadas:
- [Terraform](https://developer.hashicorp.com/terraform/language).
- [Docker-Compose](https://docs.docker.com/compose/).
- Shell Script Linux.
- AWS(EC2 e RDS).

