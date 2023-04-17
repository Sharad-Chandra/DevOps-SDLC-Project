# Welcome to my DevOps-SDLC-Project ☁️🙋‍

## Explanation of Project: 
In this project, the deployment of a web application to a production server is being done following the Software Development Life Cycle and utilizing DevOps tools. The first step in this process is using a Terraform script to build AWS EC2 instances. This is a more efficient method compared to building the backend on the AWS console, as it can be automated and saves time and effort.

Once the EC2 instances are ready, Jenkins is configured on an EC2 Medium server, and a CICD pipeline is built. This is achieved by configuring Sonarqube for checking code standards and Nexus artifact repository for taking backups. The configuration is done on individual EC2 instances to ensure scalability and fault tolerance.

Apache Tomcat is then configured on the production server where the web application is to be deployed. This ensures that the server is ready to handle the application once it is deployed.

For monitoring the production server, Prometheus is configured along with the Nord exporter, which uses Grafana dashboard for real-time monitoring. This provides updates on the performance of the web application in real-time, allowing for timely troubleshooting of issues.

To monitor the logs of the production server where the application is deployed, ElasticSearch and Metricbeats are configured. This allows for easy access to logs and enables quick identification and resolution of any problems that may arise.

Finally, Nginx is used as a reverse proxy to hide the IP address of the production server on which the application is running. This provides an additional layer of security and helps keep the server safe from any malicious attacks.


In conclusion, this project takes a comprehensive approach to deploying a web application on a production server, utilizing a wide range of DevOps tools to ensure efficient deployment, effective monitoring, and high-level security. The use of DevOps tools ensures that the deployment process is streamlined, and issues can be quickly identified and resolved.









# System Architecture Design:
![image](https://user-images.githubusercontent.com/64432661/232321563-e7fba5a6-3540-410b-a8f3-5275ce03387b.png)

## Terraform:
I written the below terraform script to create the backend infrastructure on AWS, which will be required for configuring sonarqube and nexus repo. Using Infrastructure-as-Code is much more efficient instead of building the backend on the AWS console.
<img width="1100" alt="Screenshot 2023-04-17 at 1 24 14 PM" src="https://user-images.githubusercontent.com/64432661/232577131-ffc1e4da-8689-4908-b761-32246f1a82cf.png">
Here i have written a script that would install a Aapche Tomcat on one the first ec2 instance, which will be used as a production server on which the application will be deployed.
<img width="795" alt="terraform 2023-04-17 at 1 47 38 PM" src="https://user-images.githubusercontent.com/64432661/232582342-2338151f-3bf9-4bfa-8541-554bbbcc66da.png">

## Jenkins:
I have configured jenkins on t2.medium (always use t2.medium or higher for Jenkins, because t2.micro's hardware is insufficient for jenkins and it would crash). 
I have set up Jenkins as an application rather than a service. As Jenkins is an application, it needs Tomcat to be installed in order to function. Here i have used declartive script for this pipeline. 

<img width="1160" alt="Screenshot 2023-04-17 at 2 13 34 PM" src="https://user-images.githubusercontent.com/64432661/232587841-5bc8c488-3ad6-48e3-a873-f111afb7baf8.png">

This can also be done using freestyle pipleline we have to install sonarqube and nexus plugins for this to work.
 
<img width="418" alt="Screenshot 2023-04-17 at 2 16 28 PM" src="https://user-images.githubusercontent.com/64432661/232588491-eaa7c169-c6ce-4f2f-b231-2c4263b73621.png">

### Installing SonarQube:
I have configured sonarQube on Ubuntu server, below are the list of commands i have used:
```bash
sudo apt install wget
```
```bash
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-5.6.7.zip
```
```bash
unzip sonarqube-5.6.7.zip
```
Sonarqube default database is Mysql, so i have installed mysql on the server.
```bash
sudo apt install mysql-server -y
```
```bash
sudo systemctl start mysql
```
later i have created a database, user and added privilages to that user.
<img width="800" alt="Screenshot 2023-04-17 at 2 42 25 PM" src="https://user-images.githubusercontent.com/64432661/232593549-dda4121f-7b9e-4dc2-9ecc-ba236ca41bee.png">

### SonarQube runs on port 9000
<img width="1156" alt="Screenshot 2023-04-17 at 2 45 12 PM" src="https://user-images.githubusercontent.com/64432661/232594160-17dfa7e8-9a6d-4233-84bf-2681793ec60c.png">

## Nexus Artifact Repo:
I have setup nexus repository on t2.micro and configured it into jenkins pipeline. I have created a private repository on nexus for to store the code backup after successful deployment.
<img width="1438" alt="Screenshot 2023-04-17 at 2 58 41 PM" src="https://user-images.githubusercontent.com/64432661/232596839-48f7e60e-3286-4b56-abdf-8fbb86d833d4.png">

## Prometheus and Grafana:
On the production server, I've set up Prometheus to keep track of the system-level application insights. NordExporter generates a TCP/IP port on the corresponding system and presents its metric data to Grafana, allowing for real-time monitoring of the system's status.

<img width="1215" alt="Screenshot 2023-04-17 at 3 10 59 PM" src="https://user-images.githubusercontent.com/64432661/232599186-fb564b09-235a-4438-b6fb-bb65b908eb62.png">
I have configured grafana dashboard for cpu and memory utilization on application server as per the given threshold limit.
<img width="1429" alt="Screenshot 2023-04-17 at 3 11 23 PM" src="https://user-images.githubusercontent.com/64432661/232599262-b807d766-ce67-465c-8759-b1f6e94375ac.png">

## ElasticSearch
On the production server, I've installed Elasticsearch and configured Metricbeat to transmit data to Elasticsearch. This enables us to examine application logs and scrutinize the data in greater detail using the Kibana dashboard.

<img width="1439" alt="Screenshot 2023-04-17 at 3 21 25 PM" src="https://user-images.githubusercontent.com/64432661/232601282-5c8371b2-00e4-497d-91df-770a1665c440.png">


