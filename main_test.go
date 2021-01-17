package main

import (
	"context"
	"testing"

	"github.com/apex/gateway/v2"
	"github.com/tj/assert"
)

func TestRoot(t *testing.T) {
	e := []byte(`{"version": "2.0", "rawPath": "/", "requestContext": {"http": {"method": "GET"}}}`)

	gw := gateway.NewGateway(routing())

	payload, err := gw.Invoke(context.Background(), e)

	assert.NoError(t, err)
	assert.JSONEq(t, `{"body":"Hello World!", "cookies": null, "headers":{"Content-Type":"text/plain; charset=utf8"}, "multiValueHeaders":{}, "statusCode":200}`, string(payload))
}

func TestPets(t *testing.T) {
	e := []byte(`{"version": "2.0", "rawPath": "/pets/luna", "requestContext": {"http": {"method": "POST"}}}`)

	gw := gateway.NewGateway(routing())

	payload, err := gw.Invoke(context.Background(), e)

	assert.NoError(t, err)
	assert.JSONEq(t, `{"body":"Hello luna", "cookies": null, "headers":{"Content-Type":"text/plain; charset=utf8"}, "multiValueHeaders":{}, "statusCode":200}`, string(payload))
}

func TestNotFound(t *testing.T) {
	e := []byte(`{"version": "2.0", "rawPath": "/goodbye", "requestContext": {"http": {"method": "POST"}}}`)

	gw := gateway.NewGateway(routing())

	payload, err := gw.Invoke(context.Background(), e)

	assert.NoError(t, err)
	assert.JSONEq(t, `{"body":"Not found: [/goodbye]", "cookies": null, "headers":{"Content-Type":"text/plain; charset=utf8"}, "multiValueHeaders":{}, "statusCode":200}`, string(payload))
}
