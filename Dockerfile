FROM jenkins/jenkins:latest
MAINTAINER McKessonQA <Praveen.Tata@McKesson.com>

#COPY apt.conf /etc/apt/

USER root

#Make sure the package repository is up to date.
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y git
	
# Install JDK
RUN apt-get install -y openjdk-8-jdk

# Install Maven
RUN apt-get install -y maven

# Standard SSH Port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

RUN curl -fsSL get.docker.com | sh
RUN usermod -aG docker jenkins

COPY ./jenkins_docker.sh /jenkins_docker.sh

USER jenkins

ENTRYPOINT ["/sbin/tini", "--", "/jenkins_docker.sh"]
