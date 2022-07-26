variable "sg_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [8020, 8080, 8100, 9898, 9200]
}

resource "aws_security_group" "dynamicsg" {
  name       = "dynamic-sg"
  description = "this is a testing dynamic sg"

  dynamic "ingress" {
    for_each = var.sg_ports
    iterator = port
    content {
      from_port  = port.value
      to_port    = port.value
      protocol   = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic "egress" {
    for_each = var.sg_ports
    iterator = port
    content {
      from_port  = port.value
      to_port    = port.value
      protocol   = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
