# f5-rs-azure

## This repository is used in demoing F5 and Azure Deployment Solutions

Each solution is broken out into individual components to be run alone, however they can be stitched together as needed with Ansible Roles, a full demo can be built using the **run_ansible_full_stack.yaml** playbook. This solution is built around BIG-IQ as a License Manager(LM) server, if you are not using BIG-IQ as a license server you may need to modify this solution.


This solution is ideally used in conjunction with the F5 Resource Solutions, there are different projects on-going so please refer to the index for things that can be shown.

I highly recommend using a docker container created from F5 engineer Yossi: `docker run -p 2222:22 -p 10000:8080 -it --rm f5usecases/f5-rs-container:latest` this container includes the needed modules for BIG-IP, Azure, AWS and Ansible

### Custom Parameters

The **parent_parameters.yaml** located at the root of the solutions repository contains variables used throughout the solution.

The password to **parent_parameters.yaml** is `password`

There are some main variables used in the solution (including your Service Principal AzureAD credentials), these are used as repeated variables and you should make sure your **resource_group_name** is unique to the **location** you use this deployment.

**resource_group_name**: "f5-rs-azure"
application_server_name must be between 3 and 24 characters in length and use numbers and lower-case letters only

**application_server_name**: "appserver01"
region for deployment

**location**: "westus"

### To Run this Solution

If you are running this solution from your own environment, you should read the **dependency notes** from this repository. If you are deploying this with the **f5-rs-container** after launching the container `git clone https://www.github.com/jmcalalang/f5-rs-azure`. Change directory into the `f5-rs-azure` folder and update `parent_parameters` for your deployment.

### Definition of Solutions:

**run_ansible_application** - This solution will build a ubuntu box, modify/create a security group and execute an Azure extension script to install Docker and launch some testing containers on ports 80-83 of the server

**run_ansible_azure_net** - This solution will build a Resource Group, Virtual Network and 3 subnets in Azure, the network is based of the IP ranges from the F5 vLab

**run_ansible_bigip_cluster_3_nic** - This solution will deploy an F5 ARM template building two BIG-IP's with 3 NIC's in a Device Service Cluster

**run_ansible_bigip_single_1_nic** - This solution will deploy an F5 ARM template building a single BIG-IP with 1 NIC

**run_ansible_bigip_single_3_nic** - This solution will deploy an F5 ARM template building a single BIG-IP with 3 NIC's (This is the Default Deployment)

**run_ansible_destroy_all_services** - This solution will destroy all services (Service 1-5) deployed on your BIG-IP

**run_ansible_destroy_environment** - This solution will destroy your Resource Group, this is using the **force** option so all objects will be destroyed without confirmation

**run_ansible_full_stack** - This solution will deploy a full stack environment. It is by default setup to execute the the below Roles in order, this can be modified in the playbook and *parent_parameters*.
 - **run_ansible_azure_net**
 - **run_ansible_application**
 - **run_ansible_bigip_single_3_nic**
 - **run_ansible_services_3**

**run_ansible_services_1** - Create or update Service 1; Imperative Build Simple HTTP Application

**run_ansible_services_2** - Create or update Service 2; f5.http iapp Build Advanced HTTPS/WAF Application

**run_ansible_services_3** - Create or update Service 3; AS3 Build Simple HTTP Application

**run_ansible_services_4** - Create or update Service 4; AS3 Build Advanced HTTPS/WAF Application

**run_ansible_services_5** - Create or update Service 5; AS3 Build Advanced HTTPS/APM Application

**run_ansible_teams_webhook_test** - Test a webhook call for Microsoft Teams
