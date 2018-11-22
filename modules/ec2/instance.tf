data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["a-ubuntu-16.04-with-docker"]
  }

  owners = ["347162595075"]
}

resource "aws_instance" "terraform_instance" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.nano"
  key_name = "${aws_key_pair.key_pair.key_name}"
  tags {
    Name = "Terraform-EC2-1"
  }
}

resource "aws_key_pair" "key_pair" {
  key_name   = "AWS_PERSONAL_KP"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4P1qPUfogadNOQkV1mpc/4/I1B2uxOuP3Y4EXgY2NXROaWUJIT+JWPzFtvmmj5TeybgMeVXTU7mrIBDZmUI5gW3p+wcwgj++isl6pZph3gEbtYhkj0dhrMdVcMR4xB5jFd6189hEpqXhc0wg3Ar0DZQQFzmRc2F76wBmQ5umJRgyk8JCC8MXIr/wxVUk52cqTRIl0pIKHxP4+NiHE4B6uokZLi9a2pThZkFacatqsVbfBmP2T7Kv5JlISaCdvDsnqNep1FXsv6i/BMEcPc/6K20ITby9yZdcesX1Q4xYvbZxXdU2X2bOC24b6Od/sfxIXnDCtmHefYsmH1JwClNUd srinika@Srinikas-MacBook-Pro.local"
}