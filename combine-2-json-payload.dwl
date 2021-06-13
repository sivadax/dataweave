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
