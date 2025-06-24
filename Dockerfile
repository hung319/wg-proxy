FROM golang:1.22 as builder

WORKDIR /app

# Clone repo và build wireproxy
RUN git clone https://github.com/whyvl/wireproxy.git . && \
    go build -o wireproxy .

FROM alpine:latest

WORKDIR /app
COPY --from=builder /app/wireproxy /usr/local/bin/wireproxy

# Copy file config vào container sau
CMD ["wireproxy", "-c", "/app/config.conf"]
