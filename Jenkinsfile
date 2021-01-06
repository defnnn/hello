#!/usr/bin/env groovy

node() {
  withCredentials([[
      $class: 'VaultTokenCredentialBinding',
      credentialsId: 'VaultToken',
      vaultAddr: env.VAULT_ADDR ]]) {

    stage ('Read Secrets') {
      sh 'vault kv get kv/defn/hello'
      sh 'env | grep VAULT | sort'
    }

    stage ('Vault Token Lookup') {
      sh 'vault token lookup'
    }
  }
}
