## Application Loadbalancer 

O módulo Terraform alb é projetado para criar e gerenciar um Application Load Balancer (ALB) na AWS. Este módulo facilita a configuração de um ALB com suporte para ambientes internos e externos, integrando-se facilmente a uma Virtual Private Cloud (VPC) existente.

```
module "alb_main" {
  source          = "../../modules/alb"
  alb_name        = "sample"
  internal        = false
  environment     = var.environment
  vpc_id          = module.vpc_sample.vpc_id
  subnets         = module.vpc_sample.public_subnets
  certificate_arn = "arn:aws:acm:us-east-1:123456789120:certificate/xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
```
### Parâmetros

* source: O caminho do módulo para o alb.
* alb_name: Nome do Application Load Balancer.
* internal: Indica se o ALB é interno (true) ou externo (false).
* environment: Ambiente de implantação (e.g., "development", "production").
* vpc_id: ID da VPC à qual o ALB está associado.
* subnets: Lista de sub-redes onde o ALB será provisionado.
* certificate_arn: ARN do certificado ACM (AWS Certificate Manager) para uso com HTTPS.

