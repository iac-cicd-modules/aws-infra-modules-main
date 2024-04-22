## Criação de VPC 

O módulo Terraform vpc é projetado para criar e gerenciar uma Virtual Private Cloud (VPC) na AWS. Este módulo facilita a configuração de uma VPC com sub-redes pública e privada, incluindo sub-redes para bancos de dados, em um ambiente específico.

```
module "vpc_sample" {
  source                = "../../modules/vpc"
  region                = var.region
  environment           = var.environment
  name                  = "sample"
  vpc_cidr              = "10.132.0.0/16"
  private_subnet_1_cidr = "10.132.0.0/22"
  private_subnet_2_cidr = "10.132.4.0/22"
  private_subnet_3_cidr = "10.132.8.0/22"
  db_subnet_1_cidr      = "10.132.12.0/24"
  db_subnet_2_cidr      = "10.132.13.0/24"
  db_subnet_3_cidr      = "10.132.14.0/24"
  public_subnet_1_cidr  = "10.132.252.0/24"
  public_subnet_2_cidr  = "10.132.253.0/24"
  public_subnet_3_cidr  = "10.132.254.0/24"
}
```

### Parâmetros

* source: O caminho do módulo para o vpc.
* region: A região da AWS onde a VPC será criada.
* environment: Ambiente de implantação ("dev","prod").
* name: Nome da VPC.
* vpc_cidr: O bloco CIDR da VPC.
* private_subnet_1_cidr: Bloco CIDR da primeira sub-rede privada.
* private_subnet_2_cidr: Bloco CIDR da segunda sub-rede privada.
* private_subnet_3_cidr: Bloco CIDR da terceira sub-rede privada.
* db_subnet_1_cidr: Bloco CIDR da primeira sub-rede para bancos de dados.
* db_subnet_2_cidr: Bloco CIDR da segunda sub-rede para bancos de dados.
* db_subnet_3_cidr: Bloco CIDR da terceira sub-rede para bancos de dados.
* public_subnet_1_cidr: Bloco CIDR da primeira sub-rede pública.
* public_subnet_2_cidr: Bloco CIDR da segunda sub-rede pública.
* public_subnet_3_cidr: Bloco CIDR da terceira sub-rede pública.