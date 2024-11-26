FROM amazoncorretto:17.0.12-alpine3.20

RUN apk update && apk upgrade && \
    apk add --no-cache git bash ncurses curl && \
    curl -fsSL https://fnm.vercel.app/install | bash -c && \
    source ~/.bashrc && \
    npm install --global yarn && \
    git clone https://github.com/unitycatalog/unitycatalog.git && \
    cd /unitycatalog && \
    ./build/sbt package && \
    cd ui/ && \
    yarn install


WORKDIR /unitycatalog

EXPOSE 8080

ENTRYPOINT ["./bin/start-uc-server", "yarn", "start"]