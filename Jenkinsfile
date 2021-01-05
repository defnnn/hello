#!/usr/bin/env groovy

//def VAULT_ADDR = "http://127.0.0.1:8200"
//env.VAULT_ADDR = VAULT_ADDR

node() {
  timestamps {
    withCredentials([[
        $class: 'VaultTokenCredentialBinding',
        credentialsId: 'VaultToken'
//        vaultAddr: 'http://127.0.0.1:8200'
      ]]) {

      stage ('Vault Token Lookup') {
        sh(
          returnStdout: true,
          script: "vault token lookup"
        )
      }
    }          
  }
}
