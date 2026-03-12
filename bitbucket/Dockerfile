ARG BITBUCKET_VERSION=9.4.18

FROM atlassian/bitbucket:${BITBUCKET_VERSION}

ARG BITBUCKET_VERSION

ENV TZ=Asia/Shanghai

LABEL maintainer="不就订个外卖么<yeclimeric@gmail.com>"
LABEL version="${BITBUCKET_VERSION}"
LABEL description="atlassian bitbucket 破解版"

COPY utils/crack/atlassian-agent.jar /opt/crack/atlassian-agent.jar

COPY bitbucket/bin/_start-webapp.sh /opt/atlassian/bitbucket/bin/_start-webapp.sh
RUN chmod +x /opt/atlassian/bitbucket/bin/_start-webapp.sh
