package main

import (
    "fmt"
    "rsc.io/quote"
    "example/user/hello/morestrings"
)

func main(){
    fmt.Println(quote.Hello)
    fmt.Println(process())
}

func process() string {
    return morestrings.ReverseRunes("!oG ,olleH")
}
