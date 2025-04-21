# 🚀 Standalone Apache Spark with Docker Compose

This project spins up a **standalone Apache Spark cluster** using Docker Compose.  This is useful for lightweight workloads on a single machine.

---

## 🧱 Stack

- **Spark Master** (Bitnami image)
- **Spark Worker** (Bitnami image)
- Networked via Docker bridge
- Spark UI and ports exposed for interaction

---

## 📦 Requirements

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)

---

## 🚀 Getting Started

```bash
docker compose up -d
