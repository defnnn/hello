job "kuard" {
  region      = "global"
  datacenters = ["dc1"]
  type        = "service"

  update {
    max_parallel     = 1
    min_healthy_time = "10s"
    healthy_deadline = "3m"
    auto_revert      = false
    canary           = 0
  }

  group "kuard" {
    count = 1

    restart {
      attempts = 10
      interval = "5m"
      delay    = "25s"
      mode     = "delay"
    }

    ephemeral_disk {
      sticky  = true
      migrate = true
      size    = 300
    }

    task "kuard" {
      driver = "docker"

      config {
        image        = "gcr.io/kuar-demo/kuard-amd64:blue"
        network_mode = "kitt_default"
      }

      resources {
        cpu    = 100
        memory = 64
      }

      service {
        name         = "kuard"
        address_mode = "driver"
        port         = 8080

        check {
          type         = "http"
          path         = "/"
          interval     = "10s"
          timeout      = "2s"
          address_mode = "driver"
          port         = 8080
        }

        tags = [
          "traefik.enable=true",
          "traefik.http.routers.kuard.entrypoints=https",
          "traefik.http.routers.kuard.rule=HostRegexp(`kuard.{domain:.+}`)"
        ]
      }
    }
  }
}
