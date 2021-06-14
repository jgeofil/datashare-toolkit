# Datashare Terraform deployment
This directory contains all the code necessary to deploy Datashare to your Google Cloud project with [Terraform](https://www.terraform.io/) as an alternative to using the Markeplace deployment.

## Install Terraform from Cloud Shell
Follow the Terraform [installation instructions](https://www.terraform.io/docs/cli/install/apt.html) for Debian. 

## Deploy with default settings
We recommend that you deploy Datashare with Terraform from Google Cloud shell.  

1. Make sure that you are in the `marketplace/terraform` directory.
```
cd marketplace/terraform
```

2. Update the `terraform.tfvars`.
You must update the following variables.
* **project** - your Google Cloud project
* **gcp_service_account** - [Service account which will deploy Datashare into your project](https://github.com/GoogleCloudPlatform/datashare-toolkit/blob/master/marketplace/PREREQUISITES.md#update-service-account-from-google-cloud-console)
* **datashare_oauth_client_id** - Client ID required by the Datashare API and allows the UI to send requests to the API
  * [setup instructrions](https://github.com/GoogleCloudPlatform/datashare-toolkit/blob/master/CREDENTIAL_SETUP.md)
* **datashare_data_producers** - Datashare Admin users
* **datashare_api_domain_name** - Datashare's API domain name (i.e. api.datashare.yourdomain.com)
* **datashare_ui_domain_name** - Datashare's UI domain name (i.e. datashare.yourdomain.com)

## TODOS
* Test the GKE setup
* Test the VM startup script execution
* VPC network does not get deleted because it is used by the Firewall
  * But the Terraform does not automatically delete the firewall event though it is in the main.tf file.
* Storage Bucket
* Add the Cloud Function Deployment
  * Update the variables
* Add the API deployment
  * Update the variables
* Add the UI Deployment
  * Update the variables