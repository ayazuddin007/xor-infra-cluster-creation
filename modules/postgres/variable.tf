variable "cluster_identifier"{
    type = string
}

variable "db_name" {
    type = string
}

variable "pg_username"{
    type = string

}

variable "engine_version"{
    type = string
}

variable "kms_key_id"{
    type = string
}

variable "port"{
    type = number
}

variable "instance_identifier"{
    type = string
}

variable "instance_class"{
    type = string
}

variable "client_name"{
    type = string
}

variable "env_ns"{
    type = string
}

variable "vpc_id"{
    type = string
}

variable "line_of_bussiness"{
    type = string
}

variable "environment"{
    type = string
}

variable "subnet_ids"{
    type = list
}

variable "db_username"{
    type = string
}

variable "schema_name"{
    type = string
}

variable "postgresFlag"{
    type = number
}

variable "instance_count"{
    type = number
}

variable "tags"{
    type = map
}

variable "final_snapshot_identifier"{
    type = string
}

variable "preferred_backup_window"{
    type = string
}

variable "preferred_maintenance_window"{
    type = string
}

variable "skip_final_snapshot"{
    type = string
}

variable "allocated_storage"{
    type = number
}

variable "storage_type"{
    type = string
}

variable "lob"{
    type = string
}

variable "envSubdomain"{
    type = string
}

variable "branch"{
    type = string
}







