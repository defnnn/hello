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
    sh("make ci-drone-style")
  }

  stage('Test') {
    sh("make ci-test")
  }

  withEnv([
    "VAULT_ADDR=", "VAULT_TOKEN=", "GITHUB_TOKEN=", "DOCKER_USERNAME=",
    "DOCKER_PASSWORD=", "UNWRAPPED_SID=", "WRAPPED_SID="]) {
    stage('Test inside Docker') {
      docker.image("defn/jenkins").inside {
        sh """
          pwd
          uname -a
          id -a
          env | cut -d= -f1 | sort | xargs
        """
      }
    }
  }

  if (env.TAG_NAME) {
    docker.image("defn/jenkins-go").inside {
      sh("go test")
      goRelease()
    }
  }
  else {
    docker.image("defn/jenkins-go").inside {
      sh("go test")
      goBuild()
    }
  }
}
