#!/bin/bash

sudo yum -y install httpd
sudo systemctl start httpd && sudo systemctl enable httpd
echo '<h1><center>Terraform Bootcamp Moduel 1 Day3 Lab</center></h1>' > index.html
sudo mv index.html /var/www/html/
