/*
Input:


<StudentsData>
    <Student name="ABC" rollnumber="123">
        <Subject name="Maths" marks="90" Sem="1st"/>
        <Subject name="Eng" marks="67" Sem="1st"/>
        <Subject name="Physics" marks="54" Sem="1st"/>
        <Subject name="Chemitry" marks="77" Sem="1st"/>
        <Subject name="Biology" marks="89" Sem="1st"/>
    </Student>
    <Student name="DEF" rollnumber="123">
        <Subject name="Maths" marks="87" Sem="1st"/>
        <Subject name="Eng" marks="89" Sem="1st"/>
        <Subject name="Physics" marks="88" Sem="1st"/>
        <Subject name="Chemitry" marks="55" Sem="1st"/>
        <Subject name="Biology" marks="87" Sem="1st"/>
    </Student>
</StudentsData>

Expected Output

[
  {
    "Name": "ABC",
    "Sub1": "Maths-90",
    "Sub2" : "Eng-67",
    "Sub3" : "Physics-54",
    "Sub4" :  "Chemitry-77",
    "Sub5" : "Biology-89"
  },
  {
    "Name": "DEF",
    "Sub1": "Maths-87",
    "Sub2" : "Eng-89",
    "Sub3" : "Physics-88",
    "Sub4" :  "Chemitry-55",
    "Sub5" : "Biology-87"
  }
]
*/

%dw 2.0
output application/json
fun concatenateMarksAndSubject2(items) = 
    items 
        mapObject ((value, key, index) -> (value.@name): value.@marks ) 
        pluck ((value, key, index) -> "Sub$(index)": key ++ "-" ++ value )
---
payload.StudentsData.*Student map ((student, index) -> {
    "Name": student.@name,
     (concatenateMarksAndSubject2(student))
} )


