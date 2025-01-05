# Provider configuration for us-east-1
provider "aws" {
    region = "us-east-1"
}

# Provider configuration for us-east-2
provider "aws" {
    region = "us-east-2"
    alias  = "us_east_2"  # Alias to differentiate this provider
}

# EC2 instance in us-east-1
resource "aws_instance" "example_us_east_1" {
    provider      = aws
    ami           = "ami-0166fe664262f664c"  # Ensure this is valid for us-east-1
    instance_type = "t2.micro"
    subnet_id     = "subnet-02c0c2c84a8a9e383"
    key_name      = "batch19"

    # User data script to install a simple web application (Nginx)
    user_data = <<-EOF
        #!/bin/bash
        # Update the system packages
        yum update -y

        # Install Nginx web server
        amazon-linux-extras install nginx1 -y
        systemctl start nginx
        systemctl enable nginx

        # Create a simple HTML page
        echo "<h1>Welcome to My Simple Web Application in us-east-1</h1>" > /usr/share/nginx/html/index.html
    EOF

    tags = {
        Name = "WebServerInstance-us-east-1"
    }
}

# EC2 instance in us-east-2
resource "aws_instance" "example_us_east_2" {
    provider      = aws.us_east_2
    ami           = "ami-088d38b423bff245f"  # Ensure this is valid for us-east-2
    instance_type = "t2.micro"
    subnet_id     = "subnet-0edb47cad706532db"  # Change this subnet ID if needed
    key_name      = "ohio"

    # User data script to install a simple web application (Nginx)
    user_data = <<-EOF
        #!/bin/bash
        # Update the system packages
        yum update -y

        # Install Nginx web server
        amazon-linux-extras install nginx1 -y
        systemctl start nginx
        systemctl enable nginx

        # Create a simple HTML page
        echo "<h1>Welcome to My Simple Web Application in us-east-2</h1>" > /usr/share/nginx/html/index.html
    EOF

    tags = {
        Name = "WebServerInstance-us-east-2"
    }
}