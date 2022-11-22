FROM openjdk:11-jdk

ENV CATALINA_HOME="/logicaldoc/tomcat"

COPY scripts/. logicaldoc/scripts/.
RUN sh scripts/setup.sh
RUN sh scripts/modifyapp.sh

ADD context.properties /logicaldoc/conf/context.properties
ADD logicaldoc.war /logicaldoc/tomcat/webapps/ROOT.war

CMD ["catalina.sh","run"]

EXPOSE 8080

RUN sh scripts/cleanup.sh