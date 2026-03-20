ARG BAMBOO_VERSION=9.4

FROM atlassian/bamboo:${BAMBOO_VERSION}

ARG LABEL_MAINTAINER

LABEL maintainer="${LABEL_MAINTAINER}"
LABEL version="${BAMBOO_VERSION}"
LABEL description="atlassian bamboo 友谊版，仅供学习使用，不可用于商业用途"

ENV TZ=Asia/Shanghai
ENV PLUGIN_DIR=${BAMBOO_INSTALL_DIR}/atlassian-bamboo/WEB-INF/atlassian-bundled-plugins/

# 注入破解包
COPY utils/crack/atlassian-agent.jar /opt/crack/atlassian-agent.jar
# 注入 mysql 驱动包
# COPY utils/mysql/mysql-connector-j-8.0.33.jar ${BAMBOO_INSTALL_DIR}/atlassian-bamboo/WEB-INF/lib/
COPY utils/mysql/mysql-connector-j-8.0.33.jar ${BAMBOO_INSTALL_DIR}/lib/
# 设置JAVA_OPTS
ENV JAVA_OPTS="-javaagent:/opt/crack/atlassian-agent.jar -Dbamboo.license.ignore.type.check=true -Datlassian.license.type=server -Djdk.module.illegalAccess=permit"

# 删除默认插件包
RUN rm -f ${PLUGIN_DIR}/atlassian-universal-plugin-manager-plugin*

# 注入可联网的应用市场插件包
COPY utils/lib/atlassian-universal-plugin-manager-plugin-6.0.8.jar ${PLUGIN_DIR}/

# 验证拷贝成功，删除成功
RUN echo "=== 验证插件目录,看到atlassian-universal-plugin-manager-plugin-6.0.8.jar插件包表示成功 ===" \
    && ls -l ${PLUGIN_DIR} | grep "universal-plugin-manager"