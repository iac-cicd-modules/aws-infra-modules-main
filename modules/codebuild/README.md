## Codebuild Module

O módulo Terraform codebuild é projetado para criar e gerenciar um projeto AWS CodeBuild na AWS. Esse módulo facilita a configuração de um ambiente de compilação personalizado com várias opções de personalização.

```
module "codebuild_1" {
  source       = "../../../modules/codebuild"
  name         = "ecs-build"
  account_id   = var.account_id
  region       = var.region
  compute_type = "BUILD_GENERAL1_MEDIUM"
}

```

### Parâmetros

* source: O caminho do módulo para o codebuild.
* name: Nome do projeto AWS CodeBuild.
* account_id: ID da conta AWS onde o CodeBuild será executado.
* region: Região AWS onde o CodeBuild será provisionado.
* compute_type: Tipo de instância de compilação a ser utilizado ("BUILD_GENERAL1_SMALL", "BUILD_GENERAL1_MEDIUM", "BUILD_GENERAL1_LARGE", etc.).