# Sử dụng một image Ubuntu ổn định làm nền
FROM ubuntu:22.04

# Tránh các câu hỏi tương tác khi cài đặt gói
ENV DEBIAN_FRONTEND=noninteractive

# Cài đặt tất cả các gói cần thiết: wireguard, dante, và supervisor
RUN apt-get update && apt-get install -y \
    wireguard-tools \
    dante-server \
    supervisor \
    curl \
    iproute2 \
    && rm -rf /var/lib/apt/lists/*

# Tạo thư mục cho file config của WireGuard
RUN mkdir -p /etc/wireguard

# Sao chép file cấu hình của dante và supervisor vào trong image
COPY danted.conf /etc/dante/danted.conf
COPY config/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Mở cổng SOCKS5
EXPOSE 1080

# Lệnh để khởi chạy supervisor khi container bắt đầu
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
