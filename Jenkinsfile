pipeline {
    agent any
    environment {
        //be sure to replace "bhavukm" with your own Docker Hub username
        JAVA_HOME = '/usr/lib/jvm/java-11-openjdk-amd64'
        DOCKER_IMAGE_NAME = "bhavukm/train-schedule"
    }
    stages {
        stage('Build') {
            steps {
                echo 'Running build automation'
                //sh 'sudo chmod +x /var/lib/jenkins/.gradle/wrapper/dists/gradle-4.6-bin/4jp4stjndanmxuerzfseyb6wo/gradle-4.6/bin/gradle'
		sh 'sudo chmod +x /var/lib/jenkins/.gradle/wrapper/dists/gradle-6.0-bin/8ccdmgaih4za71r0tlxhaz33m/gradle-6.0/bin/gradle'
                sh './gradlew build --no-daemon'
                archiveArtifacts artifacts: 'dist/trainSchedule.zip'
            }
        }
        //stage('Build Docker Image') {
            //steps {
              //  script {
                //    app = docker.build(DOCKER_IMAGE_NAME)
                  //  app.inside {
                    //    sh 'echo Hello, World!'
                    //}
                //}
            //}
        //}

	//stage('Docker Push') {
    	  // steps {
            //   script {
            	//sh 'docker login -u rajlearn29 -p Trunksmagina123@'
	    	//sh 'docker push rajlearn29/train-schedule:latest'
	       //}
	   //}
	//}

        //stage('Push Docker Image') {
            //steps {
                //script {
                    //docker.withRegistry('https://registry-1.docker.io', 'docker_hub_login') {
                        //app.push("${env.BUILD_NUMBER}")
                        //app.push("latest")
                    //}
                //}
            //}
        //}
	stage('Deploy to Kubernetes') {
    	    steps {
		script {
        	    sh 'kubectl apply -f train-schedule-kube-canary.yml'
          	}
    	    }
	}
	    
        //stage('CanaryDeploy') {
            //environment { 
               // CANARY_REPLICAS = 1
           // }
           // steps {
               // kubernetesDeploy(
                  //  kubeconfigId: 'kubeconfig',
                   // configs: 'train-schedule-kube-canary.yml',
                   // enableConfigSubstitution: true
                //)
            //}
        //}
        stage('DeployToProduction') {
            when {
                branch 'master'
            }
            environment { 
                CANARY_REPLICAS = 0
            }
            steps {
                input 'Deploy to Production?'
                milestone(1)
                kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'train-schedule-kube-canary.yml',
                    enableConfigSubstitution: true
                )
                kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'train-schedule-kube.yml',
                    enableConfigSubstitution: true
                )
            }
        }
    }
}
