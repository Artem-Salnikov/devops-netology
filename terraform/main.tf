terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "terraform-storage-asalnikov"
    region     = "ru-central1"
    key        = ".terraform/terraform.tfstate"
    access_key = "YCAJEHCgTm4rMuib1o8pOHdYg"
    secret_key = "YCPF2fjOjudFiHv6VZdt61H8qhmlDn4rglzNmF16"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  token                    = var.yc_token
  cloud_id                 = var.yc_cloud_id
  folder_id                = var.yc_folder_id
  zone                     = var.yc_region
}

resource "yandex_compute_instance" "vm-1" {
  name = "terraform1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8huthm018j2kafdk4p"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "vm-2" {
  name = "terraform2"

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8huthm018j2kafdk4p"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}