FROM debian:13


RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl xz-utils git ripgrep python3 \
        && rm -rf /var/lib/apt/lists/*

ARG USER_ID=1000
ARG GROUP_ID=1000
ARG USER_NAME=codex
RUN groupadd --gid ${GROUP_ID} ${USER_NAME} \
        && useradd --uid ${USER_ID} --gid ${GROUP_ID} --create-home ${USER_NAME}

WORKDIR /home/${USER_NAME}

ARG NODE_VERSION=24.12.0
RUN curl -O https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz \
        && tar xf node-v${NODE_VERSION}-linux-x64.tar.xz \
        && mv node-v${NODE_VERSION}-linux-x64 node \
        && rm node-v${NODE_VERSION}-linux-x64.tar.xz

RUN chown -R ${USER_ID}:${GROUP_ID} node

ENV PATH="/home/${USER_NAME}/node/bin:${PATH}"
RUN echo 'PATH="$HOME/node/bin:${PATH}"' >> .profile

USER ${USER_NAME}

ARG CODEX_VERSION=0.85.0
RUN npm install -g @openai/codex@${CODEX_VERSION}
