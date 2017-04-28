#!/bin/bash
#updating the machine

echo "updating machine..."
yum update -y
yum upgrade -y

echo "installing packages"
yum install wget unzip git java-1.8.0-openjdk-devel -y

echo "checking the version on java"
#checking java has installed
java -version
javac -version

# installing gradle and unzipping it
echo "gradle installing"
cd /opt
wget https://services.gradle.org/distributions/gradle-2.14-bin.zip
unzip gradle-2.14-bin.zip
ln -s gradle-2.14 gradle
cd ..
# Setting environment variables
echo "updating environment variables"
cp /etc/profile /etc/profile_backup
echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | tee -a /etc/profile
echo 'export JRE_HOME=/usr/lib/jvm/jre' | tee -a /etc/profile
echo 'export GRADLE_HOME=/opt/gradle' | tee -a /etc/profile
echo 'export PATH=$PATH:$GRADLE_HOME/bin' | tee -a /etc/profile
source /etc/profile

echo "installing gitlab server key"
# installing gitlab server key
mkdir /root/.ssh
touch /root/.ssh/known_hosts
cat << 'EOF' >> /root/.ssh/known_hosts
gitlab.cs.cf.ac.uk,131.251.168.40 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBDQcOCOPLUQCRGrioWbPcxxCsqGOIj2wbP9MiE14Oc7KeLYbRwBtlHImq4k8f0tgI3qejeSnXl2y3jbFAmnttXY=
EOF
chmod 644 /root/.ssh/known_hosts
echo "installing gitlab repository key for docker WRU project"

#changing the access permissions of file system
chmod 400 /root/Docker_keypair.key

echo "changing to root directory"
#changing to the root directory
cd root

echo "cloning repository"
#cloning the project from got
echo -e "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
ssh-agent bash -c 'ssh-add /root/Docker_keypair.key; git clone git@gitlab.cs.cf.ac.uk:c1526449/docker_WRU.git'

echo "Changing directory to docker_WRU"
#changing to wru-project
cd docker_WRU

ls

echo "Gradle build"
#building the build.gradle file
gradle build

