#!/bin/bash
REPO="NOM DU REPO"
BRANCH=""
COMMIT_MESSAGE=""
FOLDER_PATH="./"
TOKEN = ""
USERNAME = ""

json='{"photo":['
for file in *.png *.jpg
do
    # Vérifie si le fichier existe et s'il s'agit d'un fichier régulier
    if [ -f "$file" ]; then
        # Obtention du nom, de la date et du chemin d'accès du fichier
        filename=$(basename "$file")
        name="${filename%.*}"
        date=$(date -r "$file" +%Y)
        path="$images_dir/$filename"

        # Ajout des données du fichier au format JSON
        json+='{"nom":"'$name'","date":'$date',"img":"'$path'"},'
    fi
done
json=${json%?}
json+=']}'
echo $json > BDD.json

git init
git remote add origin "https://github.com/${USERNAME}/${REPO}.git"
git fetch
git checkout -t origin/${BRANCH}
echo "Ajout des fichiers dans le référentiel Git..."
git add .
#git add ${FOLDER_PATH}*.jpg
#git add ${FOLDER_PATH}*.png
#git add ${FOLDER_PATH}*.json
git commit -m "${COMMIT_MESSAGE}"
echo "Les fichiers ont été ajoutés et le commit a été effectué avec succès."
echo "Push des modifications sur GitHub..."
git config --global user.email "philippe.delente@gmail.com"
git config --global user.name "philippe"
git push --set-upstream origin ${BRANCH}
echo "Les modifications ont été poussées sur GitHub avec succès."