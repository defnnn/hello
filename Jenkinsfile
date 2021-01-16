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
    retry(3) {
      sh("make ci-drone-style")
    }
  }

  withEnv([
    "VAULT_ADDR=", "VAULT_TOKEN=", "GITHUB_TOKEN=", "DOCKER_USERNAME=",
    "DOCKER_PASSWORD=", "UNWRAPPED_SID=", "WRAPPED_SID="]) {

    stage('Test: Docker') {
      docker.image("defn/jenkins").inside {
        sh("make ci-docker-test")
      }
    }
  }

  docker.image("defn/jenkins-go").inside {
    withEnv([
      "VAULT_ADDR=", "VAULT_TOKEN=", "GITHUB_TOKEN=", "DOCKER_USERNAME=",
      "DOCKER_PASSWORD=", "UNWRAPPED_SID=", "WRAPPED_SID="]) {

      stage('Test: Go') {
        sh("make ci-go-test")
      }

      if (env.TAG_NAME) {
        goRelease()
      }
      else {
        goBuild()
      }
    }
  }
}
