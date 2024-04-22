# ECS Fargate Module

O módulo Terraform ecs é projetado para criar e gerenciar um cluster ECS (Amazon Elastic Container Service) na AWS. Ele fornece uma maneira fácil de configurar um cluster ECS com capacidade de fornecimento flexível, incluindo suporte para Fargate e Fargate Spot.


## Criação de Cluster ECS

```
module "cluster" {
  source            = "../../../modules/ecs_cluster"
  name              = "ecs"
  environment       = var.environment
  capacity_provider = ["FARGATE", "FARGATE_SPOT"]
}

```

### Parâmetros
* source: O caminho do módulo para o ecs_cluster.
* name: Nome do cluster ECS.
* environment: Ambiente de implantação ("dev", "prod").
* capacity_provider: Lista de provedores de capacidade suportados, como FARGATE e FARGATE_SPOT.


## Criação de Service,Task Definition e pipeline

```
module "ecs-1" {
  cluster_id            = module.cluster.id
  source                = "../../../modules/ecs"
  name                  = "api"
  environment           = var.environment
  force_new_deployment  = false
  launch_type           = "FARGATE_SPOT"

  // Configuração da Task Definition
  port                  = 80
  desired_count         = 1
  cpu                   = 512
  memory                = 1024
  log_retention_days    = 7
  s3_path               = "ecs-envs/homolog/file.env"

  // Configuração da Rede
  region                = var.region
  vpc_id                = var.vpc_id
  subnets               = var.private_subnets
  assign_public_ip      = false

  // Configuração do Load Balancer
  load_balancer         = true
  listener_arn          = module.alb_main.listener_arn
  host_header           = ["sample.example.com"]
  health_check          = "/"

  // Configuração do Pipeline
  setup_pipeline        = true
  bucket_location       = "codepipeline-sample-s3"
  connection_arn        = var.connection_arn
  repository            = "kxc-tecnologia/sample-repo"
  branch                = "main"
  codebuild_name        = module.codebuild_1.name
  cluster_name          = module.cluster.name
  docker_path           = "./Dockerfile"
}

```

### Parâmetros
* cluster_id: O ID do cluster ECS ao qual o serviço será associado.
* source: O caminho do módulo para o ecs.
* name: Nome do serviço ECS.
* environment: Ambiente de implantação ("dev", "prod").
* force_new_deployment: Indica se deve forçar uma nova implantação do serviço. Configurar como `true` somente se desejar trocar o launch_type
* launch_type: Tipo de lançamento do serviço (FARGATE, FARGATE_SPOT ou BALANCED).

#### Configuração da Task Definition
* port: Porta exposta pelo serviço.
* desired_count: Número desejado de tarefas em execução.
* cpu: Unidades de CPU alocadas para a tarefa.
* memory: Memória alocada para a tarefa.
* log_retention_days: Número de dias para retenção de logs.
* s3_path: Caminho no S3 para o arquivo de ambiente.
#### Configuração da Rede
* region: Região da AWS.
* vpc_id: ID da VPC na qual o serviço será executado.
* subnets: Lista de sub-redes para o serviço.
* assign_public_ip: Indica se o serviço terá um IP público.
* Configuração do Load Balancer
* load_balancer: Indica se um balanceador de carga será associado ao serviço.
* listener_arn: ARN do ouvinte do balanceador de carga.
* host_header: Lista de cabeçalhos de host permitidos.
* health_check: Caminho para o ponto de verificação de integridade.
#### Configuração do Pipeline
* setup_pipeline: Indica se um pipeline de CI/CD será configurado.
* bucket_location: Nome do bucket para armazenamento de artefatos.
* connection_arn: ARN da conexão do CodePipeline.
* repository: Repositório do código-fonte.
* branch: Ramo do repositório.
* codebuild_name: Nome do projeto CodeBuild associado.(Sempre utilizar um módulo de codebuild para gerenciar a step de build)
* cluster_name: Nome do cluster ECS associado.
* docker_path: Caminho para o Dockerfile do serviço.


## Trabalhando com Capacity Providers Strategy

Atualmente esse módulo suporta o tipo de execução de tarefas de 3 formas: FARGATE, FARGATE_SPOT e BALANCED.


### FARGATE

```
launch_type = "FARGATE"
```

Se o valor especficiado em `launch_type` for "FARGATE", as tarefas lançadas pelo serviço terão o tipo de cobrança padrão, de acordo com a documentação oficial.


```
launch_type = "FARGATE_SPOT"
```

Se o valor especficiado em `launch_type` for fas lançadas pelo serviço terão o tipo de cobrança SPOT, para clientes que procuram uma"FARGATE_SPOT", as tare maneira econômica de executar contêineres.O preço (por hora de CPU e GB-hora) de uma tarefa Spot é variável, com um desconto de 50% a 70% do preço de uma tarefa sob demanda, e uma tarefa Fargate Spot pode ser interrompida (ou seja, parar) quando a AWS precisar da capacidade de volta para atender outros clientes sob demanda.

```
launch_type = "BALANCED"
```

Se o valor especficiado em `launch_type` for fas lançadas pelo serviço terão o tipo de cobrança balanceada entre FARGATE e FARGATE_SPOT. Por padrão, essa opção terá 1 réplica base FARGATE(On-demand) e o restante das reṕlicas serão FARGATE_SPOT (Spot). 

Para gerenciar a distribuição, temos 2 variáveis.

```
base = 2  #default = 1
```

Essa variável representa a capacidade base FARGATE(On-Demand) que será associada ao provedor de capacidade quando o launch_type for "BALANCED". A capacidade base é a quantidade mínima de capacidade que o provedor de capacidade terá disponível para alocar tarefas. Isso ajuda a garantir maior disponibilidade no caso de um container spot ser encerrado.

```
weight = 4 #default = 100
```

Essa variável representa o peso relativo associado ao provedor de capacidade quando o launch_type for "BALANCED". O peso determina a proporção de tarefas alocadas para cada provedor de capacidade em relação aos outros provedores.

Selecionei um Peso (Weight) de 4 para FARGATE_SPOT e 2 para FARGATE. Isto significa que para cada 6 tarefas, 4 são iniciadas no FARGATE_SPOT e 2 FARGATE. Você pode distribuir isso como achar mais conveniente. Mais tarefas no Fargate Spot significam mais economia. Mas se sua carga de trabalho requer alta disponibilidade e você não está confortável com interrupções, comece com uma proporção que funcione melhor para você.