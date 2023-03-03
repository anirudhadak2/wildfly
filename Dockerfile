FROM docker.io/jboss/base-jdk:7
ADD wildfly-8.0.0.Final.zip /tmp/
RUN unzip /tmp/wildfly-8.0.0.Final.zip -d /opt/jboss

USER root
# Add EAP_HOME environment variable, to easily upgrade the script for different EAP versions
ENV EAP_HOME /opt/jboss/wildfly-8.0.0.Final

# Add default admin user
RUN ${EAP_HOME}/bin/add-user.sh admin admin123! --silent

# Enable binding to all network interfaces and debugging inside the EAP
RUN echo "JAVA_OPTS=\"\$JAVA_OPTS -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0\"" >> ${EAP_HOME}/bin/standalone.conf


EXPOSE 9990 9999 8080 8787

ENTRYPOINT ["/opt/jboss/wildfly-8.0.0.Final/bin/standalone.sh"]
CMD []
