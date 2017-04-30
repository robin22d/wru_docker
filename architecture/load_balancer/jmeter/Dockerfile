
FROM		ubuntu:16.04

ENV		JMETER_VERSION apache-jmeter-3.2
ENV		JMETER_HOME /usr/local/$JMETER_VERSION
ENV		JMETER_BIN $JMETER_HOME/bin
ENV		PATH $PATH:$JMETER_BIN
ENV		DATA /root/data

RUN		apt update && \
		apt -y upgrade && \
		apt -y install wget openjdk-8-jre-headless

RUN		wget -q http://mirrors.ukfast.co.uk/sites/ftp.apache.org//jmeter/binaries/$JMETER_VERSION.tgz -P /tmp && \
		tar xvf /tmp/$JMETER_VERSION.tgz -C /usr/local

RUN		mkdir $DATA
ADD		WRUTest.jmx $DATA/WRUTest.jmx

WORKDIR		$DATA

