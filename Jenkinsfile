#!/usr/bin/env groovy

node() {
  withCredentials([[
      $class: 'VaultTokenCredentialBinding',
      credentialsId: 'VaultToken',
      vaultAddr: env.VAULT_ADDR
    ]]) {

    stage ('Vault Token Lookup') {
      sh 'vault token lookup'
    }

    stage ('Read Secrets') {
      sh 'vault kv get kv/defn/hello'
    }
  }          
}
