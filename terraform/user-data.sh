#!/bin/bash
sudo yum update -y
sudo yum install java-17-openjdk -y
cd /home/ec2-user
wget https://your-bucket.s3.amazonaws.com/insurance-app.jar
java -jar insurance-app.jar
