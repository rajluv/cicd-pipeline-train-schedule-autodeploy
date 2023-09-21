pipeline {
    agent any
    environment {
        //be sure to replace "bhavukm" with your own Docker Hub username
        JAVA_HOME = '/usr/lib/jvm/java-11-openjdk-amd64'
        DOCKER_IMAGE_NAME = "rajlearn29/train-schedule"
    }
    stages {
        stage('Build') {
            steps {
                echo 'Running build automation'
                //sh 'sudo chmod +x /opt/devopsadmin/.gradle/wrapper/dists/gradle-4.6-bin/4jp4stjndanmxuerzfseyb6wo/gradle-4.6/bin'
		sh 'sudo chmod +x /var/lib/jenkins/.gradle/wrapper/dists/gradle-6.0-bin/8ccdmgaih4za71r0tlxhaz33m/gradle-6.0/bin/gradle'
                sh './gradlew build --no-daemon'
                archiveArtifacts artifacts: 'dist/trainSchedule.zip'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    app = docker.build(DOCKER_IMAGE_NAME)
                    app.inside {
                        sh 'echo Hello, World!'
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry-1.docker.io', 'docker_hub_login') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
	stage('CANARY DEPLOYMENT') {
            steps {
		sh "chmod +x kubedeploy.sh"
                sh "./kubedeploy.sh"
            }
        }

	stage('Train-Schedule PROD DEPLOYMENT') {
            steps {
		sh "chmod +x kubedeploy-Prod.sh"
                sh "./kubedeploy-Prod.sh"
            }
        }
    }
}
