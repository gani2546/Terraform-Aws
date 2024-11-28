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

}

resource "aws_db_snapshot" "name" {
    db_instance_identifier = "terraform-20241128202049073800000001"
    db_snapshot_identifier = "my-db-snapshot"
    depends_on = [ aws_db_instance.name ]
    tags = {
        Name = "mydbsnap"
    }
  
}