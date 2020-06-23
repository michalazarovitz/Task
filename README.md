### Demo Repo

#### This repo contains 3 Elements
1. At root level spring-boot serving-web-content project ( [tutorial](https://spring.io/guides/gs/serving-web-content/) ) 
    - Maven project - build using `mvn clean package`
    - Dockerfile - Packing this project in Image  
    - Jenkinsfile - CI/CD for this project  

2. deployment folder 
    - containing playbook and 2 roles to deploy the docker image to a server

3. Jenkins-Master folder
    - Jenkins master configurations files and playbooks to spin up Jenkins Master
    
#### Status
1. Project is building correctly.
2. Image isa also builds correctly and tested locally. 
3. Jenkinsfile was tested in a previous environment which has been compromised

Currently, the original Jenkins master is not safe to run the build 
 
#### Your mission, should  you choose to accept it
1. Create a new Jenkins master
    - Script & playbooks & files could be reused for a different environment
    - You get paid extra for automating plugins and configuration for installation
2. Run the Jenkinsfile 
    - Connect the Jenkins to a git VCS (i.e. github/bitbucket/gitlab)
    - Use webhook for each commit push (no polling) 
    
##### Resources:
***In the Jenkins-Master folder***
* jkey - the key for servers
* ips - list of ips to use with the key one for Jenkins and one for deployment
* ports - only ssh and 8080 are open 


#### The environment will self-destruct at ... 
<<<<<<< HEAD
# Task
=======
=======
# Task
>>>>>>> 8d7e952087392e32eaec5ac083df2f7f663839fb
>>>>>>> ff3cea7a2b85a02a26850730b427c20f4e657e19
