terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  # Тут пока оставляем пустым, мы авторизуемся через консольную утилиту чуть позже
  cloud_id  = "ao7odmh34pr4sq575v1a"
  folder_id = "ao76ri81fetlanol6fe3"
  zone      = "ru-central1-a" # Самая популярная и дешевая зона
}