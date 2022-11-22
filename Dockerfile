FROM amazoncorretto:11-alpine-jdk
WORKDIR /home/logicaldoc/
ENV CATALINA_HOME="./tomcat"
RUN apk add \
    curl \    
    unzip \    
    imagemagick \
    ghostscript \
    vim
COPY ./scripts ./scripts
RUN /bin/sh './scripts/setup.sh'
RUN /bin/sh './scripts/modifyapp.sh'
ADD logicaldoc.war ./tomcat/webapps/logicaldoc.war
RUN chmod +x './scripts/cleanup.sh'

CMD /bin/sh './scripts/init.sh'

