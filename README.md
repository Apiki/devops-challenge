# Desafio DevOps Apiki.

1º Faça clone do repositório https://github.com/lucasaffonso0/jose-lucas.git
  
	git clone https://github.com/lucasaffonso0/jose-lucas.git
	
2º Copie a chave .pem enviada via email, para a pasta jose-lucas

3º Dê permissão de execução ao script init.sh
  
	sudo chmod +x init.sh
	
4º Dê **somente** permissão de leitura a chave .pem recebida via email
  
	sudo chmod 400 lucas_apiki.pem
	
5º Execute o script init.sh
  
	sudo ./init.sh

Se tudo ocorreu bem a instalação do wordpress estará no link abaixo:

  http://ec2-18-230-192-189.sa-east-1.compute.amazonaws.com/
