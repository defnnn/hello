#!/usr/bin/env groovy

def NM_ROLE = 'pipeline'
def ID_ROLE = 'b45fcd66-6e60-3c2f-57e9-c0c5ecd59df2'

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
    }

    stage('Goreleaser') {
      sh "/env.sh goreleaser build --snapshot --rm-dist"
    }

    stage('Docker image') {
      sh "/env.sh docker run --rm -ti defn/hello:test"
    }
  }
}
