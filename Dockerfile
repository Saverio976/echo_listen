FROM debian:12-slim as builder
RUN apt-get update -y \
    && apt-get install -y \
        gcc \
        make \
        libatomic1 \
        git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/vlang/v.git /vlang
RUN make -C /vlang
COPY . /app
RUN make -C /app V=/vlang/v

FROM debian:12-slim
COPY --from=builder /app/echo_listen /app/echo_listen
ARG ECHOLISTEN_HISTORY_ROUTE=/tmp/echolisten_history_route
ENV ECHOLISTEN_HISTORY_ROUTE=${ECHOLISTEN_HISTORY_ROUTE}
CMD [ "/app/echo_listen" ]
