## Documentação - Resultado
Esse projeto tem como objetivo rodar uma aplicação Wordpress em um cluster Kubernetes hospedado em instâncias Amazon EC2. Segue abaixo a stack utilizada:
  
  * PHP 7.4.2
  * Wordpress 5.4.2
  * Apache/2.4.38
  * Nginx Ingress como proxy
  * McRouter para cacheamento (protocolo Memcached)

### Tecnologias utilizadas

  - [Kubernetes](https://kubernetes.io/)
  - [Helm](https://helm.sh/docs/intro/install/)
  - [Kops e Kubectl](https://github.com/kubernetes/kops/blob/master/docs/install.md)
  - [Docker](https://www.docker.com/)
  - [Amazon EC2](https://aws.amazon.com/pt/ec2/)
  - [Amazon S3](https://aws.amazon.com/pt/s3/)

---

## Criar cluster

  1. Criar uma função do IAM na AWS, com as seguintes permissões:

  * AmazonEC2FullAccess
  * IAMFullAccess
  * AmazonS3FullAccess
  * AmazonVPCFullAccess

  2. Crie uma nova instância para usar como seu CI host. Este nó lidará com o provisionamento e o desmembramento do cluster.
    1. Essa instância pode ser pequena (t2.micro por exemplo).
    2. Ao criá-lo, atribua a função IAM criada na primeira etapa.
    3. Uma vez criada, faça o download das chaves ssh ou adicione a sua própria chave pública do seu computador local na instância.
  
  3. Acesse via SSH o CI host.
  4. Instale o kops e o kubectl no CI host. Siga as instruções [aqui](https://github.com/kubernetes/kops/blob/master/docs/install.md).
  5. Configure um par de chaves ssh para usar com o cluster
  6. Crie as seguintes variáveis pelo terminal
    1. Como não estamos usando DNS pré-configurado, usaremos o sufixo “.k8s.local”. De acordo com a documentação do k8s, se o nome DNS terminar em .k8s.local, o cluster usará o DNS hospedado interno.
    
    `export NAME=<nome_do_cluster>.k8s.local`

    2. Crie um bucket S3 para armazenar sua configuração de cluster. É recomendável ativar o controle de versão no bucket S3. Não precisamos passar isso para os comandos do KOPS. Ele detecta automaticamente pela ferramenta kops como uma variável env.

    `export KOPS_STATE_STORE=s3://<nome_do_seu_bucket_aqui>`

    3. Defina a mesma região utilizada na instância CI host. 
    
    `export REGION=us-east-2`

    4. É recomendável configurar essas variáveis no arquivo `/etc/profiles`. As variáveis definidas neste arquivo são carregadas sempre que um shell de login do bash é iniciado. Ao declarar variáveis de ambiente neste arquivo, você precisa usar o comando export também. Igual nos exemplos anteriores.

    `sudo nano /etc/profiles`
  
  7. Instale a CLI da AWS:

  `sudo apt-get update`
  `sudo apt-get install awscli`

  8. Crie o cluster

  `kops create cluster $NAME --zones us-east-2c --authorization RBAC --master-size t2.micro --master-volume-size 10 --node-size t2.medium --node-volume-size 10 --yes`

  9. Aguarde a inicialização do cluster.
    1. A execução do comando 'kops validate cluster' nos dirá qual é o estado atual da instalação. Se você vir "não é possível obter nós" inicialmente, apenas seja paciente, pois o cluster não pode relatar até que alguns serviços básicos estejam em funcionamento.

    `time until kops validate cluster; do sleep 15 ; done`
    
  10. Confirme se kubectl está conectado ao seu cluster Kubernetes.

  `kubectl get nodes`

  11. (Opcional) Se você deseja usar o kubectl e o helm na sua máquina local. Siga esses passos:
    1. Execute o seguinte comando no CI host:
  
    `kops export kubecfg`

    2. Copie o conteúdo do arquivo `~/.kube/config` para o mesmo local no sistema local.

    3. Com isso você poderá orquestrar o seu cluster através da sua máquina local, ao invés de ter que entrar via ssh no CI host.


---

## Criar os containers e pods
Depois de criar o cluster, você já pode criar todas as implantações necessárias que rodarão nos pods.
  1. Caso tenha feito o passo 11, a primeira coisa a se fazer é clonar esse repositório na sua máquina local.
  2. Caso tenha pulado o passo 11, é necessário clonar esse repositório no CI host.


### Implantação Wordpress e MySQL
Para implantar o Wordpress, Apache e MySQL vai ser necessário usar o Helm Chart que está no diretório `wp-php-chart` desse repositório.

`helm install wp-php-chart wp-phpchart\`


### Implantação balanceador de carga com Ingress Nginx
Para implantar o Nginx que terá uma função de proxy, siga os passos abaixo:
  1. Adicione o repositório abaixo para conseguir utilizar o chart. Caso queira, pode conferir a [documentação](https://hub.kubeapps.com/charts/stable/nginx-ingress) do respectivo chart.
  
  `helm repo add stable https://kubernetes-charts.storage.googleapis.com/`

  2. Instale o Helm Chart do nginx ingress. Caso queria definir alguma configuração personalizada, mude no arquivo `nginx\values.yaml`. É nesse passo que o balanceador de carga será criado, junto com as implantações do Nginx.

  `helm install nginx stable/nginx-ingress -f nginx\values.yaml`

  3. Descubra o ip externo do controlador nginx.

  `kubectl get services`

  4. Altere a entrada spec.rules.host do arquivo `nginx\ingress.yaml` e coloque o ip externo que você descobriu no passo anterior.

  5. Implante o ingress

  `kubectl apply -f nginx\ingress.yaml`

    
### Implantação do McRouter - Opcional
O Mcrouter (pronuncia-se "mick router"), um proxy Memcached de código aberto eficiente, permite o agrupamento de conexões. A integração do Mcrouter é perfeita porque ele usa o protocolo padrão Memcached ASCII. Para um cliente do Memcached, o Mcrouter se comporta como um servidor do Memcached normal. Para um servidor do Memcached, o Mcrouter se comporta como um cliente do Memcached normal.

Uma maneira simples de implantar um serviço do Memcached no cluster é usar um gráfico do Helm. 

`helm install cache stable/mcrouter --set memcached.replicaCount=2`

Depois de implantar o McRouter, recomendo utilizar o plugin W3 Total Cache para realizar as configurações para começar a utilizar o memcached.

---

## Deletar o cluster
1. Se em algum momento você desejar destruir seu cluster, execute:

`kops delete cluster $NAME --yes`