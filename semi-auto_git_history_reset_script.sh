#!/bin/bash

# Check if the current folder is a Git repository
# Verifica se a pasta atual é um repositório Git
if [ ! -d .git ]; then
    echo "This directory does not appear to be a Git repository."
    echo "Este diretório não parece ser um repositório Git."
    exit 1
fi

# Get the current remote repository
# Obter o repositório remoto atual
REPO_URL=$(git config --get remote.origin.url)

if [ -z "$REPO_URL" ]; then
    echo "Could not find the remote repository. Make sure this repository has 'origin' configured."
    exit 1
fi

# Remove the commit history
# Remover o histórico de commits
rm -rf .git

# Initialize a new Git repository
# Inicializar um novo repositório Git
git init

# Add all files to the new repository
# Adicionar todos os arquivos ao novo repositório
git add .

# Create the first commit
# Criar o primeiro commit
git commit -m "First commit without previous history"

# Rename the branch to 'main' (modern GitHub default)
# Renomear a branch para 'main' (padrão moderno do GitHub)
git branch -M main

# Add the remote repository
# Adicionar o repositório remoto
git remote add origin $REPO_URL

# Force push to the remote repository on the 'main' branch
# Forçar o envio para o repositório remoto na branch 'main'
git push --force origin main

# Delete the 'master' branch on the remote
# Deletar o branch 'master' no remoto
git push origin --delete master
echo "Master branch deleted on the remote repository."

echo "Commit history removed and new repository pushed to GitHub on the 'main' branch."

# Pause the script to allow the user to see the result
# Pausar o script para permitir que o usuário veja o resultado
read -p "Press any key to exit... Visit https://murilokrominski.github.io/Git-History-Reset-Script"
