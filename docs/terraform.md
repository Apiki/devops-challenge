[Voltar ao Sumário](../README.md) - [Anterior](prereqs.md) - [Próximo](terraform_apply.md)

# Terraform (Leitura Opcional)
## 1. Provisionando VM

Para criar a infraestrutura necessária, será utilizado o [Terraform](https://www.terraform.io/).

## 2. Usando o Terraform

Quando usamos o Terraform ele quarda o estado localmente. O ideal é colocar o arquivo de estado em um lugar seguro remoto, pois o local pode ser perdido.

Como exemplo, pode-se guardar em um serviço de armazenamento em cloud, como o S3 da AWS. O S3 foi a opção desse projeto.

### 2.1. Executando comandos do Terraform

Uma boa opção é utilizar e executar os comandos do terraform é utilizando o docker. Essa é uma estratégia interessante, pois não precisa ter o Terraform instalado, basta executar o container que já é disponibilizado com um ambiente contendo o terraform. 

#### Rodando o container:

```shell
docker run -it -v $PWD:/app -w /app --entrypoint "" hashicorp/terraform:light sh
```
Com o comando assim, estamos executando um container e acessível já com bind volume para o local onde estão os arquivos .tf. Por isso, o comando de execução do container deve ser rodado onde estão os arquivos .tf.

**Obs.**: O comando deve ser executado em um terminal dentro do diretório terraform desse repositório.

### 2.2. Init

```shell
terraform init
```
Os nomes de arquivos pouco importam para o Terraform. Ele vai ler todos os arquivos .tf no diretório corrente. O terraform init vai inicializar tudo, faz as configurações e cria o arquivo de estados. Na primeira execução, será apresentado um erro, pois necessitamos de um key e secret do provider AWS, pois aqui está sendo o usado o backend para o arquivo de estado ser armazenado em um bucket S3 da AWS.

Há várias formas de passar a key e a secret para o terraform. Uma opção é através de variáveis de ambiente. No terminal do container, basta executar:

```shell
export AWS_ACCESS_KEY_ID="SEU ACCESS KEY AQUI"
export AWS_SECRET_ACCESS_KEY="SUA SECRET ACCESS AQUI"
```

### 2.3. Plan

```shell
terraform plan
```
O plan verifica o arquivo de estado e a infra que já existe e mostra o que será modificado, mas sem ainda fazer nenhuma modificação.

### 2.4. Apply

```shell
terraform apply
```
Após executar o plan, com o apply serão aplicadas as modificações.

### 2.5. Destroy

```shell
terraform destroy
```
Esse comando vai "tirar" tudo que está definido nos arquivos hcl, os arquivos .tf. É o inverso do comando apply. Ao executar o terraform destroy, é apresentado um plan de tudo que ele vai destruir. Você tem que confirmar. Alternativamente, pode-se utilizar o plan também para mostrar o que vai ser destruído:

```shell
terraform plan -destroy
```

### 2.6. Init upgrade

```shell
terraform init -upgrade
```
Com o -upgrade, o terraform vai atualizar os plugins

### 2.7. Plan -out

```shell
terraform plan -out=nome_do_plan
```
Ele vai gerar um arquivo do plan. Isso é boa prática.

Agora ao executar o apply, basta informar o nome do arquivo que foi gerado no plan.

```shell
terraform apply nome_do_arquivo_plan_gerado_no_plan
```

[Voltar ao Sumário](../README.md) - [Anterior](prereqs.md) - [Próximo](terraform_apply.md)