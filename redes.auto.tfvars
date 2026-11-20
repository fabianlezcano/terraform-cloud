#para que tome la variable de forma automatica se tiene que llamar terraform.tfvars
#o terraform.tfvars.json, si se llama de otra forma hay que indicarlo en la linea de comando   

#tambien se puede llamar *.auto.tfvars* o *.auto.tfvars.json y se tomara de forma automatica
#esto si quiero un nombre mas representativo

#si llamo por ejemplo fabian.tfvars, tengo que indicarlo en la linea de comando con.
# terraform plan --var-file fabian.tfvars

virginia_cidr = "10.10.0.0/16"
#public_subnet = "10.10.0.0/24"
#private_subnet = "10.10.1.0/24"

subnets = ["10.10.0.0/24", "10.10.1.0/24"]

tags = {
  "env"         = "dev"
  "owner"       = "fabian"
  "cloud"       = "aws"
  "IAC"         = "terraform"
  "IAC_Version" = "1.17.0"
  "project"     = "cerberus"
  "region"      = "virginia"
}

sg_ingress_cidr = "0.0.0.0/0"

ec2_specs = {
  "ami"           = "ami-0c230065b91270bc6"
  "instance_type" = "t3.micro"
}

enable_monitoring = true

ingress_ports_list = [22, 80, 443]

#Prioridad en la definicion de variables
#1  variable de entorno (export TF_VAR_ejemplo="valor")
#2 terraform.tfvars o terraform.tfvars.json
#3 cualquier archivo *.auto.tfvars o *.auto.tfvars.json
#4 variables definidas en la linea de comando (terraform plan -var 'ejemplo=valor')