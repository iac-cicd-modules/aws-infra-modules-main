## Criação de VPC

O módulo Terraform vpc é projetado para criar e gerenciar uma Virtual Private Cloud (VPC) na AWS. Este módulo facilita a configuração de uma VPC com sub-redes pública e privada, incluindo sub-redes para bancos de dados, em um ambiente específico.

```hcl
module "vpc" {
  for_each = var.vpcs
  source   = "./vpc"

  name        = var.vpcs[each.key].name
  environment = var.environment
  region      = var.aws_account.region
  vpcs        = var.vpcs
}
```

### Parâmetros

- source: O caminho do módulo para o vpc.
- region: A região da AWS onde a VPC será criada.
- environment: Ambiente de implantação ("dev","prod").
- name: Nome da VPC.
- vpcs: Mapa de objetos que definem as VPCs.

### Exemplo de definição de um VPC

```hcl
aws_account = {
  profile = "sx-dev"
  region  = "us-east-1"
}

environment = "dev"

tags = {
  environment = "dev"
  name        = "aws-infra-modules"
}

vpcs = {
  dev = {
    cidr_block = "10.1.0.0/16"
    name       = "apps"
    private_subnets = {
      "priv1" = {
        cidr_block = "10.1.1.0/24"
        name       = "dev-1"
        az         = "a"
      }
      "priv2" = {
        cidr_block = "10.1.2.0/24"
        name       = "dev-2"
        az         = "b"
      }
    }
    public_subnets = {
      "pub1" = {
        cidr_block = "10.1.3.0/24"
        name       = "dev-1"
        az         = "a"
      }
      "pub2" = {
        cidr_block = "10.1.4.0/24"
        name       = "dev-2"
        az         = "b"
      }
    }
  }
}
```

