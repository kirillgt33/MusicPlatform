# 1. Создаем изолированную виртуальную сеть (VPC)
resource "yandex_vpc_network" "music_net" {
  name = "vxga-music-network"
}

# 2. Создаем подсеть в зоне ru-central1-a
resource "yandex_vpc_subnet" "music_subnet" {
  name           = "vxga-music-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.music_net.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

# 3. Поднимаем сам облачный сервер
resource "yandex_compute_instance" "music_server" {
  name        = "vxga-music-vm"
  platform_id = "standard-v3" # Третье поколение процессоров (Intel Ice Lake)

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20 # Экономичный режим: процессор работает на 20% мощности, для Flask этого выше крыши
  }

  boot_disk {
    initialize_params {
      image_id = "fd80bm0g9v98066v9694" # Официальный чистый образ Ubuntu 22.04 LTS
      size     = 15                     # Диск на 15 ГБ (хватит для системы и докера)
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.music_subnet.id
    nat       = true # Включает внешний публичный IP-адрес, чтобы сайт был виден в интернете
  }

  metadata = {
    # Автоматически прокидываем твой публичный SSH-ключ для пользователя ubuntu
    # Чтобы ты и Ansible могли заходить на сервер без паролей
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

# Выводим IP-адрес сервера в консоль после успешного деплоя
output "external_ip" {
  value       = yandex_compute_instance.music_server.network_interface.0.nat_ip_address
  description = "Публичный IP-адрес музыкального сервера"
}