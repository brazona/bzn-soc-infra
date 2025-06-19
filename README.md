# ORQUESTRAÇÃO DE CONTAINERS [ SOC ]

__[descrição do repositório: ]__ Projeto que gerencia as informações de implementação e configuração do orquestrador de containers docker.

## Identificadores da Aplicação

| Sigla | Descrição do Projeto | Nome Aplicativo |
| --- | --- | --- |
| SOC | Serviço de Orquestração de Conteiners | bzn-soc-infra |

__[relação das versões de aplicativos externos: ]__ A aplicação utiliza as seguintes versões:

| Software | Versão |
| --- | --- |
| Ubuntu | 16.04 LTS |
| Docker | 18.09.7 |
| Rancher | 2.4.3|
| Traefik | 1.7 |
| Longhorn | 0.8.0 |

## Pre Requisitos

- 4 máquinas virtuais com 2/4 processadores e 6/8 gb de memória ram
- 1 domínio
- Sistema operacional Ubuntu 16.04 LTS

## Tabela Branch x Ambiente

| Branch | Ambiente |
| --- | --- |
| develop | Aplica no ambiente __DSV__ |
| release/** | Aplica no ambiente __HMG__ |
| pre-release/** | Aplica no ambiente __STG__ |
| main | Aplica no ambiente __PRD__ |

## Estrutura do projeto

__[descrição da estrutura do diretório: ]__

``` text

├── .github
│    └── branch_ruleset.yml
│    └── dependabot.yml
├── app
│   └── exemplo
│       └── grafana
│           └── deployment.yml
│       └── zipkin
│           └── deployment.yml
│   └── namespace
│       └── deployment.yml
│   └── traefik
│       └── deployment.yml
├── docs
│   └── CONTRIBUTING.md
│   └── CODE_OF_CONDUCT.md
│   └── PULL_REQUEST_TEMPLATE.md
│   └── SECURITY.md
└── .gitignore
└── README.md
```

## Rancher

Nessa etapa será instalado e configurado o software rancher para gerenciamento dos containers e cluster.

### Rancher Server: DNS

Crie uma vm cloud conforme definido nos requisitos, nomei como __rancher-server__  e atribua um subconjunto de dns __rancher.${dominio.com.br}__ para o ip publico dela.

### Rancher Server: INSTALAÇÃO

Acesse o terminal da vm destinada ao rancher server, e execute os comandos abaixos:

```bash
sudo apt-get -y update && sudo apt install -y docker.io && \
sudo docker run -d --name rancher-server --restart=always -v /opt/rancher:/var/lib/rancher  -p 80:80 -p 443:443 --privileged rancher/rancher:v2.4.3
```

Através do dns __rancher.${dominio.com.br}__ acesse a interface gráfica da aplicação e configure os seguintes passos:

- Cluster: Crie um cluster conforme exemplificado no video: </br> ![alt-text](./app/assets/screen-capture-rancher-cluster.gif)

Ao final do processo será disponibilizado um comando bash como exemplo abaixo: 

```bash
sudo docker run -d --privileged --restart=unless-stopped --net=host -v /etc/kubernetes:/etc/kubernetes -v /var/run:/var/run rancher/rancher-agent:v2.4.3 --server https://rancher.${dominio.com.br}--token kmpngnhs78rcvspfb6qmtlsfzl2hpn2g2fjwftp7hzn4rwldx9hqtw --ca-checksum 60cbc91998948d56ff92b7dd999c759e8671597b1ee22541a152f12dda4de0a6 --node-name node-1 --etcd --controlplane --worker
```

### Rancher Node: DNS

Crie três vm cloud conforme definido nos requisitos, nomei como __node-1, node-2 e node-3__  e atribua um subconjunto de dns __*.app.${dominio.com.br}__ para o ip publico delas.

### Rancher Node: INSTALAÇÃO

Acesse o terminal das três vm destinada ao node, e execute os comandos abaixos conforme exemplificado no video a seguir: </br> ![alt-text](./app/assets/screen-capture-rancher-nodes.gif)

```bash
sudo apt-get -y update && sudo apt install -y docker.io
```

> Somente exemplo:

```bash
sudo docker run -d --privileged --restart=unless-stopped --net=host -v /etc/kubernetes:/etc/kubernetes -v /var/run:/var/run rancher/rancher-agent:v2.4.3 --server https://rancher.${dominio.com.br} --token kmpngnhs78rcvspfb6qmtlsfzl2hpn2g2fjwftp7hzn4rwldx9hqtw --ca-checksum 60cbc91998948d56ff92b7dd999c759e8671597b1ee22541a152f12dda4de0a6 --node-name node-1 --etcd --controlplane --worker
```

### Rancher Server: CONFIGURAÇÃO

Através do dns __rancher.${dominio.com.br}__ acesse a interface gráfica da aplicação e configure os seguintes passos:

### Rancher Server: CONFIGURAÇÃO/NAMESPACE

Através da interface gráfica do rancher server selecione o manifesto yml desse repositório disponível no diretório: </br> [./app/namespace/deployment.yml](./app/namespace/deployment.yml), conforme exemplo do video a seguir: </br> ![alt-text](./app/assets/screen-capture-rancher-cluster-namespace.gif)

### Rancher Server: CONFIGURAÇÃO/TRAEFIK

Através da interface gráfica do rancher server execute o comando a seguir:

```bash
kubectl apply -f https://raw.githubusercontent.com/containous/traefik/v1.7/examples/k8s/traefik-rbac.yaml && \
kubectl apply -f https://raw.githubusercontent.com/containous/traefik/v1.7/examples/k8s/traefik-ds.yaml
```

Ainda na interface e após o termino da execução, selecione o manifesto yml desse repositório disponível no diretório: </br> [./app/traefik/deployment.yml](./app/traefik/deployment.yml), conforme exemplo do video a seguir: </br> ![alt-text](./app/assets/screen-capture-rancher-cluster-traefik.gif)

### Rancher Server: CONFIGURAÇÃO/LONGHORN

selecione ${cluester}/System/Apps e clique em Launch e instale o app LONGHORN v0.8.0, conforme video exemplificado a seguir:

</br> ![alt-text](./app/assets/screen-capture-rancher-cluster-longhorn.gif)

### Rancher Server: EXEMPLO

Para validar a instalação e configuração do Rancher publique através da interface gráfica os manifesto xxx e xxx desse repositório disponíveis no diretório xxx e xxx, os aplicativos devem estar disponíveis nas url abaixo:

- [http://zipkin.exemplo.app.brazona.com.br/](http://zipkin.exemplo.app.brazona.com.br/)
- [http://grafana.exemplo.app.brazona.com.br/](http://grafana.exemplo.app.brazona.com.br/)

## Licença

> [!IMPORTANT]
> *O código fonte neste projeto não possui licença de uso.*

É terminantemente proibido reproduzir, distribuir, alterar, utilizar engenharia reversa ou valer-se de qualquer tentativa de reverter ao seu código-fonte qualquer dos componentes que compõem o SOFTWARE, bem como utilizar subterfúgios para burlar a quantidade de usuários licenciados.
