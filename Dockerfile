FROM alpine:3.1
MAINTAINER Sean Bartell <yotann@yotann.org>

WORKDIR /root

RUN apk update && \
    apk add curl libgcc && \
    apk add -t buildonly \
    autoconf automake curl-dev gcc git make musl-dev pkgconfig openssl-dev && \
    rm -rf /var/cache/apk/*

RUN git clone --depth 1 https://github.com/slimcoin/slimminer.git tmp && \
    cd tmp && \
    ./autogen.sh && ./configure && make && \
    cd .. && mv tmp/minerd slimcoin && rm -rf tmp

RUN git clone --depth 1 https://github.com/pooler/cpuminer.git tmp && \
    cd tmp && \
    ./autogen.sh && ./configure && make && \
    cd .. && mv tmp/minerd pooler && rm -rf tmp

RUN git clone --depth 1 https://github.com/cryptozoidberg/cpuminer-multi.git tmp && \
    cd tmp && \
    ./autogen.sh && ./configure && make && \
    cd .. && mv tmp/minerd cryptozoidberg && rm -rf tmp

RUN apk del buildonly

COPY ["run.sh", "./"]

ENTRYPOINT ["./run.sh"]
