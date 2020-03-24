/*  ############################## */
/*  ######### Let's Roll ######### */
/*  ############################## */

def appName = "my-app"
def appVersion = "1.0-SNAPSHOT"
def imageName = "voodooq3/mavendocker"
def dockerImage = ''

/*  ############################## */
podTemplate(cloud: 'kubernetes', containers: [
    containerTemplate(
        name: 'jnlp',
        // image: 'jenkins/jnlp-slave:latest',
        image: 'voodooq3/slavevd:v1',
        ttyEnabled: true,
        privileged: true,
        alwaysPullImage: false,
        workingDir: '/home/jenkins/agent',
        resourceRequestCpu: '400m',
        resourceLimitCpu: '400m',
        resourceRequestMemory: '1024Mi',
        resourceLimitMemory: '1024Mi',
        envVars: [
            envVar(key: 'JENKINS_URL', value: 'http://jenkins.jenkins.svc.cluster.local:8080'),
        ]
    ),
]
)

{
    node(POD_LABEL){
        container('jnlp') {
            tool name: 'test-maven', type: 'maven'
            stage('***************** Check prerequests *****************'){
            withEnv(["PATH=${env.PATH}:${tool 'test-maven'}/bin"]){
            sh 'env | grep PATH'
            sh 'mvn -v'
            }
        }  

        stage('***************** Get sources *****************'){
            git(url: 'git@github.com:jenkins-docs/simple-java-maven-app.git', branch: "master", credentialsId: 'git')
        }

        stage('***************** Build *****************'){
            withEnv(["PATH=${env.PATH}:${tool 'test-maven'}/bin"]){
                sh 'mvn -B -DskipTests clean package'
            }        
        }
        stage('***************** Test *****************'){
            withEnv(["PATH=${env.PATH}:${tool 'test-maven'}/bin"]){
                sh 'mvn test'
                stash includes: 'target/my-app-1.0-SNAPSHOT.jar', name: 'artifactStash'
            }        
        }
      }
    }
}

/*  ############################## */
podTemplate(cloud: 'kubernetes', containers: [
    containerTemplate(
        name: 'docker',
        image: 'docker:19.03.1-dind',
        ttyEnabled: true,
        privileged: true,
        alwaysPullImage: false,
        workingDir: '/home/jenkins/agent',
        resourceRequestCpu: '400m',
        resourceLimitCpu: '400m',
        resourceRequestMemory: '1024Mi',
        resourceLimitMemory: '1024Mi',
        envVars: [
            envVar(key: 'JENKINS_URL', value: 'http://jenkins.jenkins.svc.cluster.local:8080'),
        ]
    ),
]
)

{
    node(POD_LABEL){
        container('docker') {

        stage('***************** Ckeck prerequest *****************'){
                    sh 'docker -v'
        } 

        stage('***************** Get Dockerfile *****************'){
            git(url: 'git@github.com:voodooq3/jenkins-test.git', branch: "master", credentialsId: 'git')
        }

        stage('***************** Unstash application *****************'){
            unstash 'artifactStash'
            sh 'ls -l'
        }

        stage('***************** Build Dockerfile *****************'){
                    sh 'docker -v'
                    sh 'ls -l'
                    sh 'ls -la /var/run/docker.sock'
                    dockerImage = docker.build("${imageName}", "--no-cache --build-arg APP_NAME=${appName} --build-arg APP_VERSION=${appVersion} .")
                    sh 'docker images'
        }

        stage('***************** Push image *****************') {
                withDockerRegistry(credentialsId: 'DockerHubCred', url: 'https://index.docker.io/v1/'){  
                    sh "docker push ${imageName}:latest"
                }
        }
      }
    }
}  

/* ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼#
# ######################## The End ########################
# #▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲*/


