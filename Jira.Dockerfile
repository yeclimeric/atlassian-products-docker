FROM atlassian/jira-software:8.19.1

ENV TZ=Asia/Shanghai

LABEL maintainer="不就订个外卖么<yeclimeric@gmail.com>"
LABEL version="0.8.19"
LABEL description="atlassian jira 破解版"

# 注入破解包
COPY ./utils/crack/atlassian-agent.jar /opt/crack/atlassian-agent.jar
COPY ./utils/crack/atlassian-universal-plugin-manager-plugin-2.22.4.jar /opt/atlassian/jira/atlassian-jira/WEB-INF/atlassian-bundled-plugins/atlassian-universal-plugin-manager-plugin-2.22.4.jar
COPY ./utils/crack/atlassian-extras-3.2.jar /opt/atlassian/jira/atlassian-jira/WEB-INF/lib/atlassian-extras-3.2.jar


# 设置JAVA_OPTS
ENV JAVA_OPTS="-javaagent:/opt/crack/atlassian-agent.jar"

# 注入 mysql 驱动包
COPY ./mysql/driver/mysql-connector-java-8.0.25.jar /opt/atlassian/jira/atlassian-jira/WEB-INF/lib/mysql-connector-java-8.0.25.jar

CMD ["/opt/atlassian/jira/bin/catalina.sh", "run"]
