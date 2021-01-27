#!/usr/bin/env groovy

library 'defn/jenkins-kiki@main'

properties([
  parameters([
    string(name: 'hello', defaultValue: 'hello'),
    string(name: 'present', defaultValue: 'world')
  ])
])

kiki(null) {
  lolcat(hello)

  goreleaserMain()

  figlet(present, 'broadway')
}
