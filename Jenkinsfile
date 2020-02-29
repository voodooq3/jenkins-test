
def appName = "my-app"
def appVersion = "1.0-SNAPSHOT"

node('slavevd'){
    tool name: 'maven', type: 'maven'

    stage('***************** Check prerequests *****************'){
        withEnv(["PATH=${env.PATH}:${tool 'maven'}/bin"]){
            sh 'env | grep PATH'

            sh 'mvn -v'
        }
    }
// /* ========================================================================= */
//     stage('***************** Get sources *****************'){
//         git(url: 'git@github.com:jenkins-docs/simple-java-maven-app.git', branch: "master", credentialsId: 'git')
//     }

//     stage('***************** Build *****************'){
//         withEnv(["PATH=${env.PATH}:${tool 'maven'}/bin"]){
//             sh 'mvn -B -DskipTests clean package'
//         }        
//     }
//     stage('***************** Test *****************'){
//         withEnv(["PATH=${env.PATH}:${tool 'maven'}/bin"]){
//             sh 'mvn test'
//             stash includes: 'target/my-app-1.0-SNAPSHOT.jar', name: 'artifactStash'
//         }        
//     }
// }
// /* ========================================================================= */
// node('***************** dockerAgent1 *****************'){
//     tool name: 'docker-latest', type: 'org.jenkinsci.plugins.docker.commons.tools.DockerTool'
//     stage('Ckeck prerequest'){
//         echo "${tool name: 'docker-latest'}"
//         sh "ls -lah"
//         withEnv(["PATH=${env.PATH}:${tool name: 'docker-latest'}/bin"]){
//             sh 'docker -v'
//         } 
//     }

//     stage('***************** Get Dockerfile *****************'){
//         git(url: 'git@github.com:zulus911/lecture23.git', branch: "master", credentialsId: 'git')
//     }

//     stage('*****************unstash our application *****************'){
//         unstash 'artifactStash'
//     }

//     stage('***************** Buiuld our Docker *****************'){
//         withEnv(["PATH=${env.PATH}:${tool name: 'docker-latest'}/bin"]){        
//             sh "docker build --no-cache --build-arg APP_NAME=${appName} --build-arg APP_VERSION=${appVersion} -t myappdocker ."
//         }
//     }

// }























// pipeline {
//   environment {
//     registry = "voodooq3/docker-test"
//     registryCredential = 'dockerhub'
//     dockerImage = ''
//   }
  
//     agent {
//         docker {
//             image 'maven:3.6.3-jdk-8'
// //            image 'maven:latest'
//             args '-v /root/.m2:/root/.m2'
//         }
//     }
    
//     stages {
//         stage('***************** GIT *****************') {
//             steps {
//                 git 'https://github.com/jenkins-docs/simple-java-maven-app.git'
//             }
//         }
        
//         stage('***************** Build *****************') {
//             steps {
//                 sh 'mvn -B -DskipTests clean package'
//             }
//         }
//         stage('***************** Test *****************') {
//             steps {
//                 sh 'mvn test'
//             }
//             post {
//                 always {
//                     junit 'target/surefire-reports/*.xml'
//                 }
//             }
//         }
//         stage('***************** Deliver *****************') {
//             steps { 
//                 sh './jenkins/scripts/deliver.sh'
//             }
//         }
        
// // ================================
// stage('***************** Building image *****************') {
//       steps{
//         script {
//           dockerImage = docker.build registry + ":$BUILD_NUMBER"
//         }
//       }
//     }
//     stage('***************** Deploy Image *****************') {
//       steps{
//         script {
//           docker.withRegistry( '', registryCredential ) {
//             dockerImage.push()
//           }
//         }
//       }
//     }
//     stage('***************** Remove Unused docker image *****************') {
//       steps{
//         sh "docker rmi $registry:$BUILD_NUMBER"
//       }
//     }    
 
    
// // ================================
//     }
// }