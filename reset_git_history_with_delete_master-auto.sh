#!/bin/bash

# Nome do script a ser executado em cada repositório
SCRIPT_NAME="reset_git_history_with_delete_master-auto.sh"

# Verifica cada subdiretório no nível atual
for dir in */; do
    # Verifica se o diretório é um repositório Git
    if [ -d "$dir/.git" ]; then
        echo "Executando o script no repositório: $dir"
        
        # Entra no diretório
        cd "$dir" || continue
        
        # Executa o script de reset de histórico com o nome correto
        if [ -f "./$SCRIPT_NAME" ]; then
            bash "./$SCRIPT_NAME"
            
            # Publica automaticamente o branch main no GitHub
            echo "Publicando o branch main no repositório remoto do $dir"
            git push --force origin main
        else
            echo "O script $SCRIPT_NAME não foi encontrado no diretório $dir."
        fi
        
        # Volta para o diretório superior
        cd ..
    else
        echo "$dir não é um repositório Git. Pulando."
    fi
done

# Mensagem final para indicar que o processo foi concluído
echo "Processo concluído para todos os repositórios Git."
