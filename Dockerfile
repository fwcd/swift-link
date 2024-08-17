FROM swift:5.10 AS builder

RUN apt-get update -y && apt-get install -y libasio-dev

WORKDIR /opt/swift-link
COPY Sources Sources
COPY Snippets Snippets
COPY Package.swift LICENSE .
RUN swift build -c release

FROM swift:5.10-slim

RUN apt-get update -y && apt-get install -y libatomic1

COPY --from=builder /opt/swift-link/.build/release/LinkHut /usr/local/bin/swift-link-hut

ENTRYPOINT ["/usr/local/bin/swift-link-hut"]
