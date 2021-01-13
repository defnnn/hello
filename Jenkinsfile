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

goreleaserMain(config) {
  stage('Style') {
    sh("make style")
  }

  stage('Test') {
    sh("make test")
  }
  if (env.TAG_NAME) {
    withEnv(["DOCKER_IMAGE=defn/hello:${env.GORELEASER_CURRENT_TAG.minus('v')}-amd64"]) {
      stage('Test Docker image') {
        sh("make docker")
      }
    }
  }
}
