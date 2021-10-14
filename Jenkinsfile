pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "M3"
    }

    stages {
	stage('Prepare') {
		steps {
			checkout([$class: 'GitSCM', branches: [[name: '*/master-next']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/phlmm/yocto-ugoos']]])
			sh "make .do_create_structure"
			sh "make .do_repo_checkout"
		}
	}	
        stage('Build') {
            steps {
		sh "cd shared && source ugoos-init; bitbake ugoos-kodi"
            }

        }
    }
}

