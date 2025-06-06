# SERVIÇO DE ORQUESTRAÇÃO DE CONTEINERS [ SOC ]

__[descrição do repositório: ]__ Projeto que gerencia as informações de implementação e configuração do orquestrador de containers docker.

## BANCH X AMBIENTE

__[descrição da relação das branch para o ambiente da aplicação: ]__ Essa relação indica qual será o ambiente alvo a depender da branch do versionamento.

| Branch | Ambiente |
| --- | --- |
| develop | Aplica no ambiente __DSV__ |
| release/** | Aplica no ambiente __HMG__ |
| pre-release/** | Aplica no ambiente __STG__ |
| main | Aplica no ambiente __PRD__ |

## ESTRUTURA DO PROJETO

__[descrição da estrutura do diretório: ]__ Essa estrutura descreve quais são os diretórios do projeto.

``` text

├── .github
│   └── workflows
│       └── script
│           └── manifest.sh
│       └── namespace.yml
│       └── secrets.yml
│   └── branch_default_rule.json
│   └── dependabot.yml
│   └── tag_default_rule.json
├── app
│   └── namespace
│       └── deployment.yml
│   └── secrets
│       └── deployment.yml
├── docs
│   └── CONTRIBUTING.md
│   └── CODE_OF_CONDUCT.md
│   └── PULL_REQUEST_TEMPLATE.md
└── README.md
```

## INTRODUÇÃO

__[descrição da visão geral do projeto: ]__ Esse projeto tem a finalidade de documentar e padronizar o processo de instalação e configuração do servidor de gerenciamento a implementação, manutenção dos containers utilizados pelas aplicações.

### Kubernetes

__[descrição do aplicativo: ]__ Segundo o site oficial da aplicação, o kubernetes é um gerenciador de implementação e configuração de containers baseado num estrutura declarativa através de um arquivo contendo as informações necessárias do container, proporcionando o versionamento da instalação, configuração e manutenção além da possibilidade de automatização.

### Rancher

__[descrição do aplicativo: ]__ Segundo o site oficial da aplicação, o rancher é um software livre que administra os clusters kubernetes, fornece uma interface para o usuário administrar os clusters.

### Versões

__[relação das versões de aplicativos externos: ]__ A aplicação utiliza as seguintes versões:

| Software | Versão |
| --- | --- |
| Ubuntu | 24.04 |
| Docker | 27.5.1 |
| Rancher | 2.4.3 |
| Traefik | 1.7 |
| Longhorn | 0.8 |

### Requisitos

__[Relação dos requisitos necessários para concluir o tutorial: ]__ Os requisitos para prosseguir com a instalação e configuração são esses:

| Item | Descrição | Observação |
| --- | --- | --- |
| 1 | 4 máquinas virtuais com 2/4 processadores e 6/8 gb de memória ram | Numa hospedagem cloud de preferência com a instalção do SO Ubuntu 24.04|
| 2 | 1 domínio  | Devidamente configurado num serviço de Hospedagem DNS |

## INSTALAÇÃO

__[descrição da etapa instalação: ]__ Nessa seção é descrito as etapas necessárias para implentar a aplicação.

### Estrutura das Maquinas Virtuais [ VM ]

__[relação das VM: ]__ As maquinas serão distribuidas da seguinte maneira:

| Item | Descrição |
| --- | --- |
| 1 | Rancher Server |
| 2 | node-1 |
| 3 | node-2 |
| 4 | node-3 |

### Instalação Rancher Server

__[descrição do processo de instalação do rancher: ]__ Esse é o processo para instalação do aplicativo rancher na maquina virtual.

No terminal da maquina destinada para instalar o rancher execute os comandos abaixo:

```sh
sudo apt-get update &&  sudo apt install docker.io && y \
sudo docker run -d --name rancher-server --restart=always -v /opt/rancher:/var/lib/rancher  -p 80:80 -p 443:443 rancher/rancher:v2.4.3
```

### Instalação Node

__[descrição do processo de instalação dos nodes: ]__ Esse é o processo para instalação do aplicativo node-rancher nas maquinas virtuais.

No terminal das maquinas destinada para instalar os nodes execute os comandos abaixo:

```sh
sudo apt-get update &&  sudo apt install docker.io && y
```

Na interface do ranche configure o cluster, no final do processo será disponibilizado um script shell conforme exemplo abaixo:

``` text

sudo docker run -d --privileged --restart=unless-stopped --net=host -v /etc/kubernetes:/etc/kubernetes -v /var/run:/var/run rancher/rancher-agent:v2.4.3 --server https://rancher.{{dominio}}.site --token n6gmrf2mkbf77fm4w9znfdnfn5gxszrt5jjvn5vpl2q4525r6wn9rh --ca-checksum 9775da6d0427f86dfae6d5e6fc23b81f0f6925180937bc97c93c0cb8a1c88e7b --node-name node-1 --etcd --controlplane --worker

```

Execute o script fornecido nas vm destinadas aos nodes-rancher.

## Referência

- [Documentação Kubernetes](https://kubernetes.io/pt-br/docs/concepts/overview/)
- [Documentação Rancher](https://rancher.com/docs/)
- [Documentação Traefik](https://doc.traefik.io/traefik/)
- [Documentação Longhorn](https://longhorn.io/)

## Licença

> [!IMPORTANT]
> *O código fonte neste projeto não possui licença de uso.*

É terminantemente proibido reproduzir, distribuir, alterar, utilizar engenharia reversa ou valer-se de qualquer tentativa de reverter ao seu código-fonte qualquer dos componentes que compõem o SOFTWARE, bem como utilizar subterfúgios para burlar a quantidade de usuários licenciados.
