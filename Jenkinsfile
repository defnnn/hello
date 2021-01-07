#!/usr/bin/env groovy

def ROLE = 'pipeline'
def ROLE_ID = 'b45fcd66-6e60-3c2f-57e9-c0c5ecd59df2'

node() {
  withCredentials([[
    $class: 'VaultTokenCredentialBinding',
    credentialsId: 'VaultToken',
    vaultAddr: env.VAULT_ADDR ]]) {

    stage ('Pipeline wrapped secret_id') {
      def WRAPPED_SID = ''
      env.WRAPPED_SID = sh(
        returnStdout: true,
        script: "vault write -field=wrapping_token -wrap-ttl=200s -f auth/approle/role/${ROLE}/secret-id"
      )
    }

    stage ('Pipeline unwrap secret_id') {
      def UNWRAPPED_SID = ''
      env.UNWRAPPED_SID = sh(
        returnStdout: true,
        script: "vault unwrap -field=secret_id ${WRAPPED_SID}"
      )
    }

    stage ('Pipeline login token') {
      sh """
        echo set +x > token
        echo -n export VAULT_TOKEN= >> token
        vault write -field=token auth/approle/login role_id=${ROLE_ID} secret_id=${UNWRAPPED_SID} | tee -a token
        (echo; echo set -x) >> token
      """
    }

    stage ('Pipeline token info') {
      sh ". ./token && vault token lookup"
      sh ". ./token && vault token revoke -self"
    }

    stage('Compile binary') {
      sh "go build cmd/main.go"
      sh "./main"
      sh "rm -vf main"
    }

  }
}
