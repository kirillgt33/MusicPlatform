# Minimalist Music Portfolio Platform

A production-ready, high-performance web platform designed to showcase personal music tracks and portfolios. The project features a minimalist black-and-white visual aesthetic and is built with a modern, automated DevOps infrastructure.

## 🚀 Features & Architecture

- **Backend**: Lightweight Python Flask application containerized using an ultra-optimized **Alpine Linux** base image.
- **Audio Metadata**: Automated ID3 tag parsing and cover art extraction via `mutagen`.
- **Performance**: High-speed caching implemented with Python's `@lru_cache` to drastically reduce disk I/O latency and speed up track loading.
- **Production Server**: **Gunicorn** WSGI HTTP server running with multiple workers for concurrent request handling.
- **Reverse Proxy**: **Nginx** acting as a front-end reverse proxy, efficiently routing traffic, managing static assets (MP3s and images), and securing the application.
- **Infrastructure as Code (IaC)**: Automated cloud infrastructure provisioning on **Yandex Cloud** using **Terraform**.
- **Configuration Management**: Automating system configuration and directory layouts using **Ansible**.
- **Containerization**: Full multi-container orchestration managed natively via **Docker Compose** with built-in healthchecks for maximum uptime.

## 🛠️ Tech Stack

- **Languages**: Python, HTML5/CSS3 (Minimalist UI)
- **Frameworks & Libraries**: Flask, Mutagen
- **DevOps & Infrastructure**: Docker, Docker Compose, Nginx, Gunicorn, Terraform, Ansible, Git
- **Cloud Provider**: Yandex Cloud (Compute Cloud Engine)

## 📦 Local Development

1. Clone the repository:
```bash
git clone https://github.com/kirillgt33/MusicPlatform
cd MusicPlatform
```
2. Spin up the local environment:
```bash
docker compose up -d --build
```

Access the local music platform at http://localhost.

## 🌐 Production Deployment
The production environment infrastructure is fully automated:

Terraform provisions the virtual machine instance in Yandex Cloud.

Ansible configures target directories, permissions (chmod/chown), and updates the host package manager.

Docker Compose orchestrates and maintains active health monitoring of the running services.