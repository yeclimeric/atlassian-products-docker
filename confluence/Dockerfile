ARG CONFLUENCE_VERSION=8.5

FROM atlassian/confluence:${CONFLUENCE_VERSION}

ARG MAINTAINER
ARG CONFLUENCE_VERSION

LABEL maintainer="${MAINTAINER}"
LABEL version="${CONFLUENCE_VERSION}"
LABEL description="atlassian confluence 破解版"

ENV TZ=Asia/Shanghai

ENV START_SCRIPT=${CONFLUENCE_INSTALL_DIR}/bin/start-confluence.sh
ENV ENV_SCRIPT=${CONFLUENCE_INSTALL_DIR}/bin/setenv.sh
ENV PLUGIN_DIR=${CONFLUENCE_INSTALL_DIR}/confluence/WEB-INF/atlassian-bundled-plugins/

# 注入破解包
COPY utils/crack/atlassian-agent.jar /opt/crack/atlassian-agent.jar
# 注入 mysql 驱动包
COPY mysql/driver/mysql-connector-java-8.0.25.jar ${CONFLUENCE_INSTALL_DIR}/confluence/WEB-INF/lib/
# 注入可联网的应用市场插件包
COPY utils/lib/atlassian-universal-plugin-manager-plugin-6.0.8.jar ${PLUGIN_DIR}/

# 删除默认插件包
RUN rm -f ${PLUGIN_DIR}/com.atlassian.upm.atlassian-universal-plugin-manager-plugin-6.1.19.jar

# 验证拷贝成功，删除成功
RUN echo "=== 验证插件目录,看到atlassian-universal-plugin-manager-plugin-6.0.8.jar插件包表示成功 ===" \
    && ls -l ${PLUGIN_DIR} | grep "universal-plugin-manager"

RUN sed -i '2i export ATLASSIAN_DIR="${CONFLUENCE_INSTALL_DIR}/confluence/WEB-INF/lib"' ${START_SCRIPT}

# 验证写入结果（必加，确认是否成功）
RUN echo "=== 验证Start Script脚本第2行,看到ATLASSIAN_DIR变量定义表示成功 ===" \
    && head -3 ${START_SCRIPT}

RUN sed -i '2i CATALINA_OPTS="-Dupm.pac.disable=true ${CATALINA_OPTS}"' ${ENV_SCRIPT}

# 验证写入结果（必加，确认是否成功）
RUN echo "=== 验证setenv.sh脚本第2行,看到CATALINA_OPTS变量定义表示成功 ===" \
    && head -3 ${ENV_SCRIPT}



# 设置JAVA_OPTS
ENV JAVA_OPTS="-javaagent:/opt/crack/atlassian-agent.jar"
