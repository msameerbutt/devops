package main

import (
    "fmt"
    "rsc.io/quote"
    "example/user/hello/morestrings"
    "github.com/google/go-cmp/cmp"
)

func main(){
    fmt.Println(quote.Hello())
    fmt.Println(process())
    fmt.Println(cmp.Diff("Hello World", "Hello Go"))
}

func process() string {
    return morestrings.ReverseRunes("!oG ,olleH")
}
