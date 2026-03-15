FROM golang:1.26.1-alpine3.23 AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY cmd/ cmd/

RUN CGO_ENABLED=0 go build -o /server ./cmd/server

FROM alpine:3.23

WORKDIR /app

ENV PORT=8080

COPY --from=builder /server /app/server

EXPOSE 8080

ENTRYPOINT ["/app/server"]
