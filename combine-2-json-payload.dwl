/*
[
  {
    "CustomerID": "123",
    "Name": "Maria",
    "Phone": "030-0074321"
    
  },
  {
    "CustomerID": "56654",
    "Name": "sdf",
    "Phone": "030-6877452"
    
  }
]

[
    {
      "OrderID": "10643",
      "CustomerID": "123",
      "Price": "200"
    },
    {
      "OrderID": "10692",
      "CustomerID": "123",
      "Price": "566"
    },
    {
      "OrderID": "10702",
      "CustomerID": "56654",
      "Price": "546"
    }
  ]

[
   {
      "CustomerID":"123",
      "Name":"Maria",
      "Phone":"030-0074321",
      "Details":[
         {
            "OrderID":"10643",
            "Price":"200"
         },
         {
            "OrderID":"10692",
            "Price":"566"
         }
      ]
   },
   {
      "CustomerID":"56654",
      "Name":"sdf",
      "Phone":"030-6877452",
      "Details":[
         {
            "OrderID":"10702",
            "Price":"546"
         }
      ]
   }
]

*/

%dw 2.0
output application/dw

var input1 = [
  {
    "CustomerID": "123",
    "Name": "Maria",
    "Phone": "030-0074321"
    
  },
  {
    "CustomerID": "56654",
    "Name": "sdf",
    "Phone": "030-6877452"
    
  }
]

var input2 = [
    {
      "OrderID": "10643",
      "CustomerID": "123",
      "Price": "200"
    },
    {
      "OrderID": "10692",
      "CustomerID": "123",
      "Price": "566"
    },
    {
      "OrderID": "10702",
      "CustomerID": "56654",
      "Price": "546"
    }
  ]

fun combineByKey(in1,in2,k) = do {
    var groupedBy = in2 groupBy $[k]
    ---
    in1 map {
        ($),
        details: groupedBy[$[k]]
    }
}


---

combineByKey(input1,input2,"CustomerID")

//do {
//  var groupedBy = input2 groupBy $.CustomerID
//  ---
//  input1 map {
//      ($),
//      details: groupedBy[$.CustomerID]
//  }
//}

/////////////////////////////////////////////////////////////////////

%dw 2.0
output application/json
var inp1= [
  {
    "CustomerID": "123",
    "Name": "Maria",
    "Phone": "030-0074321"
  },
  {
    "CustomerID": "56654",
    "Name": "sdf",
    "Phone": "030-6877452"
  }
]

var inp2= [
    {
      "OrderID": "10643",
      "CustomerID": "123",
      "Price": "200"
    },
    {
      "OrderID": "10692",
      "CustomerID": "123",
      "Price": "566"
    },
    {
      "OrderID": "10702",
      "CustomerID": "56654",
      "Price": "546"
    }
  ]

  var OrderIdCommon = inp1 map (firstInputValue) -> using (id = firstInputValue.OrderID) {
     (inp2 filter ($.*OrderID contains id)  map (secondInputValue) -> {
      OrderId : secondInputValue.OrderID 
    } ) 
  }

   var CustomerIdCommon = inp1 map (firstInputValue) -> using (id = firstInputValue.CustomerID) {
     (inp2 filter ($.*CustomerID contains id)  map (secondInputValue) -> {
      CustomerID: secondInputValue.CustomerID
    } ) 
  }

  var CommonKey = ((if(sizeOf(OrderIdCommon - {}) > 0) OrderIdCommon else CustomerIdCommon)[0] pluck $$)[0]

  var inp1HasCKey = inp1[0] pluck $$ contains CommonKey
  var inp2HasCKey = inp2[0] pluck $$ contains CommonKey

fun combineByKey(in1,in2,k) = do {
    var groupedBy = (in2 groupBy $[k])
    ---
    in1 map {
        ($),
        details: groupedBy[$[k]] map {
            a: (($) - k)
        }.a
    } 
}

---

(if((inp1HasCKey == true) and (inp2HasCKey == true))
{
    a: combineByKey(inp1,inp2,CommonKey as String)
}
else
{
    a: "No common key found"
}).a


////////////////////////////////////////////////////////////////////////
  %dw 2.0
    output application/json
    ---
    input1 map(value) -> using (id = value.CustomerID)
    {
       CustomerID: value.CustomerID,
       Name: value.Name,
       Phone:value.Phone,
       Details: (input2 filter ($.*'CustomerID' contains  id) map ($ mapObject (k,v) ->{
         (v):k
         } - "CustomerID"))
    }


