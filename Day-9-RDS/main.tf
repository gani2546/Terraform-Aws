resource "aws_db_instance" "name" {  
    engine = "mysql"
    allocated_storage    = 20
    storage_type = "gp2"
    instance_class = "db.t3.micro"
    engine_version = "8.0.39"
    username = "admin"
    password = "Seelaboina!5665"
    publicly_accessible = true
    skip_final_snapshot = true
    db_name = "mydbrds"
    tags = {
      Name = "mydbrds"
    }

}