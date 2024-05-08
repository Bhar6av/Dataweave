%dw 2.0
output application/json
var dict = '[{"Source": "message","Target": "EmpName"},{"Source": "Hello","Target": "employee"}]'

fun processobj(obj)= obj mapObject ((value, key, index) -> (processObj2(key)): if (typeOf(value) as String != "String") processpyld(value) else processObj2(value) ) 
fun processpyld(value) =
typeOf(value) match{
    case array: "Array" -> if (((value map ((item, index) -> {
    "type": typeOf(item) as String
}))."type") contains  ("Object")) (value map processpyld($)) else (value)
case object : "Object" -> processobj(value)
case String : "String" -> processObj2(value)
else-> value 
}
fun processObj2(value) =
  if (!isEmpty(read(dict, "application/json")filter (($.Source) == value as String))) (read(dict,"application/json") filter (($.Source) == value as String)).Target[0]  
  else
    (value)
---
processpyld(payload)