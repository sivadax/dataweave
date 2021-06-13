/*
<a>
   <b/>
   <c>
      <value1 />
   </c>  
   <c>
      <value2 />
    </c>  
   <c>
      <value3/>
   </c> 
</a>


</b>
 <c>
            <value1 />
</c>  
 <c>
            <value2 />
</c>  
 <c>
            <value3/>
</c>

*/

%dw 2.0
output application/java
---
(payload[0] pluck (value,key,index) -> {(key):value} )
    reduce ((item, acc="") -> acc ++ write(item, "application/xml",  {"writeDeclaration":false}) ++ "\n" ) 
