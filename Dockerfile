FROM golang:1.22 as builder

WORKDIR /app

# Cài đặt wireproxy từ fork pufferffish bằng go install
RUN go install github.com/pufferffish/wireproxy/cmd/wireproxy@latest

FROM alpine:latest

RUN apk add --no-cache ca-certificates libc6-compat

WORKDIR /app

# Copy từ GOPATH/bin của builder sang container production
COPY --from=builder /go/bin/wireproxy /usr/local/bin/wireproxy

CMD ["/usr/local/bin/wireproxy", "-c", "/app/config.conf"]
