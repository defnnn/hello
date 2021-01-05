#!/usr/bin/env groovy

node() {
  withCredentials([[
      $class: 'VaultTokenCredentialBinding',
      credentialsId: 'VaultToken'
    ]]) {

    stage ('Vault Token Lookup') {
      sh 'vault token lookup'
    }
  }          
}
