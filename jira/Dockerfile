ARG JIRA_VERSION

FROM atlassian/jira-software:${JIRA_VERSION}

ENV TZ=Asia/Shanghai
ENV LANG=zh_CN.UTF-8
ENV LANGUAGE=zh_CN:zh
ENV LC_ALL=zh_CN.UTF-8

LABEL maintainer="不就订个外卖么<yeclimeric@gmail.com>"
LABEL version="${JIRA_VERSION}"
LABEL description="atlassian jira 破解版"

ENV START_SCRIPT=${JIRA_INSTALL_DIR}/bin/start-jira.sh
ENV PLUGIN_DIR=${JIRA_INSTALL_DIR}/atlassian-jira/WEB-INF/atlassian-bundled-plugins
ENV LIB_DIR=${JIRA_INSTALL_DIR}/atlassian-jira/WEB-INF/lib

# 注入破解包
COPY utils/crack/atlassian-agent.jar /opt/crack/atlassian-agent.jar
# 注入可联网的应用市场插件包
# COPY utils/lib/atlassian-universal-plugin-manager-plugin-6.0.8.jar ${PLUGIN_DIR}/
# 删除默认插件包
# RUN rm -f ${PLUGIN_DIR}/atlassian-universal-plugin-manager-plugin-6.3.10.jar

# 验证拷贝成功，删除成功
# RUN echo "=== 验证插件目录,看到atlassian-universal-plugin-manager-plugin-6.0.8.jar插件包表示成功 ===" \
#     && ls -l ${PLUGIN_DIR} | grep "universal-plugin-manager"

# 删除默认插件包
# RUN rm -f ${LIB_DIR}/commons-codec-*.jar
# COPY jira/crack/commons-codec-1.9.jar ${LIB_DIR}
# 验证拷贝成功，删除成功
# RUN echo "=== 验证lib目录,看到common-codec-1.9.jar插件包表示成功 ===" \
#     && ls -l ${LIB_DIR} | grep "commons-codec"

RUN sed -i '2i export ATLASSIAN_DIR="${JIRA_INSTALL_DIR}/atlassian-jira/WEB-INF/lib"' ${START_SCRIPT}

# 验证写入结果（必加，确认是否成功）
RUN echo "=== 验证Start Script脚本第2行,看到ATLASSIAN_DIR变量定义表示成功 ===" \
    && head -3 ${START_SCRIPT}

# 注入 mysql 驱动包
COPY mysql/driver/mysql-connector-java-8.0.25.jar /opt/atlassian/jira/atlassian-jira/WEB-INF/lib/mysql-connector-java-8.0.25.jar

# COPY jira/lib/log4j-api-2.17.1.jar /opt/atlassian/jira/atlassian-jira/WEB-INF/lib/log4j-api-2.17.1.jar
# COPY jira/lib/log4j-core-2.17.1.jar /opt/atlassian/jira/atlassian-jira/WEB-INF/lib/log4j-core-2.17.1.jar


# 设置JAVA_OPTS
ENV JAVA_OPTS="-javaagent:/opt/crack/atlassian-agent.jar"
ENV JVM_SUPPORT_RECOMMENDED_ARGS="-Dcom.atlassian.xstream.config.file=atlassian-xstream.xml -Dxstream.security.manager=allow"

# 禁用 UPM 自动更新的核心环境变量
ENV ATL_JVM_SUPPORT_RECOMMENDED_ARGS="-Datlassian.plugins.enable.auto.update=false \
    -Dupm.marketplace.connect=false \
    -Dupm.auto.update.check=false \
    -Dupm.plugin.upload.enabled=true"

CMD ["/opt/atlassian/jira/bin/catalina.sh", "run"]
