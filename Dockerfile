# # desired Caddy version
# ARG VERSION

# #########
# # image #
# FROM caddy:${VERSION}-alpine
# COPY --from=builder /usr/bin/caddy /usr/bin/caddy

###########
# builder #
FROM golang:1.19.2-alpine as builder

RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@v0.3.1
RUN xcaddy build v2.6.1 \
  --with github.com/caddy-dns/cloudflare \
  --with github.com/corazawaf/coraza-caddy

#########
# image #
FROM alpine:3
COPY --from=builder /go/caddy /usr/bin/caddy