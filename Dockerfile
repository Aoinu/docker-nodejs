FROM ubuntu AS builder

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y python2.7 build-essential git

RUN git clone https://github.com/nodejs/node.git

WORKDIR /node

RUN ./configure --fully-static --enable-lto \
  && make -j4
RUN chmod 111 out/Release/node

FROM scratch AS runner

COPY --from=builder /node/out/Release/node /node

ENTRYPOINT ["/node"]

CMD ["--help"]
