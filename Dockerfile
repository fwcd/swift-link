FROM swift:latest

WORKDIR /opt/swift-link
COPY Sources Sources
COPY Package.swift LICENSE .
RUN swift build -c release
