#!/usr/bin/env groovy

def NM_ROLE = 'pipeline'
def ID_ROLE = 'b45fcd66-6e60-3c2f-57e9-c0c5ecd59df2'

def githubSecrets = [
  [ 
    path: 'kv/defn/hello',
    engineVersion: 2,
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

    stage ('Secrets') {
      sh "./ci/build ${NM_ROLE} ${ID_ROLE}"
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
