FROM golang:1.22 as builder

WORKDIR /app

RUN go install github.com/pufferffish/wireproxy/cmd/wireproxy@latest

FROM alpine:latest

RUN apk add --no-cache ca-certificates

WORKDIR /app

COPY --from=builder /go/bin/wireproxy /usr/local/bin/wireproxy

CMD ["wireproxy", "-c", "/app/config.conf"]
