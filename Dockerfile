FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -o /main .
FROM alpine:latest
WORKDIR /app
COPY --from=builder /main .
EXPOSE 8080
CMD ["./main"]