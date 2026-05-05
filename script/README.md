# Popular banco de dados (ambiente de desenvolvimento)

Este script utiliza as factories dos testes para criar registros no banco de dados, de forma a popular o sistema com dados realistas. Isso facilita os testes manuais e a demonstração das funcionalidades.

Após executar este script, você poderá:

- Acessar o sistema com o usuário **admin**
- Acessar com os usuários colaboradores criados
- Utilizar a senha padrão: `123456`  
  (configurável via variável de ambiente `DEFAULT_COLABORADOR_PASSWORD`)

**Aviso**: Este script é destinado apenas para ambientes de desenvolvimento. Ele limpa os dados atuais do banco de dados para evitar conflitos, portanto, não deve ser executado em ambientes de produção ou com dados importantes.

---

## Execução

Abra um terminal na raiz do projeto e execute o comando abaixo:

```bash
docker exec django-dev sh -c "
# limpa os dados atuais no BD para evitar conflitos 
python manage.py flush --no-input &&

# define o nome do script como variável
NOME_SCRIPT='popular_bd.py' &&

# baixa o script
curl -O https://raw.githubusercontent.com/sirusifbaiano/sirus-docs/refs/heads/main/script/\$NOME_SCRIPT &&

# executa-o
python \$NOME_SCRIPT &&

# remove-o
rm \$NOME_SCRIPT
"
```