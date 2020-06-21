service {
  kind = "connect-proxy"
  name = "goodbye-sidecar-proxy"
  id = "goodbye-sidecar-proxy"
  address = "YYYY"
  port = 20000

  checks {
    name = "Connect Sidecar Listening"
    tcp = "YYYY:20000"
    interval = "10s"
  }

  checks {
    name = "Connect Sidecar Aliasing goodbye"
    alias_service = "goodbye"
  }  

  proxy {
    destination_service_name = "goodbye"
    destination_service_id =  "goodbye"
    local_service_address = "127.0.0.1"
    local_service_port = 80
  }
}
