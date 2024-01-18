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
        sh 'mvn clean install'
  }
}
    stage('deploy') {
      steps {
       sh 'scp /home/slave1/workspace/BGM123/target/hello-world-war-1.0.0.war root@172.31.22.10:/opt/apache-tomcat-9.0.85/webapps/'

 }
}
  }
}
