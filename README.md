# Desafio DevOps Apiki.

## Informações sobre o projeto
- Foi criado uma instância na AWS do tipo t2.micro para subir os containers do MySQL, APACHE, NGINX; 

## Pré Requisito
- Docker instalado na instância;
- Caso não tenha instalado o docker na instância, acesse via SSH e siga os comandos na sequencia:

1 - Instalação do Docker:
  sudo apt update

  sudo apt upgrade
  
  sudo apt install apt-transport-https ca-certificates curl software-properties-common
  
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  sudo apt update

  sudo apt-cache policy docker-ce

  sudo apt install docker-ce

  sudo systemctl status docker

      ### output ###
      ● docker.service - Docker Application Container Engine
     Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2022-05-04 06:43:00 UTC; 2min 28s ago
     TriggeredBy: ● docker.socket
     Docs: https://docs.docker.com
     Main PID: 12995 (dockerd)
      Tasks: 8
     Memory: 38.6M
        CPU: 400ms
     CGroup: /system.slice/docker.service
             └─12995 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
      (Caso tenha aparecido a informação acima, siga os passos abaixo)

  sudo usermod -aG docker user_logado_na_instacia 

  docker info

  2 - Instalação do Docker Compose
    sudo curl -L https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

    sudo chmod +x /usr/local/bin/docker-compose

    docker-compose --version
      ### Output ###
      Docker Compose version v2.5.0

  Após a instalação, 

# Acessando a instância na AWS (SSH)
- Foi enviado o .ppk via email para que seja efetuado acesso. Lembrando que u user para acesso é o padrão (ubuntu)

# Subindo os serviços
- Após ser criada a instância na AWS, crie uma pasta (ex.: wp), insira o arquivo docker-compose.yml dentro da pasta;
- Crie uma outra pasta chamada nginx, e outra dentro dela chamada conf, insira o arquivo default.conf (importante, o arquivo default.conf deve ficar dentro da pasta conf), altere o nome do host para o end de usa instância que estará em DNS IPv4 público;
- Volte para a pasta dentro da pasta wp (caso seja esse o nome que tenha inserido na pasta), e rode o seguinte comando para subir os containers:
  - Para acompanhar o log de instalação e dos serviços: 
    - docker-compose up 
  - Para rodar em modo daemon (para poder acessar os containers rode esse)
    - docker-compose up -d

- Criando o Banco de Dados:
  - Após subir os containers, siga os passos abaixo: 
    - Partindo do princípio que tenha rodado o docker-componse em modo daemon rode o comanado:
      
      - sudo docker exec --interactive -t db /bin/bash (Caso não identifique o comando sudo remova do inicio do comando)

      - Acessando o container irá cair no terminal da maquina, agora rode os comandos abaixo na sequencia:
        - mysql -u root -p (irá pedir a senha que é 12345678)
        - show databases; (verifique se a base wp_devops foi criada)
      
      - Caso não tenha sido criada rode o comando abaixo:
        - create database wp_devops;
        - exit
        - Irá voltar para o terminal da maquina, digite exit novamente e irá voltar para o terminal da instância;
      
      - Agora siga os passos abaixo;

- Para Testar se está acessível abra o navegador e acesse a URL que consta nas configurações da instância da AWS. na opção de DNS IPv4 público
  - Caso esteja fazendo testes na instância que configurei, acesse http://ec2-3-86-45-198.compute-1.amazonaws.com

- Irá aparecer a tela de configuração/instalção do WP.

Em caso de dúvidas gentileza entrar em contato. 