 A Infraestrutura foi criada utilizando a AWS como provider.

 Foram utilizadas tecnologias como AWS RDS para banco de dados.
 Toda configuração é feita a partir do arquivo rds.tf e variables.tf.

 Para o deploy da infraestrutura foi utilizado o terraform para gerar toda a infraestrutura, 
 e para a criação e atualização dos arquivos de configuração.

Para a correta inicialização do ambiente é requerido a geração de uma chave ssh personalizada,
que sera registrada na aws.

Para tal acesse o diretório keys e execute o comando:

$ ssh-keygen -f devops-apiki-key 

Para iniciar o projeto é requerido a instalação do terraform na máquina.

 https://learn.hashicorp.com/tutorials/terraform/install-cli

 Acesse o diretório do terraform.
 Renomeie o arquivo credentials_conf para credentials e ajuste o arquivo de acordo com as suas credencias do AWS.

 Execute o terraform afim de inicializar o ambiente.

 # terraform init
 
 Isso ira baixar as dependências do terraform requeridas para o ambiente.

 # terraform plan 
 
 Este comando te dara uma visão geral do ambiente, como as alterações que serão feitas.

 # terraform apply -

    Este comando ira realizar as alterações no ambiente, criando o RDS setando as devidas permissões e criando o banco de dados, a instancia EC2, aplicando as permissões de acesso e gerando os arquivos de configuração para o ansible e o docker-compose.

Isso feito o ambiente já esta parcialmente configurado e pronto para fazermos o deploy do projeto.

Acesso o diretorio ansible, vai verificar que existe o arquivo de configuração inventory.

Para executar o deploy e deixar o wordpress já acessivel para configuração, execute o comando:

# ansible-playbook -i inventory playbook.yml

Ele ira gerar copiar os arquivos de configuração do nginx proxy e setar os environments corretos para o docker-compose.

o Ansible ira iniciar e configurar todo tudo.

Para ter acesso a url do wordpress, digite o comando dentro do diretório do terraform :

# terraform output 

    Este comando ira mostrar a url do wordpress.
    




 
