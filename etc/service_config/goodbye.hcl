service {
  name = "goodbye"
  id = "goodbye"
  address = "YYYY"
  port = 80

  tags = [
    "traefik.enable=true",
    "traefik.http.routers.goodbye.rule=HostRegexp(`goodbye.{domain:.+}`)"
  ]
}
