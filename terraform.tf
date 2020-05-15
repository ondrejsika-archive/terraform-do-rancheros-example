variable "do_token" {}
variable "cloudflare_email" {}
variable "cloudflare_token" {}

provider "digitalocean" {
  token = var.do_token
}

provider "cloudflare" {
  version = "~> 1.0"
  email = var.cloudflare_email
  token = var.cloudflare_token
}

data "digitalocean_ssh_key" "ondrejsika" {
  name = "ondrejsika"
}

resource "digitalocean_droplet" "ros" {
  image  = "rancheros"
  name   = "ros"
  region = "fra1"
  size   = "s-1vcpu-2gb"
  ssh_keys = [
    data.digitalocean_ssh_key.ondrejsika.id
  ]
}

resource "cloudflare_record" "ros" {
  domain = "sikademo.com"
  name   = "ros"
  value  = digitalocean_droplet.ros.ipv4_address
  type   = "A"
  proxied = false
}


resource "cloudflare_record" "ros_wildcard" {
  domain = "sikademo.com"
  name   = "*.${cloudflare_record.ros.hostname}"
  value  = "ros.sikademo.com"
  type   = "CNAME"
  proxied = false
}

output "ros_hostname" {
  value = cloudflare_record.ros.hostname
}
