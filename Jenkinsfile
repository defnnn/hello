#!/usr/bin/env groovy

library 'defn/jenkins-kiki@main'

def config = [
  role: 'defn--hello',
  roleId: '7a87edd4-68d9-d7fb-974b-752f030c65b9',
  pipelineSecrets: [[
    path: 'kv/pipeline/defn--hello',
    secretValues: [
      [vaultKey: 'MEH1'],
      [vaultKey: 'MEH2']
    ]
  ]]
]

goMain(config) {
  if (env.TAG_NAME) {
    stage('Test Docker image') {
      sh "/env.sh docker run --rm --entrypoint /hello defn/hello:${env.GORELEASER_CURRENT_TAG.minus('v')}-amd64"
    }
  }
  else {
    stage('Test') {
      sh "uname -a"
    }
  }
}
