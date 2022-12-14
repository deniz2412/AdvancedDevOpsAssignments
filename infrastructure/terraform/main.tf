#Import existing RG
module "import-rg" {
  source = "./modules/import-resource-group"

}
#Local tag declaration used in every module
locals {
  tags = {
    OWNER = "Deniz"
  }
}
#Provision Virtual network required in the resource group
module "create-network" {
  source   = "./modules/create-network"
  location = module.import-rg.location
  prefix   = var.prefix
  rg-name  = module.import-rg.name
  tags = merge(local.tags, {
    GROUP = "Network"
  })
}
#Provision master machine for CI/CD pipeline
module "create-master-jenkins-vm" {
  source            = "./modules/create-machine"
  location          = module.import-rg.location
  rg-name           = module.import-rg.name
  NSG-ID            = module.create-network.nsg-id
  vm-name           = "JENKINS-MASTER"
  prefix            = var.prefix
  subnet-id         = module.create-network.subnet-id
  domain_name_label = "jenkinsmaster7f52f"
  tags = merge(local.tags, {
    GROUP = "Pipeline"
    ROLE  = "Master"
  })
}
#Provision worker machine for CI/CD pipeline
module "create-worker-jenkins-vm" {
  source    = "./modules/create-machine"
  location  = module.import-rg.location
  rg-name   = module.import-rg.name
  NSG-ID    = module.create-network.nsg-id
  vm-name   = "JENKINS-WORKER"
  prefix    = var.prefix
  subnet-id = module.create-network.subnet-id
  tags = merge(local.tags, {
    GROUP = "Pipeline"
    ROLE  = "Worker"

  })
  size = "Standard_B2ms"
}
#Creates AZ Application Gateway
module "application-gateway" {
  source = "./modules/create-appgw"
  location = module.import-rg.location
  rg-name  = module.import-rg.name
  prefix   = var.prefix
  aks_fqdn = module.deploy-cluster.fqdn
  tags = local.tags
}
#Cluster deployment- module with all required vars
module "deploy-cluster" {
  source   = "./modules/deploy-k8s"
  location = module.import-rg.location
  rg-name  = module.import-rg.name
  role     = "prod"
  prefix   = var.prefix
  agid = module.application-gateway.agid
  agname = module.application-gateway.agname
  tags = merge(local.tags, {
    GROUP = "Production"
    ROLE  = "Cluster"

  })
}
#Export tfstate to cloud storage
module "store-tfstate" {
  source   = "./modules/store-tfstate"
  location = module.import-rg.location
  rg-name  = module.import-rg.name
  prefix   = var.prefix
  tags = merge(local.tags, {
    GROUP = "Infrastructure"
    ROLE  = "Storage"
  })
}
