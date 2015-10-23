FROM ubuntu:trusty

# Latest GIT and Oracle Java 8

RUN set -x \
	&& apt-get update \
	&& apt-get dist-upgrade \
	&& apt-get install -y software-properties-common \
	&& apt-get install -y curl

RUN set -x \
	&& apt-add-repository -y ppa:git-core/ppa \
	&& apt-add-repository -y ppa:webupd8team/java \
	&& apt-get update

RUN set -x \
	&& apt-get install -y git-core \
	&& echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections \
	&& echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections \
	&& apt-get install -y oracle-java8-installer oracle-java8-set-default

# Maven 3.3.3 Distribution

ENV MAVEN_VERSION 3.3.3

RUN curl -fsSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
	&& mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
	&& ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

CMD ["mvn"]
