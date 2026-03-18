ARG BAMBOO_VERSION=9.4

FROM atlassian/bamboo-server:${BAMBOO_VERSION}

ARG BAMBOO_VERSION
ARG LABEL_MAINTAINER
ARG LABEL_DESCRIPTION

LABEL maintainer="${LABEL_MAINTAINER}"
LABEL version="${BAMBOO_VERSION}"
LABEL description="${LABEL_DESCRIPTION}"

ENV TZ=Asia/Shanghai

# 注入破解包
COPY utils/crack/atlassian-agent.jar /opt/crack/atlassian-agent.jar
# 注入 mysql 驱动包
# COPY utils/mysql/mysql-connector-j-8.0.33.jar ${BAMBOO_INSTALL_DIR}/lib/

# 设置JAVA_OPTS
ENV JAVA_OPTS="-javaagent:/opt/crack/atlassian-agent.jar -Dbamboo.license.ignore.type.check=true -Datlassian.license.type=server -Djdk.module.illegalAccess=permit"
