/*  ######### Let's Roll ######### */

def appName = "my-app"
def appVersion = "1.0-SNAPSHOT"
def imageName = "voodooq3/mavendocker"
def dockerImage = ''

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
node('slavevdjnlp'){
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

    // stage('***************** Buiuld container v1 and v2 *****************'){
    //     withEnv(["PATH=${env.PATH}:${tool name: 'docker-latest'}/bin"]){        
    //         sh "docker build --no-cache --build-arg APP_NAME=${appName} --build-arg APP_VERSION=${appVersion} -t ${imageName} ."
    //         sh "docker ps -a"
    //     }
    // }

    // stage('***************** Push container v1 *****************'){
    //     withEnv(["PATH=${env.PATH}:${tool name: 'docker-latest'}/bin"]){   
    //         withCredentials([usernamePassword(credentialsId: 'DockerHubCred', usernameVariable: 'DockerHubUser', passwordVariable: 'DockerHubPass')]) {
    //             sh "docker login -u $DockerHubUser -p $DockerHubPass"
    //          }
    //          sh "docker push ${imageName}"
    //          sh "docker rmi ${imageName}"
    //     }
    // }

    // stage('***************** Push container v2 *****************'){
    //     withEnv(["PATH=${env.PATH}:${tool 'docker-latest'}/bin"]){
    //         withDockerRegistry(credentialsId: 'DockerHubCred', toolName: 'docker-latest', url: ''){
    //             // sh "docker tag mavendocker voodooq3/mavendocker"
    //             sh "docker push ${imageName}"
    //         }
    //         sh "docker rmi ${imageName}"
    //     }
    // }

	stage('***************** Build Dockerfile v3 *****************'){
        withEnv(["PATH=${env.PATH}:${tool 'docker-latest'}/bin"]){
            dockerImage = docker.build("${imageName}", "--no-cache --build-arg APP_NAME=${appName} --build-arg APP_VERSION=${appVersion} .")
        }
    }

    stage('***************** Push image v3 *****************') {
        withEnv(["PATH=${env.PATH}:${tool 'docker-latest'}/bin"]){
            withDockerRegistry(credentialsId: 'DockerHubCred', toolName: 'docker-latest', url: 'https://index.docker.io/v1/'){  
                dockerImage.push()
            }
        }
    }

    stage('***************** Chuck Norris *****************') {
        step([$class: 'hudson.plugins.chucknorris.CordellWalkerRecorder'])
    }

 }

/* ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼#
# ######################## The End ########################
# #▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲*/
