variable "instancias" {
  description = "Nombre de las instancias"
  #type = list(string) #se usa para count
  type = set(string)
  #default = ["apache","mysql","jumpserver"]
  default = ["apache"]
}

resource "aws_instance" "public_instance" {
  #count         = length(var.instancias)  #me crea 3 instancias, trata como indice a los elementos
  for_each = var.instancias
  ami           = var.ec2_specs.ami 
  instance_type = var.ec2_specs.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data = file("scripts/userdata.sh")
  
  tags = {
    #"Name" = var.instancias[count.index] #el nombre de la instancia vaa a ser cada valor de var.instancias
    Name = "${each.value}-${local.suffix}"
  }
}

resource "aws_instance" "monitoring_instance" {
  #count = var.enable_monitoring ? 1:0 #? es la estructura condicional 1 true 0 false, si count da 1/true se despliega
  count = var.enable_monitoring == 1 ? 1 : 0 
  ami           = var.ec2_specs.ami 
  instance_type = var.ec2_specs.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data = file("scripts/userdata.sh")
  
  tags = {
    #"Name" = var.instancias[count.index] #el nombre de la instancia vaa a ser cada valor de var.instancias
    Name = "Monitoreo-${local.suffix}"
  }
}
