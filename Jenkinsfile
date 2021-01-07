#!/usr/bin/env groovy

def ROLE = 'pipeline'
def ROLE_ID = 'b45fcd66-6e60-3c2f-57e9-c0c5ecd59df2'

node() {
  withCredentials([[
    $class: 'VaultTokenCredentialBinding',
    credentialsId: 'VaultToken',
    vaultAddr: env.VAULT_ADDR ]]) {

    stage ('asdf') {
      sh """
        pwd
        cat .tool-versions
        /env.sh asdf install
      """
    }

    stage ('Pipeline wrapped secret_id') {
      def WRAPPED_SID = ''
      env.WRAPPED_SID = sh(
        returnStdout: true,
        script: "/env.sh vault write -field=wrapping_token -wrap-ttl=200s -f auth/approle/role/${ROLE}/secret-id"
      )
    }

    stage ('Pipeline unwrap secret_id') {
      def UNWRAPPED_SID = ''
      env.UNWRAPPED_SID = sh(
        returnStdout: true,
        script: "/env.sh vault unwrap -field=secret_id ${WRAPPED_SID}"
      )
    }

    stage ('Pipeline login token') {
      sh """
        echo set +x > token
        echo -n export VAULT_TOKEN= >> token
        /env.sh vault write -field=token auth/approle/login role_id=${ROLE_ID} secret_id=${UNWRAPPED_SID} | tee -a token
        (echo; echo set -x) >> token
      """
    }

    stage ('Pipeline token info') {
      sh ". ./token && /env.sh vault token lookup"
      sh ". ./token && /env.sh vault token revoke -self"
    }

    stage('Goreleaser') {
      sh "/env.sh goreleaser build --snapshot"
    }

  }
}
