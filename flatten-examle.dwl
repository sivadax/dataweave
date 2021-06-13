/*
[{
    "omsNo": "S001",
    "recipient": [{
            "name": "name1",
            "address": "address1"
        },
        {
            "name": "name2",
            "address": "address2"
        }
    ]
}]

[{"omsNo":"S001","name":"name1","address":"address1"},{"omsNo":"S001","name":"name2","address":"address2"}]

*/

%dw 2.0
output application/json
---
flatten(payload map ((item, index) -> 
   (item.recipient map ((itemRecipient, indexRecipient)  -> (
        ({omsNo: item.omsNo} ++ itemRecipient) 
   ))
)))

///////////////////////////////////////

%dw 2.0
output application/json
---
payload.recipient[0] map (v0,k0) ->
{
    omsNo:payload.omsNo[0],
    name:v0.name,
    address:v0.address
}
