FROM golang:alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOAMD64=v3 go build -o server .

FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/server .

EXPOSE 8080
CMD ["./server"]
