resource "aws_instance" "bastion" {
    ami = local.ami_id # Replace with your desired AMI ID
    instance_type = "t3.micro"
    vpc_security_group_ids = [local.bastion_sg_id]
    subnet_id = local.public_subnet_id # Assuming the first public subnet is used.. derived in locals

    tags = merge(
        local.common_tags,
        {           
            Name = "${var.project}-${var.environment}-bastion"
        }
    )   
}