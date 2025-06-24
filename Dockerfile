FROM golang:1.22 as builder

WORKDIR /app

# Clone và build wireproxy
RUN git clone https://github.com/whyvl/wireproxy.git . && \
    go build -o wireproxy .

FROM alpine:latest

WORKDIR /app

# Thêm các tiện ích cần thiết
RUN apk add --no-cache ca-certificates

# Copy file binary từ stage build sang
COPY --from=builder /app/wireproxy /usr/local/bin/wireproxy

# Copy file config sau bằng volume hoặc bind
CMD ["wireproxy", "-c", "/app/config.conf"]
