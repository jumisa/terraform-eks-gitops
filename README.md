# 🚀 Demo Series: AWS EKS Terraform GitHub Actions GitOps
## Objective

Demonstration of DevOps project implementation on AWS Elastic Kubernetes Service (EKS) with nearly full automation. That includes automation of infrastructure provisioning, code quality check and build, deployments via gitops methodology, monitoring, logging and alerting.

## ⚡ `Architecture:`
![Alt text](docs/complete-project-demo-EKS-v5.gif)

⭐  GitHub Actions Workflows used for the iteration of Infrastructure and Application code builds
⭐  Terraform is used for building the complete infrastructure
⭐  Domain registrar Cloudflare
⭐  AWS Route53 Public Hosted zone is created and NS mapped to Cloudflare domain
⭐  AWS Certificate Manager (ACM) is used to create SSL certificate for the domain name and signed by DNS method (record added Route53 hosted zone)
⭐  EKS Cluster and worker node groups in private subnet provisioned with Kubernetes version 1.27.
⭐  AWS Load Balancer Controller configured to provision AWS Application Load Balancer (ALB) with wildcard mapping as targeted to EKS Private Node groups
⭐  Nginx Ingress Controller configured to handle any routes such as host , path based from the eks cluster resource
⭐  External DNS Controller configured to add the AWS ALB DNS to Route53 recordset. Filtered only to scan AWS LB Controller ingress resources.
⭐  GitHub Actions Controller configured to add Self-Hosted Runners to code/application and tools github repositories
⭐  ArgoCD configured to handle the application and tools deployment
⭐  IAM Role Based Service Account (IRSA) are configured to allow the Kubernetes resources access, manage AWS Resources
⭐  Role Based Access Controls (RBAC) are used to manage the access to the users to connect to Kubernetes API via cli or any ide
⭐  Infrastructure code scans are carried out by TFlint, TFSec, Checkov through GitHub Actions using managed runners
⭐  Application code scan and builds by Sonarqube, Trivy and Docker through GitHub Actions using Self-hosted runners
⭐  Prometheus, Grafana, Elastic Fluentd Kibana Stacks as the part of traceability solution are configured in the cluster
⭐  Slack integration for notification from GitHub Actions, traceability tools
⭐  Community and Custom Helm Charts are used for deploying controllers, application and tools manifests to the cluster



### 📌 `Domain :`

#### 1. `Clouflare Domain:`

- Optional : Domain can be purchased in AWS itself. As I had my domain in Cloudflare, I am using the Cloudflare terarform provider to associate the AWS Hosted Zone NS records with Cloudflare recordsets
- Generate an API token on Cloudflare

####  2. <u>`Setup AWS User Account`</u>
- Connect to AWS account via management, 
  - [Create an IAM user](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html), enabled programmatic access 
  - [Attach an IAM Role](https://docs.aws.amazon.com/directoryservice/latest/admin-guide/assign_role.html) that has access to create, modify and delete AWS Resources
  - [Create an access id and secret key](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html)

####  3. <u>`Setup Secrets in GitHub`</u>

- Add the secrets as AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY with the above created from AWS console 
  
- Add the secret for Cloudflare as CLOUDFLARE_API_TOKEN with API token generated from Cloudflare console
  
####  4. <u>`Repository Branching Strategy`</u>

I considered `demo` as the default branch for this project. Here, I call `demo` as my environment in AWS

Any new feature, resources are goes into `feature/**` branches. For example , for provisioning the infrastructure for AWS Network Resources, I created a branch `feature/aws-network`

####  5. <u>`GitHub Workflow Structure`</u>

Following is the structure of GitHub workflow.
```
├── .github
   └── workflows
       ├── checkov-check.yml
       ├── deploy-infra.yml
       ├── destroy-infra.yml
       ├── terraform-apply.yml
       ├── terraform-destroy.yml
       ├── terraform-plan.yml
       ├── test-infracode.yml
       ├── tflint-check.yml
       └── tfsec-check.yml
```
`Terraform Plan`
- For any push to `feature/**` branches, the workflow with 
  - `tflint, tfsec and checkov` scans will be executed
  - post the successfull TF scans, `terraform plan` will be executed

`Terraform Apply`
- For any pull_request to `demo` branch, the workflow with 
  - `tflint, tfsec and checkov` scans will be executed
  - post the successfull TF scans, `terraform plan` will be executed
  - Job summary and pull request comment with `terraform plan` will be shared
  - An issue will be opened for the Reviewer / Approver to approve/deny the request 
  - Approver gets an email to verify the `terraform plan` from Job Summary or Pull request Comment
  - Post Approver's review , he/she must enter the comment on the opened issue
  - Finally workflow for `terraform apply` will be executed

`Terraform Destroy`
- This is a manual workflow, user must triigger it Actions tab under All workflow section
  - While triggering it is must to share the name of the issuer
  - This will generate same process of manual approval we saw for PR
  - An issue will be opened for the Reviewer / Approver to approve/deny the request 
  - Approver gets an email to verify the `terraform destroy plan` from Job Summary or Pull request Comment
  - Post Approver's review , he/she must enter the comment on the opened issue
  - Finally workflow for `terraform destroy` will be executed
  
####  6. <u>`AWS Network Resources`</u>

In this feature branch AWS Network resources , Route53, Cloudflare NS mapping and SSL Certificate are created. 
    - VPC
    - Subnets
    - Route Tables
    - Routes
    - NAT
    - IGW
    - Hosted Zone
    - ACM Cert
    - NS mapped to Cloudflare