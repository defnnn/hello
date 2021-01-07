#!/usr/bin/env groovy

def NM_ROLE = 'pipeline'
def ID_ROLE = 'b45fcd66-6e60-3c2f-57e9-c0c5ecd59df2'

def secrets = [
  [ 
    path: 'kv/defn/hello',
    engineVersion: 2,
    secretValues: [
      [envVar: 'MEH', vaultKey: 'name']
    ]
  ]
]

node() {
  checkout scm

  withCredentials([[
    $class: 'VaultTokenCredentialBinding',
    credentialsId: 'VaultToken',
    vaultAddr: env.VAULT_ADDR ]]) {

    stage ('Secrets') {
      sh """
        ./ci/build "${NM_ROLE}" "${ID_ROLE}"
      """

      withVault([vaultSecrets: secrets]) {
        sh "echo ${MEH}"
      }
    }

    stage('Build') {
      sh "/env.sh goreleaser --rm-dist"
    }

    stage('Test Docker image') {
      sh "/env.sh docker run --rm defn/hello:${BUILD_TAG}-amd64"
    }

  }
}
