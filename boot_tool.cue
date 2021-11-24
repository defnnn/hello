package boot

import (
	"github.com/defn/boot"
)

cfg: {...} | *{}

command: boot.#Plugins & {
	"cfg": cfg
}