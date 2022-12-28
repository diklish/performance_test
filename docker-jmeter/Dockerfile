# inspired by https://github.com/hauptmedia/docker-jmeter  and
# https://github.com/hhcordero/docker-jmeter-server/blob/master/Dockerfile
FROM alpine:3.17

MAINTAINER Just van den Broecke<just@justobjects.nl>

ARG JMETER_VERSION="5.4.1"
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV	JMETER_BIN	${JMETER_HOME}/bin
ENV	JMETER_DOWNLOAD_URL  https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz

# Install extra packages
# See https://github.com/gliderlabs/docker-alpine/issues/136#issuecomment-272703023
# Change TimeZone TODO: TZ still is not set!
ARG TZ="IMAGE_TIMEZONE"

#RUN echo "http://dl-4.alpinelinux.org/alpine/v3.4/main" >> /etc/apk/repositories && \
#    echo "http://dl-4.alpinelinux.org/alpine/v3.4/community" >> /etc/apk/repositories

RUN echo http://repository.fit.cvut.cz/mirrors/alpine/v3.17/main > /etc/apk/repositories; \
    echo http://repository.fit.cvut.cz/mirrors/alpine/v3.17/community >> /etc/apk/repositories

#COPY pub/pub /usr/local/share/ca-certificates/my-cert.crt

#RUN cat /usr/local/share/ca-certificates/my-cert.crt >> /etc/ssl/certs/ca-certificates.crt 
#RUN  apk --no-cache add
#RUN  curl

# atk-bridge-2.0

RUN    apk update \
	&& apk upgrade \
	&& apk add ca-certificates \
	&& update-ca-certificates \
	&& apk add --update openjdk11-jre tzdata curl unzip bash cups-libs pango \
	&& rm -rf /var/cache/apk/* \
	&& mkdir -p /tmp/dependencies  \
	&& curl -L --silent ${JMETER_DOWNLOAD_URL} >  /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz  \
	&& mkdir -p /opt  \
	&& tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt  \
	&& rm -rf /tmp/dependencies 

RUN apk update && \
	apk add python3 py-pip curl unzip libexif udev chromium chromium-chromedriver xvfb && \
	pip install selenium && \
	pip install pyvirtualdisplay

# Clean APK cache
RUN rm -rf /var/cache/apk/*

RUN curl -L https://jmeter-plugins.org/get/ > ${JMETER_HOME}/lib/ext/plugins-manager.jar
RUN curl -L http://search.maven.org/remotecontent?filepath=kg/apc/cmdrunner/2.3/cmdrunner-2.3.jar > ${JMETER_HOME}/lib/cmdrunner-2.3.jar
RUN java -cp ${JMETER_HOME}/lib/ext/plugins-manager.jar org.jmeterplugins.repository.PluginManagerCMDInstaller
RUN ${JMETER_HOME}/bin/PluginsManagerCMD.sh install jpgc-autostop,jpgc-casutg,jpgc-csl,jpgc-dummy,jpgc-ffw,jpgc-filterresults,jpgc-functions,jpgc-json,jpgc-mergeresults,jpgc-prmctl,jpgc-sense,jpgc-tst,jpgc-wsc

RUN curl -L http://search.maven.org/remotecontent?filepath=net/sf/json-lib/json-lib/2.4/json-lib-2.4-jdk15.jar > ${JMETER_HOME}/lib/ext/json-lib-2.4-jdk15.jar \
    && curl -L https://search.maven.org/remotecontent?filepath=kg/apc/jmeter-plugins-cmn-jmeter/0.6/jmeter-plugins-cmn-jmeter-0.6.jar > ${JMETER_HOME}/lib/ext/jmeter-plugins-cmn-jmeter-0.6.jar \
    && curl -L http://search.maven.org/remotecontent?filepath=org/yaml/snakeyaml/1.21/snakeyaml-1.21.jar > ${JMETER_HOME}/lib/ext/snakeyaml-1.21.jar \
    && curl -L http://search.maven.org/remotecontent?filepath=kg/apc/jmeter-plugins-json/2.7/jmeter-plugins-json-2.7.jar > ${JMETER_HOME}/lib/ext/jmeter-plugins-json-2.7.jar \
    && curl -L https://search.maven.org/remotecontent?filepath=kg/apc/jmeter-plugins-prmctl/0.4/jmeter-plugins-prmctl-0.4.jar > ${JMETER_HOME}/lib/ext/jmeter-plugins-prmctl-0.4.jar \
    && curl -L https://search.maven.org/remotecontent?filepath=com/blazemeter/jmeter-plugins-senseuploader/3.5/jmeter-plugins-senseuploader-3.5.jar > ${JMETER_HOME}/lib/ext/jmeter-plugins-senseuploader-3.5.jar \
    && curl -L https://search.maven.org/remotecontent?filepath=kg/apc/jmeter-plugins-autostop/0.1/jmeter-plugins-autostop-0.1.jar > ${JMETER_HOME}/lib/ext/jmeter-plugins-autostop-0.1.jar \
    && curl -L https://search.maven.org/remotecontent?filepath=kg/apc/jmeter-plugins-tst/2.5/jmeter-plugins-tst-2.5.jar > ${JMETER_HOME}/lib/ext/jmeter-plugins-tst-2.5.jar \
    && curl -L https://search.maven.org/remotecontent?filepath=kg/apc/jmeter-plugins-functions/2.1/jmeter-plugins-functions-2.1.jar > ${JMETER_HOME}/lib/ext/jmeter-plugins-functions-2.1.jar \
    && curl -L https://search.maven.org/remotecontent?filepath=kg/apc/jmeter-plugins-ffw/2.0/jmeter-plugins-ffw-2.0.jar > ${JMETER_HOME}/lib/ext/jmeter-plugins-ffw-2.0.jar \
    && curl -L https://search.maven.org/remotecontent?filepath=kg/apc/jmeter-plugins-csl/0.1/jmeter-plugins-csl-0.1.jar > ${JMETER_HOME}/lib/ext/jmeter-plugins-csl-0.1.jar \
    && curl -L https://search.maven.org/remotecontent?filepath=kg/apc/jmeter-plugins-filterresults/2.2/jmeter-plugins-filterresults-2.2.jar > ${JMETER_HOME}/lib/ext/jmeter-plugins-filterresults-2.2.jar \
    && curl -L https://search.maven.org/remotecontent?filepath=com/blazemeter/jmeter-plugins-wsc/0.7/jmeter-plugins-wsc-0.7.jar > ${JMETER_HOME}/lib/ext/jmeter-plugins-wsc-0.7.jar \
    && curl -L https://search.maven.org/remotecontent?filepath=kg/apc/jmeter-plugins-mergeresults/2.1/jmeter-plugins-mergeresults-2.1.jar > ${JMETER_HOME}/lib/ext/jmeter-plugins-mergeresults-2.1.jar \
    && curl -L https://search.maven.org/remotecontent?filepath=kg/apc/jmeter-plugins-casutg/2.6/jmeter-plugins-casutg-2.6.jar > ${JMETER_HOME}/lib/ext/jmeter-plugins-casutg-2.6.jar \
    && curl -L https://search.maven.org/remotecontent?filepath=kg/apc/jmeter-plugins-dummy/0.2/jmeter-plugins-dummy-0.2.jar > ${JMETER_HOME}/lib/ext/jmeter-plugins-dummy-0.2.jar \
    && curl -L https://search.maven.org/remotecontent?filepath=kg/apc/jmeter-plugins-manager/1.7/jmeter-plugins-manager-1.7.jar  > ${JMETER_HOME}/lib/ext/jmeter-plugins-manager-1.7.jar \
    && curl -L https://search.maven.org/remotecontent?filepath=kg/apc/jmeter-plugins-webdriver/3.3/jmeter-plugins-webdriver-3.3.jar > ${JMETER_HOME}/lib/ext/jmeter-plugins-webdriver-3.3.jar


# TODO: plugins (later)
# && unzip -oq "/tmp/dependencies/JMeterPlugins-*.zip" -d $JMETER_HOME

# Set global PATH such that "jmeter" command is found
ENV PATH $PATH:$JMETER_BIN

# Entrypoint has same signature as "jmeter" command
COPY entrypoint.sh /

#COPY raaacClient-jar-with-dependencies.jar ${JMETER_HOME}/lib/ext/raaacClient-jar-with-dependencies.jar
COPY lib/byte-buddy-1.8.15.jar ${JMETER_HOME}/lib/byte-buddy-1.8.15.jar
COPY lib/commons-exec-1.3.jar ${JMETER_HOME}/lib/commons-exec-1.3.jar
COPY lib/guava-25.0-jre.jar ${JMETER_HOME}/lib/guava-25.0-jre.jar
COPY lib/htmlunit-2.32.jar ${JMETER_HOME}/lib/htmlunit-2.32.jar
COPY lib/htmlunit-core-js-2.32.jar ${JMETER_HOME}/lib/htmlunit-core-js-2.32.jar
COPY lib/htmlunit-cssparser-1.2.0.jar ${JMETER_HOME}/lib/htmlunit-cssparser-1.2.0.jar
COPY lib/htmlunit-driver-2.33.0.jar ${JMETER_HOME}/lib/htmlunit-driver-2.33.0.jar
COPY lib/jmeter-plugins-cmn-jmeter-0.4.jar ${JMETER_HOME}/lib/jmeter-plugins-cmn-jmeter-0.4.jar
COPY lib/jsyntaxpane-1.0.0.jar ${JMETER_HOME}/lib/jsyntaxpane-1.0.0.jar
COPY lib/neko-htmlunit-2.32.jar ${JMETER_HOME}/lib/neko-htmlunit-2.32.jar
COPY lib/okhttp-3.10.0.jar ${JMETER_HOME}/lib/okhttp-3.10.0.jar
COPY lib/okio-1.14.1.jar ${JMETER_HOME}/lib/okio-1.14.1.jar
COPY lib/phantomjsdriver-1.4.4.jar ${JMETER_HOME}/lib/phantomjsdriver-1.4.4.jar
COPY lib/selenium-api-3.14.0.jar ${JMETER_HOME}/lib/selenium-api-3.14.0.jar
COPY lib/selenium-chrome-driver-3.14.0.jar ${JMETER_HOME}/lib/selenium-chrome-driver-3.14.0.jar
COPY lib/selenium-firefox-driver-3.14.0.jar ${JMETER_HOME}/lib/selenium-firefox-driver-3.14.0.jar
COPY lib/selenium-ie-driver-3.14.0.jar ${JMETER_HOME}/lib/selenium-ie-driver-3.14.0.jar
COPY lib/selenium-java-3.14.0.jar ${JMETER_HOME}/lib/selenium-java-3.14.0.jar
COPY lib/selenium-remote-driver-3.14.0.jar ${JMETER_HOME}/lib/selenium-remote-driver-3.14.0.jar
COPY lib/selenium-support-3.14.0.jar		 ${JMETER_HOME}/lib/selenium-support-3.14.0.jar
COPY lib/ext/jmeter-plugins-autostop-0.1.jar		 ${JMETER_HOME}/lib/ext/jmeter-plugins-autostop-0.1.jar
COPY lib/chromedriver ${JMETER_HOME}/lib/chromedriver
COPY lib/ojdbc10.jar ${JMETER_HOME}/lib/ojdbc10.jar
COPY lib/ext/json2svg-1.0-SNAPSHOT.jar ${JMETER_HOME}/lib/ext/json2svg-1.0-SNAPSHOT.jar


RUN chmod 777 ${JMETER_HOME}/lib/chromedriver

WORKDIR	${JMETER_HOME}

ENTRYPOINT ["/entrypoint.sh"]
