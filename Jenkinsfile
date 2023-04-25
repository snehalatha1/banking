pipeline {
  agent any

  tools {
      maven 'M2_HOME'
      terraform 'TERRAFORM_HOME'
        }
environment {
        AWS_ACCESS_KEY = '${ACCESS_KEY}'
        AWS_SECRET_KEY = '${SECRET_KEY}'
        }


  stages {
     stage('checkout'){
       steps {
          git branch: 'main', url: 'https://github.com/snehalatha1/banking.git'
       }
     }
   

     stage('Package'){
        steps {
            
            sh 'mvn clean package'
        }    
     }  
     stage('publish Reports'){
               steps {
               publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/banking/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])    
                    }
            }

     stage('Docker Image Creation'){
          steps {
                 sh 'docker build -t snehalatha15/bankingapplication:latest  .'
                      }
                   }


      stage('Push Image to DockerHub'){
               steps {
                   withCredentials([usernamePassword(credentialsId: 'dh', passwordVariable: 'dhpswd', usernameVariable: 'dhuser')]) {
        	   sh "docker login -u ${env.dhuser} -p ${env.dhpswd}"
                   sh 'docker push snehalatha15/bankingapplication:latest'

	            }
                 }
            }
	     
     stage ('Launchserver with Terraform'){
            steps {
                dir('test'){
                sh 'sudo chmod 600 ./newkeypair.pem'
                sh 'terraform init'
                sh 'terraform validate'
                sh 'terraform apply --auto-approve'
                }
                }
            }
     stage('Deploy app by Ansible'){
         steps{
            ansiblePlaybook credentialsId: 'ans', disableHostKeyChecking: true, installation: 'ansible', inventory: '/etc/ansible/hosts', playbook: 'bank-playbook.yml'
         } 
      }
        }
   }

