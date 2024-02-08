# AWS Infra Terraform
Repository created with the objective to develop a PoC with terraform to acelerate infra deploy on AWS environments

## Installing Terraform

To install Terraform on your Ubuntu/Debian, follow these steps. :

```
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

If you want to install it on another operating system, go to the link in the references.

## Creating a New User in AWS IAM

In AWS IAM (Identity and Access Management), you can create new users to grant them access to AWS resources. Follow these steps to create a new user:

### Step 1: Navigate to IAM Dashboard

1. Sign in to the AWS Management Console.
2. Open the IAM console by searching for IAM in the services search bar and selecting IAM.

### Step 2: Access Management

1. In the IAM dashboard, click on "Access management" in the left sidebar.
2. Select "Users" from the dropdown menu.

### Step 3: Create User

1. Click on the "Create user" button.
2. Enter the username for the new user.
3. Click on "Next".

### Step 4: Attach Policies

1. Choose "Attach existing policies directly".
2. In the search bar, type "AdministratorAccess".
3. Check the box next to "AdministratorAccess" to attach the policy.
4. Click on "Next" (you can add tags if needed, but it's optional).
5. Click on "Create user".

### Step 5: Access Key Creation

1. In the IAM dashboard, click on "Users".
2. Find the newly created user and click on their username.
3. Click on "Security credentials"
4. Click on "Create access key".
5. Choose "Application running outside AWS" and click on "Next"
6. Describe the purpose of this access key and Click on "Create access key" to finish.
7. Click on "Download .csv file" to download the access key details.
8. Click on "Done" to finish.

That's it! You have successfully created a new user in AWS IAM and obtained the access key for using AWS services programmatically outside of AWS.

#### Reference

- [Install Terraform](https://developer.hashicorp.com/terraform/install?product_intent=terraform)