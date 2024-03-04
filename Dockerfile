FROM golang:1.22 as builder

WORKDIR /app

COPY go.* ./
RUN go mod download

COPY . ./

RUN CGO_ENABLED=0 GOOS=linux go build -v -o server

FROM debian:buster-slim
WORKDIR /root/

COPY --from=builder /app/server .

CMD ["./server"]
