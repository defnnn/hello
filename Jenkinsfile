#!/usr/bin/env groovy

node() {
  // sets VAULT_TOKEN
  withCredentials([[
      $class: 'VaultTokenCredentialBinding',
      credentialsId: 'VaultToken',
      vaultAddr: env.VAULT_ADDR ]]) {

    stage ('Read Secrets') {
      sh 'vault token lookup'
    }
  }
}
