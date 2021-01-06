#!/usr/bin/env groovy

node() {
  withCredentials([[
      $class: 'VaultTokenCredentialBinding',
      credentialsId: 'VaultToken',
      vaultAddr: env.VAULT_ADDR ]]) {

    stage ('Read Secrets') {
      sh 'vault token lookup'
    }
  }

  stage ('Read Secrets without credentials') {
    sh 'vault token lookup'
  }
}
