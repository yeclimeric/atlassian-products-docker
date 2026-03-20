ARG JIRA_VERSION
ARG LABEL_MAINTAINER

FROM atlassian/jira-software:${JIRA_VERSION}

ENV TZ=Asia/Shanghai

LABEL maintainer="${LABEL_MAINTAINER}"
LABEL version="${JIRA_VERSION}"
LABEL description="atlassian jira 友谊版，仅供学习使用，不可用于商业用途"

ENV START_SCRIPT=${JIRA_INSTALL_DIR}/bin/start-jira.sh
ENV PLUGIN_DIR=${JIRA_INSTALL_DIR}/atlassian-jira/WEB-INF/atlassian-bundled-plugins
ENV LIB_DIR=${JIRA_INSTALL_DIR}/atlassian-jira/WEB-INF/lib

# 注入破解包
COPY utils/crack/atlassian-agent.jar /opt/crack/atlassian-agent.jar

RUN sed -i '2i export ATLASSIAN_DIR="${JIRA_INSTALL_DIR}/atlassian-jira/WEB-INF/lib"' ${START_SCRIPT}

# 验证写入结果（必加，确认是否成功）
RUN echo "=== 验证Start Script脚本第2行,看到ATLASSIAN_DIR变量定义表示成功 ===" \
    && head -3 ${START_SCRIPT}

# 注入 mysql 驱动包
COPY mysql/driver/mysql-connector-java-8.0.25.jar /opt/atlassian/jira/atlassian-jira/WEB-INF/lib/mysql-connector-java-8.0.25.jar

# 设置JAVA_OPTS
ENV JAVA_OPTS="-javaagent:/opt/crack/atlassian-agent.jar"

ENV CATALINA_OPTS="-Dscheme=https \
    -Dsecure=true \
    -DproxyPort=443"
