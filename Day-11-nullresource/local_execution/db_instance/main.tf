
resource "aws_db_instance" "my_rds" {
  identifier              = "my-db-instance"
  allocated_storage       = 20
  instance_class          = "db.t3.micro" 
  engine                  = "mysql"
  engine_version          = "8.0.39"
  db_name                 = "mydatabase"
  username                = "admin"
  password                = "ganesh1234"
  publicly_accessible     = false
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
}

resource "aws_security_group" "rds_sg" {
  name = "rds-security-group"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = ["subnet-00192991e1e4a6aa1","subnet-074ef43b03ea37795"]
}

variable "db_password" {
  description = "Password for the RDS admin user"
  type        = string
  sensitive   = true
}

resource "null_resource" "db_initializer" {
  depends_on = [aws_db_instance.my_rds]

  #provisioner "local-exec" {
      #command = "mysql -h my-db-instance.c3mcuw8oc6dm.us-west-1.rds.amazonaws.com -u admin -p\"Ganesh1234\" -e \"source C:\\path\\to\\initialize_db.sql\""
    #interpreter = ["C:/Program Files/Git/bin/bash.exe", "-c"]

 #}

  triggers = {
    db_instance_id = aws_db_instance.my_rds.id
  }
}