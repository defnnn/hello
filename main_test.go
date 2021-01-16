package main

import (
	"context"
	"testing"

	"github.com/apex/gateway/v2"
	"github.com/tj/assert"
)

func TestPetsLuna(t *testing.T) {
	e := []byte(`{"version": "2.0", "rawPath": "/pets/luna", "requestContext": {"http": {"method": "POST"}}}`)

	gw := gateway.NewGateway(routing())

	payload, err := gw.Invoke(context.Background(), e)

	assert.NoError(t, err)
	assert.JSONEq(t, `{"body":"hello /pets/luna", "cookies": null, "headers":{"Content-Type":"text/plain; charset=utf8"}, "multiValueHeaders":{}, "statusCode":200}`, string(payload))
}
