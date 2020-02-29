
def appName = "my-app"
def appVersion = "1.0-SNAPSHOT"

/* ========================================================================= */
node('slavevd'){
    tool name: 'maven', type: 'maven'

    stage('***************** Check prerequests *****************'){
        withEnv(["PATH=${env.PATH}:${tool 'maven'}/bin"]){
            sh 'env | grep PATH'
            sh 'mvn -v'
        }
    }

    stage('***************** Get sources *****************'){
        git(url: 'git@github.com:jenkins-docs/simple-java-maven-app.git', branch: "master", credentialsId: 'git')
    }

    stage('***************** Build *****************'){
        withEnv(["PATH=${env.PATH}:${tool 'maven'}/bin"]){
            sh 'mvn -B -DskipTests clean package'
        }        
    }
    stage('***************** Test *****************'){
        withEnv(["PATH=${env.PATH}:${tool 'maven'}/bin"]){
            sh 'mvn test'
            stash includes: 'target/my-app-1.0-SNAPSHOT.jar', name: 'artifactStash'
        }        
    }
}
/* ========================================================================= */
node('slavevd'){
    tool name: 'docker-latest', type: 'org.jenkinsci.plugins.docker.commons.tools.DockerTool'

    stage('***************** Ckeck prerequest *****************'){
        echo "${tool name: 'docker-latest'}"
        sh "ls -lah"
        withEnv(["PATH=${env.PATH}:${tool name: 'docker-latest'}/bin"]){
            sh 'docker -v'
        } 
    }

    stage('***************** Get Dockerfile *****************'){
        git(url: 'git@github.com:voodooq3/jenkins-test.git', branch: "master", credentialsId: 'git')
    }

    stage('***************** Unstash application *****************'){
        unstash 'artifactStash'
        sh 'ls -l'
    }

    stage('***************** Buiuld our Docker *****************'){
        withEnv(["PATH=${env.PATH}:${tool name: 'docker-latest'}/bin"]){        
            sh "docker build --no-cache --build-arg APP_NAME=${appName} --build-arg APP_VERSION=${appVersion} -t myappdocker ."
        }
    }

 }

step([$class: 'CordellWalkerRecorder']): Activate Chuck


