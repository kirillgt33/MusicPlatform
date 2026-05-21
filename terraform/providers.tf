terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  cloud_id  = "ao7odmh34pr4sq575v1a"
  folder_id = "ao76ri81fetlanol6fe3"
  zone      = "kz-central1-a"
}