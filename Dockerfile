# Stage 1: Build the Go binary
FROM golang:alpine AS builder

WORKDIR /app


COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o /app/main main.go

RUN go build -o /app main.go

# Stage 2: Criação da imagem mínima
FROM scratch

WORKDIR /app
COPY --from=builder /app/main .

CMD ["./main"]
