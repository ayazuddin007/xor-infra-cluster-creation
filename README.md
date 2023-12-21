# xor-infra-cluster-creation

This repo contains a set of Terraform modules that can be used to provision an Elastic Kubernetes (EKS) cluster on AWS.

# Components provisioned by terraform scripts

- EKS Cluster
- Application load balancer
- Consul
- EFS
- Cluster autoscaler
- Mongodb
- Sqs
- Prometheus and grafana
- Nginx ingress controller
- Alb_ingress
- Namespaces

# Requirements

| Name          | Version      | 
| ------------- | -------------| 
| `terraform`   | >= 0.12      |


# Inputs

| Name                                   | Description                                                                 | Type     |
| ---------------------------------------| ----------------------------------------------------------------------------| -------- |
| client_name                            | Name of client                                                              | String   |
| client_id                              | ID of client                                                                | String   |
| environment                            | Environment name (eg. dev,qa,uat etc)                                       | String   |
| region_name                            | Name of the region                                                          | String   |
| cluster_subnets                        | List of private subnet ids                                                  | List     |
| Node_group_subnets                     | List of subnets for nodegroup                                               | List     |
| vpc_id                                 | VPC id                                                                      | String   |
| vpc_cidr                               | cidr of target VPC                                                          | String   |
| aws_region	                           | The region id	                                                             | String   |
| Node_group_ami_id	                     | AMI ID for nodegroup                                                        | String   |
| Node_group_scaling_config_min_size     | Min size of node group                                                      | Number   |
| Node_group_scaling_config_max_size	   | Max size of node group                                                      | Number   |
| Node_group_scaling_config_desired_size | Desired size of node group	                                                 | Number   | 
| Node_group_instance_type               | Instance type                                                               | String   |
| Nodegroup_ebs_volume                   | EBS volume for nodegroup                                                    | Number   |
| acm_arn                                | List of certificate arn for each target environment.                        | List     |
|	target_env_ns                          | List of all the environment/namespace that will be residing in the cluster  | List     |
| TA_deadletter_maxReceiveCount          | List of TA Deadletter max receive count for each target environment.        | List     |
| COMPLETION_deadletter_maxReceiveCount	 | List of COMPLETION Deadletter max receive count for each target environment | List     |
| mongodbusername	                       | List of username for each target environment                                | List     |
| mongodbpassword	                       | List of password for each target environment	                               | List     |
| mongodbInstanceClass                   | List of Instance type for each target environment	                         | List     |
| mongodbclusterName	                   | List of name of mongodb cluster to be create in each target environment     | List     |
| clusterParameterGroupfamilyVersion     | Version of cluster Parameter Group family                                   | List     |
| clusterPort                            | Port no. for mongodb cluster                                                | List     |
| pub_hosted_zone_id                     | Zone id of public hosted zone                                               | String   |
| priv_hosted_zone_id	                   | Zone id of private hosted zone                                              | String   |
| record_name	                           | List of route53 record name for mongodb.                                    | List     |
| envSubDomain                           | List of environment subdomain                                               | List     |
| consul_arn_acm                         | acm arn for consul.                                                         | String   |
| Owner	                                 | This value is used to populate the value of tag Owner	                     | String   |
| line_of_bussiness	                     | This value is used to populate the value of tag LOB                         | String   |
| Application	                           | This value is used to populate the value of tag Application	               | String   |
| installPrometheusandGrafana	           | Whether to install prometheus and grafana or not                            | String   |
| installConsul                          | Whether to install consul or not                                            | String   |
| createSQSqueue	                       | Whether to create sqs queue or not in each target environment	             | List     |
| createMongodb	                         | Whether to create mongodb or not in each target environment                 | List     |


# Usage
To run this example you need to execute below command in each folder mentioned below:
- eks-cluster
- add-ons
- environmentCreation

```bash
  $ terraform init
  $ terraform plan -var-file="../terraform.tfvars"
  $ terraform apply -var-file="../terraform.tfvars"
``` 
