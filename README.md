# Welcome to my ApplicationDeployment-Project ☁️🙋‍

# Explanation of Project: 
In this project, the deployment of a web application to a production server is being done following the Software Development Life Cycle and utilizing DevOps tools. The first step in this process is using a Terraform script to build AWS EC2 instances. This is a more efficient method compared to building the backend on the AWS console, as it can be automated and saves time and effort.

Once the EC2 instances are ready, Jenkins is configured on an EC2 Medium server, and a CICD pipeline is built. This is achieved by configuring Sonarqube for checking code standards and Nexus artifact repository for taking backups. The configuration is done on individual EC2 instances to ensure scalability and fault tolerance.

Apache Tomcat is then configured on the production server where the web application is to be deployed. This ensures that the server is ready to handle the application once it is deployed.

For monitoring the production server, Prometheus is configured along with the Nord exporter, which uses Grafana dashboard for real-time monitoring. This provides updates on the performance of the web application in real-time, allowing for timely troubleshooting of issues.

To monitor the logs of the production server where the application is deployed, ElasticSearch and Metricbeats are configured. This allows for easy access to logs and enables quick identification and resolution of any problems that may arise.

Finally, Nginx is used as a reverse proxy to hide the IP address of the production server on which the application is running. This provides an additional layer of security and helps keep the server safe from any malicious attacks.

In conclusion, this project takes a comprehensive approach to deploying a web application on a production server, utilizing a wide range of DevOps tools to ensure efficient deployment, effective monitoring, and high-level security. The use of DevOps tools ensures that the deployment process is streamlined, and issues can be quickly identified and resolved.









# System Architecture Design:
![image](https://user-images.githubusercontent.com/64432661/232321563-e7fba5a6-3540-410b-a8f3-5275ce03387b.png)

