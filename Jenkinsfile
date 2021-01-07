#!/usr/bin/env groovy

def NM_ROLE = 'pipeline'
def ID_ROLE = 'b45fcd66-6e60-3c2f-57e9-c0c5ecd59df2'

node() {
  checkout scm

  withCredentials([[
    $class: 'VaultTokenCredentialBinding',
    credentialsId: 'VaultToken',
    vaultAddr: env.VAULT_ADDR ]]) {

    stage ('Env') {
      def SCM_VERSION = ''
      env.SCM_VERSION = sh(
        returnStdout: true,
        script: "git rev-parse --abbrev-ref HEAD"
      )
    }

    stage ('Secrets') {
      sh """
        ./ci/build "${NM_ROLE}" "${ID_ROLE}"
      """
    }

    stage('Goreleaser') {
      sh "env SCM_VERSION=${SCM_VERSION} /env.sh goreleaser --snapshot --rm-dist --skip-publish"
    }

    stage('Docker image') {
      sh "env SCM_VERSION=${SCM_VERSION} /env.sh docker run --rm defn/hello:${SCM_VERSION}-next-amd64"
    }
  }
}
