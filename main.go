package main

import "fmt"
import "runtime"

func main() {
    fmt.Println("hello world", runtime.GOOS, runtime.GOARCH)
}
