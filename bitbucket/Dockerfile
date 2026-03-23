ARG BITBUCKET_VERSION=8.6

FROM atlassian/bitbucket:${BITBUCKET_VERSION}

ARG LABEL_MAINTAINER

LABEL maintainer="${LABEL_MAINTAINER}"
LABEL version="${BITBUCKET_VERSION}"
LABEL description="atlassian bitbucket 友谊版，仅供学习使用，不可用于商业用途"

ARG BITBUCKET_VERSION

ENV TZ=Asia/Shanghai

ENV START_SCRIPT=${BITBUCKET_INSTALL_DIR}/bin/start-bitbucket.sh
ENV WEBAPP_SCRIPT=${BITBUCKET_INSTALL_DIR}/bin/_start-webapp.sh
ENV PLUGIN_DIR=${BITBUCKET_INSTALL_DIR}/app/WEB-INF/atlassian-bundled-plugins/


COPY mysql/driver/mysql-connector-java-8.0.25.jar ${BITBUCKET_INSTALL_DIR}/app/WEB-INF/lib/mysql-connector-java-8.0.25.jar

# ==================== 处理破解相关问题 ====================
COPY utils/crack/atlassian-agent.jar /opt/crack/atlassian-agent.jar

RUN sed -i '2i export ATLASSIAN_DIR="/opt/atlassian/bitbucket/app/WEB-INF/lib"' ${START_SCRIPT}

# 验证写入结果（必加，确认是否成功）
RUN echo "=== 验证Start Script脚本第2行,看到ATLASSIAN_DIR变量定义表示成功 ===" \
    && head -3 ${START_SCRIPT}

RUN chmod +w ${WEBAPP_SCRIPT}
# 逻辑：在脚本中找到JAVA_OPTS定义行，追加agent参数；若未找到则在开头添加
RUN if grep -q "^JAVA_OPTS=" ${WEBAPP_SCRIPT}; then \
    # 已有JAVA_OPTS定义，追加agent参数（用双引号转义，兼容空格）
    sed -i 's/^JAVA_OPTS="/JAVA_OPTS="-javaagent:\/opt\/crack\/atlassian-agent.jar -Dbitbucket.license.ignore.type.check=true -Datlassian.license.type=server -Djdk.module.illegalAccess=permit /' ${WEBAPP_SCRIPT}; \
    else \
    # 无JAVA_OPTS定义，在脚本开头添加
    sed -i '1i JAVA_OPTS="-javaagent:/opt/crack/atlassian-agent.jar -Dbitbucket.license.ignore.type.check=true -Datlassian.license.type=server -Djdk.module.illegalAccess=permit' ${WEBAPP_SCRIPT}; \
    fi

RUN echo "=== 验证 _start-webapp.sh 中的JAVA_OPTS ===" \
    && grep "JAVA_OPTS" ${WEBAPP_SCRIPT} | head -5

# 删除默认插件包
RUN rm -fv ${PLUGIN_DIR}/atlassian-universal-plugin-manager-plugin*

# 注入可联网的应用市场插件包
COPY utils/lib/atlassian-universal-plugin-manager-plugin-6.0.8.jar ${PLUGIN_DIR}/

# 验证拷贝成功，删除成功
RUN echo "=== 验证插件目录,看到atlassian-universal-plugin-manager-plugin-6.0.8.jar插件包表示成功 ===" \
    && ls -l ${PLUGIN_DIR} | grep "universal-plugin-manager"
