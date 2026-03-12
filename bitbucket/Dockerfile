ARG BITBUCKET_VERSION=9.4.18

FROM atlassian/bitbucket:${BITBUCKET_VERSION}

ARG BITBUCKET_VERSION

ENV TZ=Asia/Shanghai

LABEL maintainer="不就订个外卖么<yeclimeric@gmail.com>"
LABEL version="${BITBUCKET_VERSION}"
LABEL description="atlassian bitbucket 破解版"

COPY mysql/driver/mysql-connector-java-8.0.25.jar /opt/atlassian/bitbucket/WEB-INF/lib/mysql-connector-java-8.0.25.jar

COPY utils/crack/atlassian-agent.jar /opt/crack/atlassian-agent.jar

COPY bitbucket/bin/_start-webapp.sh /opt/atlassian/bitbucket/bin/_start-webapp.sh
COPY bitbucket/bin/start-bitbucket.sh /opt/atlassian/bitbucket/bin/start-bitbucket.sh

RUN chmod +x /opt/atlassian/bitbucket/bin/_start-webapp.sh
RUN chmod +x /opt/atlassian/bitbucket/bin/start-bitbucket.sh
