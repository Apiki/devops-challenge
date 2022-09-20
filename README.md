## Apresentação

Escolhi fazer a automação utilizando userdata, passando as ações com estrutura cloud-init.
O userdata pode ser passada manualmente durante a criação da instãncia via dashboard ou em qualquer outro método de criação/orquestração disponível para AWS
O userdata utilizado está no arquivo `userdata.cfg`.
Foi configurado wordpress em container docker, usando o compose. Estando em um container servidor web apache, wordpress, php e outras depêndencias; utilizei imagem oficial do wordpress.
Também foi instânciado banco de dados mysql em docker, no mesmo compose.
E por fim, nginx instalado diretamente no sistema operacional e funcionando como proxy reverso, estando com as configurações de headers, ssl e websockets realizadas.
Foi utilizado um certificado *let's encrypt*, gerado previamente, para o domínio `apiki.loscaranlu.com.br`, a criação do certificado e a configuração de ssl no servidor web poderiam ser realizadas no boot integrando o certbot com provedores de dns como cloudfare e route53, também poderia ser feita através de um run padrão do certbot caso fosse previamente feito o apontamento de dns.


## Funcionamento
Cloud-init é o principal inicializar utilizado em nuvem, para a inicialização básica, padrão das instâncias e personalização já voltada ao deploy.
É uma linguagem declarativa, dizemos o que queremos que aconteça, e utiliza sintaxe yaml
São comandadas as seguintes ações:
- Update da lista de repositórios
- Upgrade dos pacotes
- Definição de timezone
- Instalação de pacotes: vim, docker, docker-compose, nginx e git
- Definição de hostname
- Criação de arquivos: docker-compose e de site no nginx
Além das ações integradas no cloud-init também é possível passar comandos a serem executados, método usado para as demais ações:
- Habilitar e iniciar o serviço docker no systemd
- Rodar deploy docker-compose
- Importar os dados do let's encrypt, que inclui os scripts de renovação e os arquivos de certificado
- Reiniciar o serviço do nginx para que as configurações entrassem em vigor




