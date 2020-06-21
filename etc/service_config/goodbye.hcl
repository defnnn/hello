service {
  name = "goodbye"
  id = "goodbye"
  address = "YYYY"
  port = 80

  tags = [
    "traefik.enable=true",
    "traefik.http.routers.goodbye.rule=HostRegexp(`goodbye.{domain:.+}`)"
  ]

  checks {
    name = "Goodbye port TCP connect"
    tcp = "YYYY:80"
    interval = "10s"
  }
}
