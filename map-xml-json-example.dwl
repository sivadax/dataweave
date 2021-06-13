/*

<StudentsData>
    <Student name="ABC" rollnumber="123">
        <Subject name="Maths">
            <Grade Sem="1st" marks="90" result="pass"/>
            <Grade Sem="2nd" marks="45" result="fail"/>
        </Subject>
        <Subject name="English">
            <Grade Sem="1st" marks="75" result="pass"/>
            <Grade Sem="2nd" marks="87" result="pass"/>
        </Subject>
        <Subject name="Physics">
            <Grade Sem="1st" marks="67" result="pass"/>
            <Grade Sem="2nd" marks="78" result="pass"/>
        </Subject>
    </Student>
    <Student name="DEF" rollnumber="456">
        <Subject name="Maths">
            <Grade Sem="1st" marks="56" result="pass"/>
            <Grade Sem="2nd" marks="87" result="pass"/>
        </Subject>
        <Subject name="English">
            <Grade Sem="1st" marks="98" result="pass"/>
            <Grade Sem="2nd" marks="99" result="pass"/>
        </Subject>
        <Subject name="Physics">
            <Grade Sem="1st" marks="90" result="pass"/>
            <Grade Sem="2nd" marks="87" result="pass"/>
        </Subject>
    </Student>
</StudentsData>

[
  {
    "Name": "ABC",
    "RollNumber": "123",
    "Subjects": [
      {
        "Subject": "Maths",
        "performance": [
          {
            "semester": "1st",
            "marks": "90",
            "result": "pass"
          },
          {
            "semester": "2nd",
            "marks": "45",
            "result": "fail"
          }
        ]
      },
      {
        "Subject": "English",
        "performance": [
          {
            "semester": "1st",
            "marks": "75",
            "result": "pass"
          },
          {
            "semester": "2nd",
            "marks": "87",
            "result": "pass"
          }
        ]
      },
      {
        "Subject": "Physics",
        "performance": [
          {
            "semester": "1st",
            "marks": "67",
            "result": "pass"
          },
          {
            "semester": "2nd",
            "marks": "78",
            "result": "pass"
          }
        ]
      }
    ]
  },
  {
    "Name": "DEF",
    "RollNumber": "456",
    "Subjects": [
      {
        "Subject": "Maths",
        "performance": [
          {
            "semester": "1st",
            "marks": "56",
            "result": "pass"
          },
          {
            "semester": "2nd",
            "marks": "87",
            "result": "pass"
          }
        ]
      },
      {
        "Subject": "English",
        "performance": [
          {
            "semester": "1st",
            "marks": "98",
            "result": "pass"
          },
          {
            "semester": "2nd",
            "marks": "99",
            "result": "pass"
          }
        ]
      },
      {
        "Subject": "Physics",
        "performance": [
          {
            "semester": "1st",
            "marks": "90",
            "result": "pass"
          },
          {
            "semester": "2nd",
            "marks": "87",
            "result": "pass"
          }
        ]
      }
    ]
  }
]

*/

%dw 2.0
output application/json
---
payload.StudentsData.*Student map ((student, index) -> {
        Name : student.@name,
        RollNumber : student.@rollnumber,
        Subjects : student.*Subject map ((sub, index) -> {
            Subject : sub.@name,
            performance : sub.*Grade map ((item, index) -> {
                semester : item.@Sem,
                marks: item.@marks,
                result: item.@result
            } )
            
        } )
})
