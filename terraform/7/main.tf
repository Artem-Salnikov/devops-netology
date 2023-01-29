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
#    access_key = "YCAJEH"
#    secret_key = "YCPF2f"

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

resource "yandex_compute_instance" "Node" {
  name = "Node-${format(var.count_format, var.count_offset+count.index+1)}"
  count = 2

  resources {
    cores  = local.cores[terraform.workspace]
    memory = local.memory[terraform.workspace]
  }

  boot_disk {
    initialize_params {
      image_id = "fd8huthm018j2kafdk4p"
      type = local.disk_type[terraform.workspace]
      size = local.disk_size[terraform.workspace]
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

resource "yandex_compute_instance" "ForEach" {
  for_each   = toset(local.instances_name[terraform.workspace])
  name = "Node_foreach-${each.key}"

  resources {
    cores  = local.cores[terraform.workspace]
    memory = local.memory[terraform.workspace]
  }

  boot_disk {
    initialize_params {
      image_id = "fd8huthm018j2kafdk4p"
      type = local.disk_type[terraform.workspace]
      size = local.disk_size[terraform.workspace]
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

  locals {
  cores = {
    stage = 2
    prod = 4
  }
  disk_size = {
    stage = 20
    prod = 40
  }
  instance_count = {
    stage = 1
    prod = 2
  }
  memory = {
    stage = 2
    prod = 4
  }
  disk_type = {
    stage = "network-hdd"
    prod = "network-ssd"
  }
  instances_name = {
    stage = ["1", "2"]
    prod = ["1", "2", "3"]
  }
  } 
