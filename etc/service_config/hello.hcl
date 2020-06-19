service {
  name = "hello"
  id = "hello"
  address = "YYYY"
  port = 80
  
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
          destination_name = "traefik"
          local_bind_address = "127.0.0.1"
          local_bind_port = 9091
        }
      }
    }  
  }
}
