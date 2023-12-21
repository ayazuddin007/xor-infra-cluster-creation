#!/bin/bash

java -version &>/dev/null


if [ $? -eq 0 ]; then
    echo SUCCESS for java

    # javac
    javac -version &>/dev/null
    if [ $? -eq 0 ]; then
       echo SUCCESS for javac

       # maven
       mvn -version &>/dev/null
       if [ $? -eq 0 ]; then
          echo SUCCESS for maven

          #Jfrog
          jfrog c show &>/dev/null
          if [ $? -eq 0 ]; then
             echo SUCCESS for jfrog

             #docker
             docker --version &>/dev/null
             if [ $? -eq 0 ]; then
                echo SUCCESS for docker

                #Ansible Repo presence with proper checkout branch
                ls /home/ec2-user/artifact_ansible_script &>/dev/null
                if [ $? -eq 0 ]; then
                   echo SUCCESS for ansible repo clone

                   # Master Slave Connection in jenkins-slave directory i.e. /home/ec2-user/jenkins_slave/
                   ls /home/ec2-user/jenkins_slave/ &>/dev/null
                   if [ $? -eq 0 ]; then
                      echo SUCCESS for master slave connection

                      #Setting.xml in  /home/ec2-user/.m2
                      cat /home/ec2-user/.m2/settings.xml &>/dev/null
                      if [ $? -eq 0 ]; then
                         echo SUCCESS for Setting.xml in .m2 folder

                         #Jfrog server creds in settings.xml in /opt/maven/conf
#                          grep -i "xoriant-jenkins" /opt/maven/conf/settings.xml &>/dev/null
#                          if [ $? -eq 0 ]; then
#                             echo SUCCESS for jfrog credentials
#                             touch success_slave.txt


#                          else
#                             echo FAIL for jfrog credentials
#                          fi
                      else
                         echo FAIL for Setting.xml not in .m2 folder
                      fi

                   else
                      echo FAIL for master slave connection
                   fi

                else
                   echo FAIL for ansible repo clone
                fi

             else
                echo FAIL for docker
             fi

          else
             echo FAIL for jfrog
          fi

       else
          echo FAIL for maven
       fi

    else
       echo FAIL for javac
    fi
else
    echo FAIL for java
fi
