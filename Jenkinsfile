#!/usr/bin/env groovy

def NM_ROLE = 'pipeline'
def ID_ROLE = 'b45fcd66-6e60-3c2f-57e9-c0c5ecd59df2'

def githubSecrets = [
  [ 
    path: 'kv/defn/hello',
    engineVersion: 2,
    secretValues: [
      [vaultKey: 'GITHUB_TOKEN']
    ]
  ]
]

node() {
  checkout scm

  def GORELEASER_CURRENT_TAG = ''
  env.GORELEASER_CURRENT_TAG = "v0.${CHANGE_ID}.${BUILD_ID}"

  withCredentials([[
    $class: 'VaultTokenCredentialBinding',
    credentialsId: 'VaultToken',
    vaultAddr: env.VAULT_ADDR ]]) {

    stage ('Tag') {
      sh "env| grep TAG"
      sh "git tag ${GORELEASER_CURRENT_TAG}"
    }

    stage ('Secrets') {
      sh "./ci/build ${NM_ROLE} ${ID_ROLE}"
    }

    stage('Build') {
      withVault([vaultSecrets: githubSecrets]) {
        sh "/env.sh goreleaser --rm-dist"
      }
    }

    stage('Test Docker image') {
      sh "/env.sh docker run --rm defn/hello:${BUILD_TAG}-amd64"
    }

  }
}
