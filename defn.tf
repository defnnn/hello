job "defn" {
  region      = "global"
  datacenters = ["defn"]
  type        = "service"

  update {
    max_parallel     = 1
    min_healthy_time = "10s"
    healthy_deadline = "3m"
    auto_revert      = false
    canary           = 0
  }

  group "defn" {
    count = 2
  
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

    task "defn" {
      driver = "docker"

      config {
        image = "containous/whoami"
        args = ["--port", "${NOMAD_PORT_defn}"]
      }

      resources {
        cpu    = 100
        memory = 64
        network {
          port "defn" {}
        }
      }

      service {
        name = "defn"
        port = "defn"

        tags = [
          "traefik.enable=true",
          "traefik.http.routers.defn.entrypoints=https",
          "traefik.http.routers.defn.rule=HostRegexp(`defn.{domain:.+}`)"
        ]
      }
    }
  }
}
