# f5-rs-azure

## This repository is used in demoing F5 and Azure Deployment Solutions

Each solution is broken out into individual components to be run alone, however they can be stitched together as needed with Ansible Roles, a full stack demo can be built using the **run_ansible_full_stack.yml** playbook, while there is also another one for Operationalizing an F5 BIG-IQ too. This solution is built around BIG-IQ as a License Manager(LM) server, if you are not using BIG-IQ as a license server you may need to modify this solution.

This solution is ideally used in conjunction with the F5 Resource Solutions, there are different projects on-going so please refer to the index for things that can be shown.

I highly recommend using a docker container created from F5 engineer Yossi: `docker run -p 2222:22 -p 10000:8080 -it --rm f5usecases/f5-rs-container:latest` this container includes the needed modules for BIG-IP, Azure, AWS and Ansible

### Custom Parameters

The **parent_parameters.yml** located at the root of the solutions repository contains variables used throughout the solution.

The password to **parent_parameters.yml** is `password`

There are some main variables used in the solution (including your Service Principal AzureAD credentials), these are used as repeated variables and you should make sure your **resource_group_name** is unique to the **location** you use this deployment. There are also variables in defaults main of the Roles

| Parameters                       | Example      | Required  | Used In  | Notes  |
|------------------------|-------|---|---|---|
| subscriptionId         |  | yes  | all  |   |
| tenantId               |  | yes  | all  |   |
| clientId               |  | yes  | all  |   |
| servicePrincipalSecret |  | yes  | all  |   |
|                        |       |   |   |   |
| location               | eastus      |   | all  |   |
| resource_group_name                       | f5-rs-azure      |   | all  |   |
| application_server_name                       | internalsrv01      |   |   |   |
| BigIp_instance_name                       | bigip01      |   |   |   |
|                        |       |   |   |   |
| ApplicationAdminUsername                       | azureuser      |   |   |   |
| ApplicationAdminPassword                       |       |   |   |   |
|                        |       |   |   |   |
| BIGIPadminUsername                       | azureuser      |   |   |   |
| BIGIPadminPassword                       |       |   |   | no variable special charactors ($%!)  |
|                        |       |   |   |   |
| bigIqLicenseHost                       | www.mybigiqlm.com      |   |   | FQDN or IP  |
| bigIqLicenseUsername                       | azureuser      |   |   | User must me a local account on BIG-IQ  |
| bigIqLicensePassword                       |       |   |   |   |
| bigIqLicensePool                       |       |   |   | If ELA/Sub you need sku/unit of measure, if regular pool they are optional  |
| bigIqLicenseSkuKeyword1                       |       |   |   |   |
| bigIqLicenseUnitOfMeasure                       |       |   |   | yearly,monthly,daily,hourly  |
|                        |       |   |   |   |
| bigIqHostPassphrase                       | This1STheP@ssphras3      |   |   | You cannot reset this later without the current, write it down  |
| bigIqMSPRegKey                       |       |   |   | This adds a license pool to the LM Role  |
| bigIq01                       |       |   |   | This is the hostname  |
| bigIq01_systemPersonality                       | big_iq      |   |   | There are only two personalities "big_iq" and "logging_node"  |
| bigIq01_mgmt_pip                       |       |   |   |   |
| bigIq01_int_pri_ip                       |       |   |   |   |
| bigIq01Admin                       | azureuser      |   |   |   |
| bigIq01Password                       |       |   |   |   |
| bigIq01License                       |       |   |   | This is the license of the actual BIG-IQ  |
| bigIq02                       |       |   |   | This is the hostname  |
| bigIq02_systemPersonality                      | logging_node      |   |   | There are only two personalities "big_iq" and "logging_node"  |
| bigIq02_mgmt_pip                       |       |   |   |   |
| bigIq02_int_pri_ip                       |       |   |   |   |
| bigIq02Admin                       | azureuser      |   |   |   |
| bigIq02Password                       |       |   |   |   |
| bigIq02License                       |       |   |   | This is the license of the actual BIG-IQ  |
|                        |       |   |   |   |
| teams_webhook                       |       |   |   | This is in all modules, if you dont use Teams you will want to remove this  |
|                        |       |   |   |   |   |

### Teams Incoming Webhook

This solution can use Microsoft Teams as an endpoint for Webhook notifications. This will require the creation of a Teams Connector: https://docs.microsoft.com/en-us/microsoftteams/platform/concepts/connectors#creating-messages-through-office-365-connectors

### To Run this Solution

If you are running this solution from your own environment, you should read the **dependency notes** from this repository. If you are deploying this with the **f5-rs-container** after launching the container `git clone https://www.github.com/jmcalalang/f5-rs-azure`. Change directory into the `f5-rs-azure` folder and update `parent_parameters` for your deployment.

There are simple helper scripts for the playbooks, to execute one while in the root of the folder use:

**bash run_ansible_{{name of solution}}**

### Definition of Solutions:

#### Solutions

**run_ansible_full_stack** - This solution will deploy a full stack environment (Infrastructure, Server, and BIG-IP). It is by default setup to execute the the below Roles in order, this can be modified in the playbook.
 - **run_ansible_azure_net**
 - **run_ansible_server**
 - **run_ansible_bigip_single_3_nic**
 - **run_ansible_services_4**

**run_ansible_bigiq_full**  - This solution will deploy an environment and a single BIG-IQ. It is by default setup to execute the the below Roles in order, this can be modified in the playbook.
 - **run_ansible_azure_net**
 - **bigiq_single_2_nic**
 - **bigiq_onboard**


#### Infrastructure

**run_ansible_azure_net** - This solution will build a Resource Group, Virtual Network and 3 subnets in Azure, the network is based of the IP ranges from the F5 vLab

**run_ansible_server** - This solution will build a ubuntu box, modify/create a security group and execute an Azure extension script to install Docker and launch some testing containers on ports 80-83 of the server

**run_ansible_bigip_cluster_3_nic** - This solution will deploy an F5 ARM template building two BIG-IP's with 3 NIC's in a Device Service Cluster

**run_ansible_bigip_single_1_nic** - This solution will deploy an F5 ARM template building a single BIG-IP with 1 NIC

**run_ansible_bigip_single_3_nic** - This solution will deploy an F5 ARM template building a single BIG-IP with 3 NIC's (This is the Default Deployment)

**run_ansible_destroy_environment** - This solution will destroy your Resource Group, this is using the **force** option so all objects will be destroyed without confirmation

**run_ansible_bigiq_set_2_nic** - This solution will deploy two BIG-IQ's with 2 NIC's

**run_ansible_bigiq_single_2_nic.sh** - This solution will deploy a single BIG-IQ's with 2 NIC's

#### Onboarding

**run_ansible_bigiq_onboard** - This solution utilizes BIG-IQ Easy-Start API to Onboard a BIG-IQ

**run_ansible_bigiq_add_dcd.yml** - This solution adds an already existing BIG-IQ DCD to a BIG-IQ CM

#### Services

**run_ansible_services** - If you are running this solution on an F5 PA-VE you can only have **one** at a time

  - **run_ansible_services_1** - Create or update Service 1; Imperative Build Simple HTTP Application
  - **run_ansible_services_2** - Create or update Service 2; f5.http iapp Build Advanced HTTPS/WAF Application
  - **run_ansible_services_3** - Create or update Service 3; AS3 Build Simple HTTP Application
  - **run_ansible_services_4** - Create or update Service 4; AS3 Build Advanced HTTPS/WAF Application
  - **run_ansible_services_5** - Create or update Service 5; AS3 Build Advanced HTTPS/APM Application (in process)
  - **run_ansible_services_6** - Create or update Service 6; BIG-IQ Build Application for HTTPS (in process)  
  - **run_ansible_services_7** - Create or update Service 7; AS3 to BIG-IQ Build Application for HTTPS (in process)  
  - **run_ansible_services_8** - Create or update Service 8; Blue Build Application for HTTPS (in process)

**run_ansible_destroy_all_services** - This solution will destroy all services (Service 1-5) deployed on your BIG-IP, and remove all external security group added roles (purges to default)

#### Notifications

**run_ansible_teams_webhook_test** - Test a webhook call for Microsoft Teams
