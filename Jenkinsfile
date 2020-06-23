pipeline {

    agent { label "master" }

    options {
        ansiColor('xterm')
    }

    stages {
        stage("conf") {
            steps {
                script {
                    def pom = readMavenPom file: 'pom.xml'
                    env['PROJ'] = pom.artifactId
                    def inventory = readTrusted 'deployment/inventory'
                    env['SERVER_IP'] = inventory.split('\n')[1]
                }
            }
        }


        stage("build") {
            agent {
                docker {
                    image "maven:3-jdk-8-slim"
                    args "-v \$HOME/.m2:/root/.m2"
                    label 'docker'
                }
            }
            steps {
                sh 'mvn --version'
                sh 'mvn clean install -ntp -B -e'
                stash includes: 'target/demo.jar', name: 'demo-jar'
            }
        }

        stage("build img") {
            steps {
                unstash 'demo-jar'
                script {
                    env["IMAGE"] = "${env.PROJ}:${env.BRANCH_NAME}.${env.BUILD_ID}"
                    def customImage = docker.build(env["IMAGE"])
                    sh "docker save -o deployment/${env["IMAGE"]}.tar ${env["IMAGE"]}"
                }
            }
        }

        stage("deploy") {
            when {
                branch "release*"
            }
            steps {
                script {
                    ansiblePlaybook(
                            playbook: 'deployment/deploy.yml',
                            inventory: 'deployment/inventory',
                            colorized: true,
                            additionalParameters: '--error-if-no-plays-matched',
                            extras: "-e image=${env.IMAGE} " +
                                    "-e server_ip=${env.SERVER_IP} " +
                                    "-e project_name=${env.PROJ} " +
                                    "-vv",
                            credentialsId: 'test-key'
                    )
                }
            }
        }

        stage("test-deployment") {
            when {
                branch "release*"
            }
            steps {
                script {
                    sleep 30
                    sh "curl http://${env.SERVER_IP}:8080/greeting?name=katsok"
                }
            }
        }


    }
    post {
        always {
            script {
                def status = "${env.BUILD_TAG} - ${currentBuild.currentResult}"
                def body = """
Build: ${currentBuild.displayName}
Result: ${currentBuild.currentResult}
"""
                mail body: body, subject: status, to: 'michalazarovitz@gmail.com'
            }
        }
    }
}
