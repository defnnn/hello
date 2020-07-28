service {
  name = "next"
  id = "next"
  address = "169.254.32.1"
  port = 3000

  tags = [
    "traefik.enable=true",
    "traefik.http.routers.next.entrypoints=https",
    "traefik.http.routers.next.rule=HostRegexp(`next.{domain:.+}`)"
  ]
  
  checks {
    name = "next port TCP connect"
    tcp = "169.254.32.1:3000"
    interval = "10s"
  }

  connect { 
    sidecar_service {
      port = 20000
      
      check {
        name = "Connect Envoy Sidecar"
        tcp = "169.254.32.1:20000"
        interval ="10s"
      }
    }  
  }
}
