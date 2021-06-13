%dw 2.0
output application/json

var fn = (v) -> v > 5
---
{
    call1: 1 to 10 filter $ > 5,
    call2: 1 to 10 filter fn($)
}
