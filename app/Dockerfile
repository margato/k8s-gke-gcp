FROM golang:1.19.3-alpine

RUN apk update && apk --no-cache add curl

WORKDIR /app

COPY . .

RUN go get -d -v ./...
RUN go build -ldflags "-s -w"

ENV PORT 8080
ENV GIN_MODE release
EXPOSE 8080

ENTRYPOINT ["./go-api-helloworld"]