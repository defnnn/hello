#!/usr/bin/env groovy

library 'defn/jenkins-kiki@main'

def nmDocker = 'defn/hello'
def nmBinary = 'hello'
def nmJob= 'defn--hello'

def vendorPrefix = ''

def pipelineRoleId = '7a87edd4-68d9-d7fb-974b-752f030c65b9'

def jenkinsSecrets = [
  [ 
    path: 'kv/jenkins/common',
    secretValues: [
      [vaultKey: 'GITHUB_TOKEN'],
      [vaultKey: 'DOCKER_USERNAME'],
      [vaultKey: 'DOCKER_PASSWORD']
    ]
  ]
]

def pipelineSecrets = [
  [ 
    path: 'kv/pipeline/' + nmJob,
    secretValues: [
      [vaultKey: 'MEH1'],
      [vaultKey: 'MEH2']
    ]
  ]
]

node() {
  goMain(pipelineRoleId, jenkinsSecrets, pipelineSecrets, nmJob, nmBinary, nmDocker, vendorPrefix)
}
