#!/usr/bin/env groovy

library 'defn/jenkins-kiki@main'

kiki {
  sh("set +x; /env.sh figlet -f /j/broadway.flf hello | lolcat -f; echo")
}
