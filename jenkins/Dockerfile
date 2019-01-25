# Dockerfile for a Jenkins image with ansible
# I need to start from an Ubuntu container otherwise ppa archives don't work

FROM ubuntu:18.04
EXPOSE 8080

# Install basic packages
RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils \
    apt-transport-https mlocate gnupg wget software-properties-common \
    curl vim git maven jq

# Install Java
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-8-jdk

# Install Tomcat
WORKDIR /usr/local
RUN wget -q -O tomcat.tgz http://mirror.ox.ac.uk/sites/rsync.apache.org/tomcat/tomcat-9/v9.0.14/bin/apache-tomcat-9.0.14.tar.gz
RUN tar xfvz tomcat.tgz
RUN mv apache-tomcat-* tomcat

# Install ansible
RUN apt-add-repository -y ppa:ansible/ansible
RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ansible

# Install AWS command line tools & python's boto & boto3 AWS SDKs
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
RUN python get-pip.py
RUN pip install awscli
RUN pip install boto
RUN pip install boto3

# Install Jenkins
RUN wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
RUN echo deb https://pkg.jenkins.io/debian-stable binary/ >> /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install jenkins

# Install the Jenkins JAR as a root JAR
RUN rm -rf /usr/local/tomcat/webapps/ROOT/
RUN cp /usr/share/jenkins/jenkins.war /usr/local/tomcat/webapps/ROOT.war

# Update file list to be able to use locate command
RUN updatedb

# 
RUN chown -R jenkins.jenkins /usr/local/tomcat
USER jenkins

# Install gcloud command line tool
RUN curl https://sdk.cloud.google.com | bash

VOLUME ["/var/lib/jenkins/"]
WORKDIR /var/libs/jenkins
ENV CATALINA_OPTS='-DJENKINS_HOME=/var/lib/jenkins/ -Xmx512m'
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
