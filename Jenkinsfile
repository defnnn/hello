#!/usr/bin/env groovy

def NM_ROLE = 'pipeline'
def ID_ROLE = 'b45fcd66-6e60-3c2f-57e9-c0c5ecd59df2'

def secrets = [
  [ 
    path: 'kv/defn/hello',
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
          sh "env | grep NAME"
          sh "echo ${NAME}"
        }
      }
    }

    stage('Goreleaser') {
      sh "/env.sh goreleaser --snapshot --rm-dist"
    }

    stage('Docker image') {
      sh "/env.sh docker run --rm defn/hello:${BUILD_TAG}-amd64"
    }

    // inside this block your credentials will be available as env variables
    withVault([configuration: configuration, vaultSecrets: secrets]) {
        sh 'echo $testing'
        sh 'echo $testing_again'
        sh 'echo $another_test'
    }
  }
}
