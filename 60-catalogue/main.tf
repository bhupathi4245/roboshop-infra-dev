resource "aws_lb_target_group" "catalogue" {
  name     = "${var.project}-${var.environment}-catalogue" # "roboshop-dev-catalogue-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.vpc_id

  health_check {
    path                = "/health"
    port                = "8080"
    interval            = 5
    timeout             = 2
    healthy_threshold   = 2
    unhealthy_threshold = 3
    matcher             = "200-299"
  }
}

resource "aws_instance" "catalogue" {
    ami = local.ami_id # Replace with your desired AMI ID
    instance_type = "t3.micro"
    vpc_security_group_ids = [local.catalogue_sg_id]
    subnet_id = local.private_subnet_id # Assuming the first private subnet is used.. derived in/from locals
    # iam_instance_profile = "EC2RoleToFetchSSMParams"   # local.mysql_instance_profile_name""
    tags = merge(
        local.common_tags,
        {           
            Name = "${var.project}-${var.environment}-catalogue"
        }
    )   
}

resource "terraform_data" "catalogue" {
    triggers_replace = [
        aws_instance.catalogue.id
    ]

    provisioner "file" {
        source = "catalogue.sh"
        destination = "/tmp/catalogue.sh"
    }

    connection {
        type        = "ssh"
        user        = "ec2-user"
        password = "DevOps321"
        host        = aws_instance.catalogue.private_ip
    }
    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/catalogue.sh",
            "sudo sh /tmp/catalogue.sh catalogue"
        ]
    }

}