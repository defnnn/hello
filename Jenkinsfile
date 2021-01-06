#!/usr/bin/env groovy

node() {
  stage ('Read Secrets') {
    withCredentials([[
        $class: 'VaultTokenCredentialBinding',
        credentialsId: 'VaultToken',
        vaultAddr: env.VAULT_ADDR
      ]]) {
      sh 'vault kv get kv/defn/hello'
      sh 'env | grep VAULT | sort'
    }
  }

  stage ('Vault Token Lookup') {
    sh 'vault token lookup'
  }
}          
