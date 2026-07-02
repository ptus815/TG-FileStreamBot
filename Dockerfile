FROM golang:1.25-alpine3.21 AS builder

WORKDIR /app
COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -o fsb ./cmd/fsb

FROM alpine:3.19

RUN apk add --no-cache ca-certificates

WORKDIR /app
COPY --from=builder /app/fsb .

ENV PORT=7860
EXPOSE 7860

CMD ["./fsb", "run"]