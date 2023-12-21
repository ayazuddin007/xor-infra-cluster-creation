import os, sys, subprocess
from python_terraform import *
from contextlib import redirect_stdout
import  git
from git import Repo
import boto3
import yaml


def backend_init(clusterRepoName,backend_tfvars_path):
    dir_name = '/home/ec2-user/'+clusterRepoName+'/backend'

    print("Backend ")
    tf = Terraform(working_dir=dir_name)
    approve = {"auto-approve": True}

        #tf.init()
    return_code, stdout, stderr = tf.init()
    with open('/home/ec2-user/backend_init.txt', 'w') as f:
        with redirect_stdout(f):
            print(stdout)
    file = open("/home/ec2-user/backend_init.txt", 'r')
    for line in file:
        if "Terraform has been successfully initialized!" in line:
            print(line)
            break
    file.close()
    

def backend_plan(clusterRepoName,backend_tfvars_path):
    dir_name = '/home/ec2-user/'+clusterRepoName+'/backend'
    tf = Terraform(working_dir=dir_name)
    approve = {"auto-approve": True}

    return_code, stdout, stderr = tf.plan(var_file=backend_tfvars_path)
    with open('/home/ec2-user/backend_plan.txt', 'w') as f:
        with redirect_stdout(f):
            print(stdout)
            print(stderr)
    file = open("/home/ec2-user/backend_plan.txt", 'r')
    for line in file:
        if "0 to change, 0 to destroy" in line:
            print(line)
            break
    file.close()


def backend_apply(clusterRepoName,backend_tfvars_path):
    dir_name = '/home/ec2-user/'+clusterRepoName+'/backend'
    tf = Terraform(working_dir=dir_name)
    approve = {"auto-approve": True}

    return_code, stdout, stderr = tf.apply(skip_plan=True,var_file=backend_tfvars_path)
    with open('/home/ec2-user/backend_apply.txt', 'w') as f:
        with redirect_stdout(f):
            print(stdout)
            print(stderr)
    file = open("/home/ec2-user/backend_apply.txt", 'r')
    for line in file:
        if "0 changed, 0 destroyed" in line:
            print(line)
            break
    file.close()


def environment_init(clusterRepoName,terraform_tfvars_path,backend_tfvars_path):
    dir_name = '/home/ec2-user/'+clusterRepoName+'/environmentCreation'
    print("environmentCreation ")
    tf = Terraform(working_dir=dir_name)
    approve = {"auto-approve": True}

    #tf.init()
    return_code, stdout, stderr = tf.init(backend_config=backend_tfvars_path)
    with open('/home/ec2-user/environmentCreation_init.txt', 'w') as f:
        with redirect_stdout(f):
            print(stdout)
    file = open("/home/ec2-user/environmentCreation_init.txt", 'r')
    for line in file:
        if "Terraform has been successfully initialized!" in line:
            print(line)
            break
    file.close()
    

def environment_plan(clusterRepoName,terraform_tfvars_path,backend_tfvars_path):
    dir_name = '/home/ec2-user/'+clusterRepoName+'/environmentCreation'
    tf = Terraform(working_dir=dir_name)
    approve = {"auto-approve": True}

    return_code, stdout, stderr = tf.plan(var_file=terraform_tfvars_path)
    with open('/home/ec2-user/environmentCreation_plan.txt', 'w') as f:
        with redirect_stdout(f):
            print(stdout)
            print(stderr)
    file = open("/home/ec2-user/environmentCreation_plan.txt", 'r')
    for line in file:
        if "0 to change, 0 to destroy" in line:
            print(line)
            break
    file.close()


def environment_apply(clusterRepoName,terraform_tfvars_path,backend_tfvars_path):
    dir_name = '/home/ec2-user/'+clusterRepoName+'/environmentCreation'
    tf = Terraform(working_dir=dir_name)
    approve = {"auto-approve": True}

    return_code, stdout, stderr = tf.apply(skip_plan=True,var_file=terraform_tfvars_path)
    with open('/home/ec2-user/environmentCreation_apply.txt', 'w') as f:
        with redirect_stdout(f):
            print(stdout)
            print(stderr)
    file = open("/home/ec2-user/environmentCreation_apply.txt", 'r')
    for line in file:
        if "0 changed, 0 destroyed" in line:
            print(line)
            break
    file.close()




def addons_init(clusterRepoName,terraform_tfvars_path,backend_tfvars_path):
    print("addons ")
    dir_name = '/home/ec2-user/'+clusterRepoName+'/add-ons'
    tf = Terraform(working_dir=dir_name)
    approve = {"auto-approve": True}


    #tf.init()
    return_code, stdout, stderr = tf.init(backend_config=backend_tfvars_path)
    with open('/home/ec2-user/add-ons_init.txt', 'w') as f:
        with redirect_stdout(f):
            print(stdout)
    file = open("/home/ec2-user/add-ons_init.txt", 'r')
    for line in file:
        if "Terraform has been successfully initialized!" in line:
            print(line)
            break
    file.close()      

def addons_plan(clusterRepoName,terraform_tfvars_path,backend_tfvars_path):
    dir_name = '/home/ec2-user/'+clusterRepoName+'/add-ons'
    tf = Terraform(working_dir=dir_name)
    approve = {"auto-approve": True}


    #tf.init()
    return_code, stdout, stderr = tf.plan(var_file=terraform_tfvars_path)
    with open('/home/ec2-user/add-ons_plan.txt', 'w') as f:
        with redirect_stdout(f):
            print(stdout)
            print(stderr)
    file = open("/home/ec2-user/add-ons_plan.txt", 'r')
    for line in file:
        if "0 to change, 0 to destroy" in line:
            print(line)
            break
    file.close()

def addons_apply(clusterRepoName,terraform_tfvars_path,backend_tfvars_path):
    dir_name = '/home/ec2-user/'+clusterRepoName+'/add-ons'
    tf = Terraform(working_dir=dir_name)
    approve = {"auto-approve": True}


    #tf.init()
    return_code, stdout, stderr = tf.apply(skip_plan=True,var_file=terraform_tfvars_path)
    with open('/home/ec2-user/add-ons_apply.txt', 'w') as f:
        with redirect_stdout(f):
            print(stdout)
            print(stderr)
    file = open("/home/ec2-user/add-ons_apply.txt", 'r')
    for line in file:
        if "0 changed, 0 destroyed" in line:
            print(line)
            break
    file.close()



def cluster_init(clusterRepoName,terraform_tfvars_path,backend_tfvars_path):
    dir_name = '/home/ec2-user/'+clusterRepoName+'/eks-cluster'
    print("eks_cluster")
    tf = Terraform(working_dir=dir_name)
    approve = {"auto-approve": True}

    #tf.init()
    return_code, stdout, stderr = tf.init(backend_config=backend_tfvars_path)
    with open('/home/ec2-user/cluster_init.txt', 'w') as f:
        with redirect_stdout(f):
            print(stdout)
    file = open("/home/ec2-user/cluster_init.txt", 'r')
    for line in file:
        if "Terraform has been successfully initialized!" in line:
            print(line)
            break
    file.close()

      

def cluster_plan(clusterRepoName,terraform_tfvars_path,backend_tfvars_path):
    dir_name = '/home/ec2-user/'+clusterRepoName+'/eks-cluster'
    tf = Terraform(working_dir=dir_name)
    approve = {"auto-approve": True}


    #tf.init()
    return_code, stdout, stderr = tf.plan(var_file=terraform_tfvars_path)
    with open('/home/ec2-user/cluster_plan.txt', 'w') as f:
        with redirect_stdout(f):
            print(stdout)
            print(stderr)
    file = open("/home/ec2-user/cluster_plan.txt", 'r')
    for line in file:
        if "0 to change, 0 to destroy" in line:
            print(line)
            break
    file.close()

def cluster_apply(clusterRepoName,terraform_tfvars_path,backend_tfvars_path):
    dir_name = '/home/ec2-user/'+clusterRepoName+'/eks-cluster'

    tf = Terraform(working_dir=dir_name)
    approve = {"auto-approve": True}


    #tf.init()
    return_code, stdout, stderr = tf.apply(skip_plan=True,var_file=terraform_tfvars_path)
    with open('/home/ec2-user/cluster_apply.txt', 'w') as f:
        with redirect_stdout(f):
            print(stdout)
            print(stderr)
    file = open("/home/ec2-user/cluster_apply.txt", 'r')
    for line in file:
        if "0 changed, 0 destroyed" in line:
            print(line)
            break
    file.close()


if __name__ == "__main__":

    with open('./datas.yaml','r') as file:
        terrafom_tfvars = yaml.safe_load(file)

    clusterRepoName = terrafom_tfvars["clusterRepoName"]
    # clusterRepoName = "wex-ifcs-infrastructure-creation"
    terraform_tfvars_path = '/home/ec2-user/'+clusterRepoName+'/terraform.tfvars'
    backend_tfvars_path = '/home/ec2-user/'+clusterRepoName+'/backend.tfvars'
    

    print(clusterRepoName)
    print(terraform_tfvars_path)
    print(backend_tfvars_path)

    backend_init(clusterRepoName,backend_tfvars_path)
    backend_plan(clusterRepoName,backend_tfvars_path)
    backend_apply(clusterRepoName,backend_tfvars_path)
    cluster_init(clusterRepoName,terraform_tfvars_path,backend_tfvars_path)
    cluster_plan(clusterRepoName,terraform_tfvars_path,backend_tfvars_path)
    cluster_apply(clusterRepoName,terraform_tfvars_path,backend_tfvars_path)
    addons_init(clusterRepoName,terraform_tfvars_path,backend_tfvars_path)
    addons_plan(clusterRepoName,terraform_tfvars_path,backend_tfvars_path)
    addons_apply(clusterRepoName,terraform_tfvars_path,backend_tfvars_path)
    environment_init(clusterRepoName,terraform_tfvars_path,backend_tfvars_path)
    environment_plan(clusterRepoName,terraform_tfvars_path,backend_tfvars_path)
    environment_apply(clusterRepoName,terraform_tfvars_path,backend_tfvars_path)
