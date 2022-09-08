# Desafio DevOps Apiki
# Candidato: Márcio Rodrigo Monteiro
# Referência: https://github.com/Apiki/devops-challenge

Amazon EC2 (https://us-east-2.console.aws.amazon.com/ec2/home?region=us-east-2)

```html
Iniciar uma instância
    Imagens de aplicação e de sistema operacional (imagem de máquina da Amazon):
        Escolher Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type (Qualificado para nível gratuito)
    Tipo de instância:
        Escolher t2.micro (Qualificado para nível gratuito)
    Par de chaves (login):
        Criar novo par de chaves
            Nome do par de chaves: apikiteste
            Criar par de chaves
    Configurações de rede:
        Deixar marcado Permitir tráfego SSH de (qualquer lugar), Permitir tráfego HTTPs da Internet e Permitir tráfego HTTP da Internet
    Configurar armazenamento:
        Adicionar novo volume
            20GiB
    Executar instância

Amazon RDS MySQL (https://us-east-2.console.aws.amazon.com/rds/home?region=us-east-2)
Criar banco de dados
    Escolher um método de criação de banco de dados:
        Criação padrão
    Opções do mecanismo:
        MySQL
        Edição:
            MySQL Community
        Versão:
            8.0.28
    Modelos:
        Nível gratuito
    Configurações:
        Identificador da instância de banco de dados:
            XXX
        Nome do usuário principal:
            XXX
        Senha principal:
            XXX
    Conectividade
        Conectar-se a um recurso de computação do EC2:
            Instância do EC2:
                Esolher a instância criada previamente
    Configuração adicional
        Nome do banco de dados inicial
            XXX
    Criar banco de dados
```

Conectar ssh no servidor

```sh
mkfs.xfs /dev/xvdb
uuid="$(blkid  | grep 'xvdb' | awk '{print $2}' | awk -F'"' '{print $2}')"
mv /opt /opt.bkp
mkdir /opt
chmod 0000 /opt
echo "UUID=${uuid}  /opt    xfs    defaults,noatime  1   1" >> /etc/fstab
mount /opt
mv /opt.bkp/* /opt
rm -rf /opt.bkp/
xfs_growfs -m 100 /opt

yum upgrade -y

timedatectl set-timezone America/Fortaleza

yum install ntpdate ntp vim -y
ntpdate a.ntp.br
sed -i 's/pool 2.amazon.pool.ntp.org iburst/pool 2.amazon.pool.ntp.org iburst\npool a.ntp.br iburst/g' /etc/ntp.conf

systemctl start ntpdate ; systemctl start ntpd ; systemctl enable ntpdate ; systemctl enable ntpd
amazon-linux-extras install epel -y
yum install -y wget lynx make gcc autoconf automake setuptool patch gcc-c++ sysstat mlocate htop bzip2 gzip net-tools screen rsync bind-utils yum-utils zip unzip yum-cron screen psmisc glances git telnet
sed 's/nfs nfs4 nfsd //g' /etc/updatedb.conf -i
updatedb

yum clean all
rm -rf /var/cache/yum

chmod +x /etc/rc.d/rc.local

systemctl stop postfix
systemctl disable postfix

echo 'vm.swappiness = 0' >> /etc/sysctl.conf
sysctl -p

yum install docker -y

systemctl enable docker
systemctl start docker
systemctl stop docker

curl -L "https://github.com/docker/compose/releases/download/1.28.6/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

docker-compose -v

cd /opt
mv /var/lib/docker .
mv docker var-lib-docker
cd /var/lib/
ln -s /opt/var-lib-docker docker

cd /opt
mv /etc/docker .
mv docker etc-docker
cd /etc/
ln -s /opt/etc-docker docker

systemctl start docker

cd /opt
mkdir docker-containers
```

```html
Containers em /opt/docker-containers/
Cada container está em um diretório
Utilizar docker-compose (down, up, logs)
```

Container nginxpr (Proxy Reverso)
```html
Dentro no arquivo roda-original.sh está o passo a passo para configuração do container.
Descomentar o volume dele no docker-compose.yml e comentar o do roda.sh
Iniciar o container, conectar nele no bash e executar os comandos (copiar e colar)
Depois de tudo feito, sair do container (exit) e commitar (docker ps, pegar o ID do container e executar docker commit ID nginxpr:v1)
Parar o container, alterar a imagem (image) dentro do docker-compose.yml e iniciar o container com a imagem nova
```

Para criação de sites e certificado digital do Let's Encrypt
```sh
    docker exec -it nginxpr bash
    cd /etc/nginx/conf.d/
    ./criaHttp.sh apikisite1.rodrigomonteiro.net
    ./criaHttps.sh apikisite1.rodrigomonteiro.net
```


