provider "aws" {
    
  region = "ap-south-1"
  access_key = "AKIAX75JUEY4SKV6REQE"
  secret_key = "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"
}


resource "aws_instance" "t2_micro" {
  count         = 4
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    name = "t2-micro-${count.index}"
  }
}

resource "aws_instance" "t2_medium" {
  count         = 2
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.medium"

  tags = {
    name = "t2-medium-${count.index}"
  }
}

resource "aws_db_instance" "mysql-rds" {
  identifier             = "mysql-rds-db"
  engine                 = "mysql"
  engine_version         = "5.7.30"
  instance_class         = "db.t2.micro"
  allocated_storage      = 10
  storage_type           = "gp2"
  username               = "admin"
  password               = "password"
  parameter_group_name   = "default.mysql5.7"
  publicly_accessible    = true
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.mysql-rds.id]

  tags = {
    Name = "mysql-rds-db"
  }
}

resource "aws_security_group" "mysql-rds" {
  name_prefix = "mysql-rds-"
}

resource "aws_security_group_rule" "mysql-rds_ingress" {
  type        = "ingress"
  from_port   = 0
  to_port     = 3306
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.mysql-rds.id
}

# Install Apache Tomcat on the first EC2 instance
resource "null_resource" "tomcat_installation" {
  count = 1

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y java-1.8.0-openjdk",
      "wget http://www-us.apache.org/dist/tomcat/tomcat-9/v9.0.54/bin/apache-tomcat-9.0.54.tar.gz",
      "tar xzf apache-tomcat-9.0.54.tar.gz",
      "sudo mv apache-tomcat-9.0.54 /opt/tomcat",
      "sudo systemctl start tomcat",
      "sudo systemctl enable tomcat"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = aws_instance.t2_medium[0].public_ip
    }
  }
}




