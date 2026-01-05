FROM debian:13

ARG USER_ID=1000
ARG GROUP_ID=1000
ARG USER_NAME=codex
ARG NODE_VERSION=24.12.0

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl xz-utils git ripgrep \
        && rm -rf /var/lib/apt/lists/*

RUN groupadd --gid ${GROUP_ID} ${USER_NAME} \
        && useradd --uid ${USER_ID} --gid ${GROUP_ID} --create-home ${USER_NAME}

WORKDIR /home/${USER_NAME}

RUN curl -O https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz \
        && tar xf node-v${NODE_VERSION}-linux-x64.tar.xz \
        && mv node-v${NODE_VERSION}-linux-x64 node \
        && rm node-v${NODE_VERSION}-linux-x64.tar.xz

RUN chown -R ${USER_ID}:${GROUP_ID} node

ENV PATH="/home/${USER_NAME}/node/bin:${PATH}"

USER ${USER_NAME}

RUN npm install -g @openai/codex
