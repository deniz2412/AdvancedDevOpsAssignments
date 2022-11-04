#Import existing RG
module "import-rg" {
  source = "./modules/import-resource-group"

}
locals {
  tags = {
    OWNER = "Deniz"
  }

}
module "create-network" {
  source   = "./modules/create-network"
  location = module.import-rg.location
  prefix   = var.prefix
  rg-name  = module.import-rg.name
  tags = merge(local.tags, {
    GROUP = "Network"
  })
}

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
}

module "deploy-cluster" {
  source   = "./modules/deploy-k8s"
  location = module.import-rg.location
  rg-name  = module.import-rg.name
  role     = "prod"
  prefix   = var.prefix
  tags = merge(local.tags, {
    GROUP = "Production"
    ROLE  = "Cluster"

  })
}
