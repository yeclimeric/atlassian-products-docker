ARG CROWD_VERSION=4.4

FROM atlassian/crowd:${CROWD_VERSION}

ARG CROWD_VERSION
ARG LABEL_MAINTAINER

LABEL maintainer="${LABEL_MAINTAINER}"
LABEL version="${CROWD_VERSION}"
LABEL description="atlassian crowd 友谊版，仅供学习使用，不可用于商业用途"

ENV TZ=Asia/Shanghai

# 注入破解包
COPY utils/crack/atlassian-agent.jar /opt/crack/atlassian-agent.jar
# 注入 mysql 驱动包
COPY mysql/driver/mysql-connector-java-8.0.25.jar /opt/atlassian/crowd/crowd-webapp/WEB-INF/lib/mysql-connector-java-8.0.25.jar

# 设置JAVA_OPTS
ENV JAVA_OPTS="-javaagent:/opt/crack/atlassian-agent.jar -Dcrowd.license.ignore.type.check=true -Datlassian.license.type=server -Djdk.module.illegalAccess=permit"
