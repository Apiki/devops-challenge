[Voltar ao Sumário](../README.md) - [Anterior](ansible.md)

# Executando a playbook Ansible

Após ter configurado o ambiente com uso de virtual env no passo anterior, agora é executar a playbook para instalar e configurar um site com o Wordpress.

**Atenção**: Acrescentar no arquivo ansible/roles/wordpress/defaults/main.yml as variáveis, sobretudo as listadas abaixo:

```python
wp_db_user: informe_usuario_do_banco_aqui
wp_db_psw: informe_uma_senha_para_banco_aqui
db_root_psw: informe_uma_senha_de_root_db_aqui
```
Informe antes de executar a playbook, isso para provisionar um ambiente novo.

**Passo a passo:**

1. Após ter configurado o virtualenv, estando dentro diretório ***ansible***, execute a playbook:
   ```shell
    ansible-playbook -u ubuntu --private-key ../../apiki.pem -i ec2.py deploy.yml
   ```
   O comanado acima indica:
   - "-u" o nome do usuário que executará os comandos no host alvo, ***ubuntu***;
   - "--private-key" o caminho e nome da chave privada usada para conexão SSH. Observe que o caminho em seu computador pode ser diferente. Nunca commit essa chave para o git.
   - "-i" indica que o inventário será o arquivo ec2.py, módulo que fornece inventário dinâmico para AWS.
   - "deploy.yml" nome do arquivo que o comando ***ansible-playbook*** irá executar, ou seja, a playbook.

[Voltar ao Sumário](../README.md) - [Anterior](ansible.md)