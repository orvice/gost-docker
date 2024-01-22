FROM golang:1.21 as builder

WORKDIR /app
RUN git clone https://github.com/go-gost/gost.git
WORKDIR /app/gost
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/bin/gost ./cmd/gost


FROM quay.io/orvice/go-runtime:latest

COPY --from=builder /app/bin/gost /usr/local/bin/gost

ENTRYPOINT ["/usr/local/bin/gost"]