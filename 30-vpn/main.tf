resource "aws_key_pair" "openvpn" {
  key_name   = "openvpn"
  public_key = file("c:\\devops\\bhupathi4245\\openvpn.pub")
}

resource "aws_instance" "vpn" {
    ami = local.ami_id # Replace with your desired AMI ID
    instance_type = "t3.micro"
    vpc_security_group_ids = [local.vpn_sg_id]
    subnet_id = local.public_subnet_id # Assuming the first public subnet is used.. derived in locals
    # key_name = "daws-84s" # make sure this key exists in AWS console
    key_name = aws_key_pair.openvpn.key_name 
    user_data = file("openvpn.sh")  # login info and all agreement details and other options are in this script
    tags = merge(
        local.common_tags,
        {           
            Name = "${var.project}-${var.environment}-vpn"
        }
    )   
}