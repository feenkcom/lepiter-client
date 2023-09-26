pipeline {
    agent any
    stages {
        stage('Build Lepiter server') {
            when { expression {
                    env.BRANCH_NAME.toString().equals('main') && (env.TAG_NAME == null)
                }
            }
            steps {
                build(job: '../lepiter-server/main', wait: false)
            }
        }
    }
}
