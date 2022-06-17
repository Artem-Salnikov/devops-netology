terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = "key.json"
  token     = "AQAAAAABV1xIAATuwef1oKSv1U07gCrWDvB4ux8"
  cloud_id  = "b1gdpcadul65qj1rr8mi"
  folder_id = "b1gsekmk6se4akur9bl3"
  zone      = "ru-central1-a"
}
