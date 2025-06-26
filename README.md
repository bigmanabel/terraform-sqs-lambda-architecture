# 🚀 Terraform SQS Lambda Architecture

Modern Infrastructure as Code for building a fully serverless, event-driven
pipeline on AWS using Terraform with automated CI/CD deployment.

This project demonstrates a production-ready architecture for asynchronous
message processing with automatic Lambda function deployment via CodePipeline.

## 🏗️ Architecture

```
GitHub Repo (Lambda Code)
         ↓
    CodePipeline
         ↓
     CodeBuild → S3 Artifacts
                      ↓
Client → API Gateway → Lambda (Producer) → SQS Queue → Lambda (Consumer)
                                                           ↓
                                                   CloudWatch Logs
```

**Key Features:**

- **Serverless CI/CD**: Automatic Lambda deployments from GitHub
- **Event-Driven Processing**: Asynchronous message handling with SQS
- **Modern Best Practices**: Organized Terraform code with proper resource
  separation
- **Production Ready**: CloudWatch monitoring, IAM security, and error handling

## 📁 Project Structure

```bash
terraform-sqs-lambda-architecture/
├── main.tf                    # Root module configuration
├── provider.tf               # AWS provider and version constraints
├── variables.tf              # Input variables
├── outputs.tf                # Output values
├── terraform.tfvars          # Variable values
├── terraform.tfvars.example  # Example configuration
└── modules/
    └── sqs-lambda-pipeline/
        ├── main.tf           # Module documentation
        ├── variables.tf      # Module variables
        ├── outputs.tf        # Module outputs
        ├── apigateway.tf     # API Gateway resources
        ├── cloudwatch.tf     # CloudWatch logs and monitoring
        ├── codebuild.tf      # CodeBuild project for CI/CD
        ├── codepipeline.tf   # CodePipeline for deployments
        ├── iam.tf            # IAM roles and policies
        ├── lambda.tf         # Lambda functions
        ├── s3.tf             # S3 bucket for artifacts
        ├── sqs.tf            # SQS queues and DLQ
        └── README.md         # Module documentation
```

## 🎯 Key Components

- **Infrastructure Only**: This repository contains only AWS infrastructure code
- **Separate Lambda Repo**: Lambda function code lives in a separate GitHub
  repository
- **Automated Deployment**: CodePipeline automatically deploys Lambda functions
  when code changes
- **Resource Organization**: Each AWS service has its own Terraform file for
  better maintainability

## ⚙️ Setup Instructions

### Prerequisites

- AWS CLI configured with appropriate permissions
- Terraform >= 1.7 installed
- A separate GitHub repository for your Lambda function code

### Deployment Steps

1. **Clone and navigate to this repository**

```bash
git clone https://github.com/your-org/terraform-sqs-lambda-architecture.git
cd terraform-sqs-lambda-architecture
```

2. **Configure your variables in `terraform.tfvars`**

```hcl
aws_region   = "us-east-1"
project_name = "event-pipeline"

# GitHub Configuration (required for CodePipeline)
github_owner  = "your-github-username"
github_repo   = "your-lambda-functions-repo"
github_branch = "main"
```

3. **Deploy the infrastructure**

```bash
terraform init
terraform apply
```

4. **Activate the CodeStar Connection**

After deployment, go to the AWS Console → CodePipeline → Settings → Connections
and activate the connection that was created. This is required for GitHub
integration.

5. **Set up your Lambda functions repository**

Create a separate GitHub repository with your Lambda functions. Include a
`buildspec.yml` file for CodeBuild and organize your code with `producer/` and
`consumer/` directories.

**Important**: Deploy your Lambda functions repository first before triggering
the pipeline. The Lambda functions expect code to be available in S3 from your
first pipeline run.

### Lambda Repository Structure

Your separate Lambda functions repository should follow this structure:

```bash
your-lambda-functions-repo/
├── buildspec.yml
├── producer/
│   ├── lambda_function.py
│   └── requirements.txt
└── consumer/
    ├── lambda_function.py
    └── requirements.txt
```

## 🧪 Testing the Pipeline

Once your infrastructure is deployed and your Lambda functions are deployed via
CodePipeline:

1. **Test the API Gateway endpoint:**

```bash
# Get the API Gateway URL from Terraform outputs
terraform output api_gateway_url

# Send a test event
curl -X POST https://your-api-id.execute-api.us-east-1.amazonaws.com/prod/event \
  -H "Content-Type: application/json" \
  -d '{"orderId": "123", "product": "Book", "timestamp": "2024-01-01T12:00:00Z"}'
```

2. **Monitor the pipeline:**

- Check CloudWatch logs for both Lambda functions
- Monitor SQS queue metrics in the AWS Console
- View CodePipeline execution history

## 📦 Outputs

After deployment, Terraform provides:

- **API Gateway URL**: HTTP endpoint to trigger the producer Lambda
- **SQS Queue URL**: For monitoring and debugging
- **CodePipeline Name**: For monitoring deployments
- **S3 Artifacts Bucket**: Where Lambda deployment packages are stored

## 🌟 Key Benefits

This architecture demonstrates modern serverless best practices:

- **Infrastructure as Code**: All AWS resources defined in Terraform
- **Automated CI/CD**: Zero-touch deployments from GitHub
- **Separation of Concerns**: Infrastructure and application code in separate
  repositories
- **Production Ready**: Includes monitoring, error handling, and proper IAM
  security
- **Scalable**: Event-driven processing with SQS buffering
- **Cost Effective**: Pay only for what you use with serverless services

## 🔧 Maintenance

- **Infrastructure Changes**: Modify Terraform files in this repository
- **Lambda Code Changes**: Push changes to your separate Lambda functions
  repository
- **Monitoring**: Use CloudWatch dashboards and logs for operational insights
- **Scaling**: Architecture automatically scales based on load
