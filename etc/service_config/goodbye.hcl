service {
  name = "goodbye"
  id = "goodbye"
  address = "YYYY"
  port = 80

  tags = [
    "traefik.enable=true",
    "traefik.http.routers.goodbye.rule=HostRegexp(`goodbye.{domain:.+}`)",
    "traefik.http.services.goodbye.loadbalancer.server.port=80"
  ]
  
  connect { 
    sidecar_service {
      port = 20000
      
      check {
        name = "Connect Envoy Sidecar"
        tcp = "YYYY:20000"
        interval ="10s"
      }

      proxy {
        upstreams {
          destination_name = "hello"
          local_bind_address = "127.0.0.1"
          local_bind_port = 9091
        }
      }
    }  
  }
}
