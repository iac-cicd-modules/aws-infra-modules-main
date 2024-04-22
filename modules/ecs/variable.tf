variable "name" {
  type        = string
  description = "Target group name"
}

variable "port" {
  type        = number
  description = "Target group port"

}

variable "vpc_id" {
  type        = string
  description = "VPC Id"

}

variable "health_check" {
  type        = string
  default     = null
  description = "Health Check path"

}

variable "listener_arn" {
  type        = string
  default     = null
  description = "Listener ARN"

}

variable "host_header" {
  type        = list(string)
  default     = []
  description = "Host Header rule"

}

variable "environment" {
  type = string
}

variable "protocol" {
  type    = string
  default = "HTTP"
}

variable "image_uri" {
  default     = null
  type        = string
  description = "Container image"
}

variable "cpu" {
  type        = number
  description = "Task definition CPU"
}

variable "memory" {
  type        = number
  description = "Task deifnition memory"
}

variable "essential" {
  type        = bool
  default     = true
  description = "Container essential"
}

variable "log_retention_days" {
  type        = number
  description = "Log retention in days"

}

variable "region" {
  type        = string
  description = "awslogs region"

}

variable "cluster_id" {
  type        = string
  description = "ECS Cluster ID"

}

variable "desired_count" {
  type        = string
  description = "ECS Service desired count"

}

variable "subnets" {
  type        = list(string)
  description = "Subnet list"

}

variable "assign_public_ip" {
  type        = bool
  description = "Assign public ip"

}

variable "load_balancer" {
  description = "Loadbalancer"
  type        = bool
  default     = false

}

variable "custom_policy" {
  type    = any
  default = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "s3:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF 

}


variable "existing_container_registry" {
  type    = bool
  default = false
}

variable "bucket_location" {
  type    = string
  default = null

}

variable "connection_arn" {
  type    = string
  default = null

}

variable "repository" {
  type    = string
  default = null

}

variable "branch" {
  type    = string
  default = null
}

variable "codebuild_name" {
  type    = string
  default = null
}

variable "cluster_name" {
  type    = string
  default = null
}

variable "docker_path" {
  type    = string
  default = "null"
}


variable "env_path" {
  type    = string
  default = "null"
}

variable "setup_pipeline" {
  type    = bool
  default = false

}

variable "launch_type" {
  type    = string
  default = "FARGATE"

}


variable "base" {
  type    = number
  default = 1

}


variable "weight" {
  type    = number
  default = 100

}

variable "force_new_deployment" {
  type    = bool
  default = false

}

variable "s3_path" {
  type        = string
  description = "S3 env var path"
}