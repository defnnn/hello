#!/usr/bin/env groovy

library 'defn/jenkins-kiki@main'

def nmDocker = 'defn/hello'
def vendorPrefix = ''
def nmBinary = 'hello'

def nmProject = 'defn/hello'
def nmJob= 'defn--hello'
def pipelineRoleId = '7a87edd4-68d9-d7fb-974b-752f030c65b9'

def githubSecrets = [
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
  goMain(pipelineRoleId, githubSecrets, nmJob, nmBinary, nmDocker, vendorPrefix)
}
