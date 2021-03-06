#!groovy

import com.cloudbees.jenkins.plugins.sshcredentials.impl.*
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.common.*
import com.cloudbees.plugins.credentials.domains.Domain
import com.cloudbees.plugins.credentials.impl.*
import hudson.util.Secret
import java.nio.file.Files
import jenkins.model.Jenkins
import net.sf.json.JSONObject
import org.jenkinsci.plugins.plaincredentials.impl.*

Jenkins.instance.setLabelString('docker')

// parameters
def jenkinsMasterKeyParameters = [
  description:  'test-key',
  id:           'test-key',
  secret:       '',
  userName:     'ec2-user',
  key:          new BasicSSHUserPrivateKey.DirectEntryPrivateKeySource('''
-----BEGIN RSA PRIVATE KEY-----
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
-----END RSA PRIVATE KEY-----
''')
]

// get Jenkins instance
Jenkins jenkins = Jenkins.getInstance()

// get credentials domain
def domain = Domain.global()

// get credentials store
def store = jenkins.getExtensionList('com.cloudbees.plugins.credentials.SystemCredentialsProvider')[0].getStore()

// define private key
def privateKey = new BasicSSHUserPrivateKey(
  CredentialsScope.GLOBAL,
  jenkinsMasterKeyParameters.id,
  jenkinsMasterKeyParameters.userName,
  jenkinsMasterKeyParameters.key,
  jenkinsMasterKeyParameters.secret,
  jenkinsMasterKeyParameters.description
)

// add credential to store
store.addCredentials(domain, privateKey)

// save to disk
jenkins.save()