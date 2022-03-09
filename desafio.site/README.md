# Desafio DevOps Apiki
## _Projeto desafio.site_  
**_por T. Fontoura_**

O desafio lançado pela Apiki é automatizar a criação de containers em uma instância AWS, instalando Wordpress com Apache, tendo Nginx como proxy reverso.

Aceitei o desafio e, para incrementar um pouco, resolvi desenvolver um pequeno projeto que permitisse uma instalação simples, com poucas instruções, com o objetivo de resumir a instalação a apenas uma linha de comando. Assim todo o processo seria mais amigável.
Denominei o projeto de *desafio.site*, por motivos que serão mostrados a seguir.

---
## Instalação

1. Crie uma instância EC-2 AWS com a imagem: 
 > Ubuntu Server 20.04 LTS (HVM), SSD Volume Type - ami-04505e74c0741db8d (64-bit x86) 

2. Coloque a instância em um grupo de segurança que tenha as portas 80, 443 e 22 abertas

3. Acesse a instância por SSH

4. Rode a seguinte linha de comando na shell:

```sh
curl https://desafio.site/init.sh | sudo bash
```
Isso é tudo. Aguarde a instalação.✨
 
---
## Como foi feito

- Criei um bucket S3 com o nome desafio.site e o configurei para site estático, ficando com o endereço web desafio.site.s3-website-us-east-1.amazonaws.com. Poderia utilizar este domínio, mas resolvi ir mais em frente, para poder demonstrar um pouco do meu conhecimento em domínios e DNS
- Registrei o domínio [desafio.site](https://desafio.site)
- Criei um registro CNAME no DNS apontando [desafio.site](https://desafio.site) para desafio.site.s3-website-us-east-1.amazonaws.com
- Escrevi o script de automatização init.sh e coloquei no website
- Criei arquivo robots.txt para não permitir que fosse indexado

---
 ## Observações

Como este é um projeto rápido para avaliação, não foram levadas em consideração questões de segurança e outros pontos, como por exemplo: 
- Poderíamos criar senhas randômicas, poderíamos criar automaticamente, usando lambda e Cloudflare API, um subdominio de desafio.site para o novo servidor (nome que pode ser entrado manualmente, e assim já criar pastas para ele no ESF), etc.

Não utilizei RDS nem EFS para que o projeto fosse mais facilmente reproduzido no servidor interno Apiki. Mas em um projeto desses para produção, eu faço um pouco diferente:
 - Crio imagens customizadas com docker instalado e já com EFS no fstab, montado. Tudo o que preciso já está naquela imagem.  
 - Uso RDS ou um cluster master+slave ou Galera como db.


Enfim, este é um projeto feito em pouco tempo. Não está perfeito, mas espero que sirva para avaliação.


---
## Licença
Copyright T. Fontoura 2022 - Todos os direitos reservados


