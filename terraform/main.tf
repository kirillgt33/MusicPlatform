# Описываем диск для операционной системы
resource "yandex_compute_disk" "boot_disk" {
  name     = "music-web-boot-disk"
  type     = "network-hdd"
  zone     = "kz-central1-a"
  size     = 15
  image_id = "fd80le8b88let16p969t" # ID образа Ubuntu 22.04 LTS
}

# Описываем саму виртуальную машину
resource "yandex_compute_instance" "music_server" {
  name        = "vxga-music-vm"
  platform_id = "standard-v3" # Третье поколение процессоров Intel
  zone        = "kz-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot_disk.id
  }

  network_interface {
    subnet_id = "ad1oahu1bbg5kc6hssej"
    nat       = true # Включаем публичный IP, чтобы сайт работал в интернетах
  }

  metadata = {
    # Передаем публичный SSH-ключ для безопасного доступа
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}