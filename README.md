### Steps for Hosting a Static Website on AWS

#### 1. **Set Up VPC and Subnets**
   - **Create a VPC**: This will be the virtual network for your AWS resources.
   - **Create Public and Private Subnets**: Distribute these across two availability zones for high availability.

#### 2. **Set Up Internet Gateway**
   - **Attach an Internet Gateway** to the VPC to allow communication between instances in the public subnets and the internet.

#### 3. **Set Up Security Groups**
   - **Create Security Groups**: These will act as virtual firewalls to control inbound and outbound traffic for your instances.

#### 4. **High Availability and Fault Tolerance**
   - **Set Up Route Tables**: Associate public subnets with a route table that has a route to the internet gateway. Associate private subnets with a route table that has a route to a NAT gateway.

#### 5. **Create Necessary Resources**
   - **NAT Gateway**: To allow instances in the private subnets to access the internet.
   - **Bastion Host**: To securely connect to your instances in the private subnet.
   - **Application Load Balancer**: For distributing incoming application traffic across multiple targets in multiple availability zones.

#### 6. **Create and Configure EC2 Instances**
   - **Launch EC2 Instances**: Place web servers and database servers in private subnets.
   - **Configure Instances**: Use the following script to install and host your static website.

#### 7. **DNS and Domain Registration**
   - **Register Domain with Route 53**: Use AWS Route 53 to register your domain and create DNS records.

#### 8. **Deploy the Website**
   - **Use the EC2 Instance to Host the Website**: Deploy your static HTML web app on the EC2 instance.

### Deployment Script
Here’s the script provided for deploying the web app on an EC2 instance:

```bash
#!/bin/bash
sudo su
yum update -y
yum install -y httpd
cd /var/www/html
wget https://github.com/aeezsaul/mole-site1/raw/main/mole.zip
unzip mole.zip
cp -r /var/www/html/mole-main/* /var/www/html
rm -rf mole.zip mole-main
systemctl enable httpd
systemctl start httpd
```

### Explanation of the Script
1. **Switch to Super User**: `sudo su`
2. **Update System Packages**: `yum update -y`
3. **Install Apache Web Server**: `yum install -y httpd`
4. **Navigate to Web Directory**: `cd /var/www/html`
5. **Download the Website Files**: `wget https://github.com/aeezsaul/mole-site1/raw/main/mole.zip`
6. **Unzip the Downloaded Files**: `unzip mole.zip`
7. **Move Files to Web Directory**: `cp -r /var/www/html/mole-main/* /var/www/html`
8. **Clean Up**: `rm -rf mole.zip mole-main`

### Additional Steps
1. **Start Apache Web Server**: `systemctl start httpd`
2. **Enable Apache to Start on Boot**: `systemctl enable httpd`

### Creating an AMI
Once your website is running successfully on the EC2 instance:
1. **Create an Image**: Use the AWS Management Console or AWS CLI to create an Amazon Machine Image (AMI) from your configured EC2 instance. This AMI can be used to launch new instances with the same configuration.

### Automation with Auto Scaling and Load Balancing
1. **Configure Auto Scaling Group**: Set up an auto scaling group using the AMI to ensure your website scales based on traffic.
2. **Attach the Auto Scaling Group to the Load Balancer**: Ensure your load balancer distributes incoming traffic across multiple instances.

### Final Steps
- **Test your setup**: Make sure the website is accessible and functioning correctly.
- **Monitor and Maintain**: Use AWS CloudWatch and other monitoring tools to keep track of your website’s performance and health.

