#!/bin/bash
if [ $# -eq 4 ]; then
   DIRETORIO_ENV=$(echo $1)
   DIR_MANIFEST_IN=$(echo $2)
   DIR_MANIFEST_OUT=$(echo $3)
   DOCKER_IMAGE_TAG=$(echo $4)
else
    echo "Parâmentro: DIRETORIO_ENV, é obrigatório";
    echo "Parâmentro: DIR_MANIFEST_IN, é obrigatório";
    echo "Parâmentro: DIR_MANIFEST_OUT, é obrigatório";
    echo "Parâmentro: DOCKER_IMAGE_TAG, é obrigatório";
    echo -e "Exemplo:\nbash ../github-actions-share/.github/workflows/scripts/manifest.sh site/env.txt site/deployment.yml site/deployment-temp.yml 0.0.1-snapshot-9";
    exit 1
fi

sed -i 's/\s\+/\n/g' $DIRETORIO_ENV
find='_TAG_'
sed -i 's,'$find','$DOCKER_IMAGE_TAG',' $DIRETORIO_ENV
rm -rf $DIR_MANIFEST_OUT
cp  $DIR_MANIFEST_IN $DIR_MANIFEST_OUT
## Exporta as variaveis de ambiente do arquivo temporário
export $(grep -v '^#' $DIRETORIO_ENV | xargs) && env
## Substitui os valores do arquivo .env para o manisfesto temporário
envsubst < $DIR_MANIFEST_IN > $DIR_MANIFEST_OUT

