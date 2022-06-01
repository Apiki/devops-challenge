# Passos para a instalação e configuração das ferramentas do desafio. (executar como root)

1. `apt update && apt -y install nginx ca-certificates curl gnupg lsb-release`
2. `mkdir -p /etc/apt/keyrings`
3. `curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg`
4. `echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null`
5. `apt update`
6. `apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin`
7. 
