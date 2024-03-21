pipeline {
  agent {label 'slave1'}
  stages {
    stage ('checkout') {
      steps {
        sh 'rm -rf helloworld'
       sh 'git clone https://github.com/Gowda1993/helloworld.git'
      }
    }
    stage ('build') {
      steps {
        sh 'echo "inside build"'
        dir("helloworld")
        {
          sh 'echo "inside dir"'
          sh 'docker build -t tomcat-war:1.0'
        }
  }
}
    stage('deploy') {
      steps {
       sh 'docker rm -f tomcat-war'
        sh 'docker run -d -p 8080:8080 --name tomcat-war tomcat-war:1.0'

 }
}
  }
}
