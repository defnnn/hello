service {
  name = "hello"
  id = "hello"
  address = "YYYY"
  port = 80

  tags = [
  ]
  
  connect { 
    sidecar_service {
      port = 20000
      
      check {
        name = "Connect Envoy Sidecar"
        tcp = "YYYY:20000"
        interval ="10s"
      }
    }  
  }
}
