#!/usr/bin/env groovy

def githubSecrets = [
  [ 
    path: 'kv/defn/hello',
    secretValues: [
      [vaultKey: 'GITHUB_TOKEN'],
      [vaultKey: 'DOCKER_USERNAME'],
      [vaultKey: 'DOCKER_PASSWORD']
    ]
  ]
]

node() {
  checkout scm

  env.GORELEASER_CURRENT_TAG = "0.${env.CHANGE_ID ?: 0}.${env.BUILD_ID}-${env.BUILD_TAG}"

  withCredentials([[
    $class: 'VaultTokenCredentialBinding',
    credentialsId: 'VaultToken',
    vaultAddr: env.VAULT_ADDR ]]) {

    stage ('Tag') {
      sh "git tag ${env.GORELEASER_CURRENT_TAG}"
    }

    stage('Build') {
      withVault([vaultSecrets: githubSecrets]) {
        sh "env | grep ^DOCKER_PASSWORD= | cut -d= -f2- | docker login --password-stdin --username ${DOCKER_USERNAME}"
        sh "/env.sh goreleaser --rm-dist"
      }
    }

    stage('Test Docker image') {
      sh "/env.sh docker run --rm defn/hello:${env.GORELEASER_CURRENT_TAG}-amd64"
    }

  }
}
