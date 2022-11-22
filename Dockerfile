FROM openjdk:11-jdk

ENV CATALINA_HOME="/logicaldoc/tomcat"

COPY scripts/. logicaldoc/scripts/.

ADD context.properties /logicaldoc/conf/context.properties
ADD logicaldoc.war /logicaldoc/tomcat/webapps/ROOT.war

CMD ["catalina.sh","run"]

EXPOSE 8080
