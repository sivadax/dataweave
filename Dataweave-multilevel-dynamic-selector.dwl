/*
{
   "mapping": {
      "targetField1": "a.b.sourceField1",
      "targetField2": "a.c.sourceField2"
   }
}

{
   "a": {
      "b": {
         "sourceField1": "sourceValue1"
      },
      "c": {
         "sourceField2": "sourceValue2"
      }
   }
}


{
   "targetField1": "sourceValue1",
   "targetField2": "sourceValue2"
}

*/

%dw 2.0
output application/json

fun getField(payload: Any, field: String) = do {
    var path = field splitBy '.' reduce((pathPart, path=[]) ->
        if (pathPart contains '[') do {
            var pieces = pathPart splitBy '['
            ---
            pieces reduce((piece,subPath=path) -> 
                if (piece contains ']') subPath << (piece replace ']' with '') as Number
                else subPath << piece
            )
        }
        else path << pathPart
    )
    ---
    getField(payload, path)
}

fun getField(payload: Any, field: Array) =
    if (sizeOf(field) == 1) payload[field[0]]
    else getField(payload[field[0]], field[1 to -1])

var inData = { 
    "a" : {
        "b" : {
            "sourceField1": [{ "value": "sourceValue11" }]
        },
        "c" : {
            "sourceField2": "sourceValue2"
        }    
    }
}

var mappingData = { 
    "mapping": {
        "targetField1": "a.b.sourceField1[0].value",
        "targetField2": "a.c.sourceField2"
    } 
}

---
mappingData.mapping mapObject (($$): getField(inData, $))
