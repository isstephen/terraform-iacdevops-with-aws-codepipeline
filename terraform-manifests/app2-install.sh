#! /bin/bash
# Update system packages
sudo yum update -y

# Install Apache
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd  

# Ensure app2 directory exists
sudo mkdir -p /var/www/html/app2

# Create main index page
cat <<EOF | sudo tee /var/www/html/app2/index.html
<!DOCTYPE html>
<html>
<body style="background-color:rgb(15, 232, 192);">
<h1>Welcome to SSL-Trading - APP-2</h1>
<p>Terraform Demo</p>
<p>Application Version: V1</p>
</body>
</html>
EOF

# Fetch EC2 instance metadata using IMDSv2
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600") || TOKEN=""
if [ -n "$TOKEN" ]; then
  curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/dynamic/instance-identity/document | sudo tee /var/www/html/app2/metadata.html
else
  echo "Error retrieving metadata token" | sudo tee /var/www/html/app2/metadata.html
fi

# Set permissions and restart Apache
sudo chown -R apache:apache /var/www/html/
sudo chmod -R 755 /var/www/html/
sudo systemctl restart httpd
