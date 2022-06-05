[Voltar ao Sumário](../README.md) - [Anterior](terraform.md) - [Próximo](ansible.md)

# Criando a infra na AWS

## 1. Atenção
Antes de iniciar o procedimento, necessário alterar, se for o caso:
a. Arquivo main.tf no trecho do backend s3, alterar o bucket e key que irá usar.
b. Arquivo ec2.tf no trecho que indica o nome da key usada para acesso ssh (key_name).

**Passo a passo:**

1. Em um terminal, acesse o diretório ***terraform*** que está na raiz deste projeto:
    ```shell
    cd terraform
    ```
2. Execute o container da hashicorp que fornece o terraform:
   ```shell
    docker run -it -v $PWD:/app -w /app --entrypoint "" hashicorp/terraform:light sh
   ```
   Essa é uma forma prática de se usar o terraform. O comando acima vai iniciar um shell dentro do container, fazendo um bind volume para o diretório corrente do seu computador, permitindo que o terraform leia os arquivos .tf que foram codificados.

3. Agora dentro do shell do container, exporte as variáveis de Access Key e Secret Key geradas no IAM da AWS:
    ```shell
    export AWS_SECRET_ACCESS_KEY="SUA ACCESS KEY AQUI"
    ```
    ```shell
    export AWS_SECRET_ACCESS_KEY="SUA SECRET KEY AQUI"
    ```
4. Com o terraform devidadmente configurado, execute um plan:
    ```shell
    terraform plan -out deploy.plan
    ```
    A opção "**-out**" indica para o terraform salvar a saída do plan no arquivo deploy.plan. É um arquivo binário que será usado na próxima etapa. Na saída do plan é informado tudo que será modificado/criado na AWS.

5. Execute o apply para criar os recursos na AWS:
    ```shell
    terraform apply deploy.plan
    ```
    Os recursos necessários (EC2 e Security Groups) foram criados na AWS.

6. Cadastre um apontamento do tipo A e CNAME para o domínio que será usado. Espere começar a responder para iniciar a etapa de instalação via ansible do wordpress.

**Obs.:** Para o correto funcionamento, é necessário usar um serviço de domínio, realizar o cadastro DNS A e CNAME corretamente. Dessa forma, terá uma url válida para configuração de https.

Neste projeto, apenas para demonstração, foi utilizado o serviço de nome gratuíto o [Freenom](www.freenom.com). Para emissão do certificado TLS, foi utilizado o [Let's Encrypt](https://letsencrypt.org/pt-br/)


[Voltar ao Sumário](../README.md) - [Anterior](terraform.md) - [Próximo](ansible.md)