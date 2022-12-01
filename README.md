Repository for delivery and deployment of the LogicalDoc CE webapp

Prerequisites:
    Installations:
    -- If you are using MacOS or Linux then you can install everything on one OS 
        Windows:
            Azure CLI
            Terraform
            Kubectl
        Linux Subsystem for Windows(WSL2):
            Ansible(not compatible with Windows)

Steps for Delivery:
    1. Provision the infrastructure with Terraform
    2. Configure the machines necessary with Ansible (more info in infrastructure directory)
        By now you should have 2 machines, one jenkins master node and other is worker node.
    3. Login onto jenkins with the creds you provided in Ansible vars
    4. Add this repository as a shared library with the path pointing to the shared directory
    5. Connect the worker node to the master node in jenkins settings (Sometimes you may run into issues regarding first time connection and unknown hosts)
    6. Add the necessary credentials for Github and Docker
    7. Create a new pipeline and load the Jenkinsfile into it
        Successfull completion of the pipeline means that you have delivered a image to your dockerhub repository

Steps for Deployment:
    1. Make sure kubectl recognizes your cluster
    2. Create POSTGRES_PASSWORD secret in kubectl
    3. Using kubectl apply command deploy every part of the system in this order 
       configs -> storage -> manifests -> services
    Recommendation to install OpenLens for easier visualization, managment and troubleshooting of the cluster