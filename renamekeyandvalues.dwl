%dw 2.0
output application/json
var dict = '[{"Source": "message","Target": "EmpName"},{"Source": "Hello","Target": "employee"}]'

fun processobj(obj)= obj mapObject ((value, key, index) -> (processval(key)): if (typeOf(value) as String != "String") processpyld(value) else processval(value) ) 
fun processpyld(value) =
typeOf(value) match{
    case array: "Array" -> if (((value map ((item, index) -> {
    "type": typeOf(item) as String
}))."type") contains  ("Object")) (value map processpyld($)) else (value map processpyld($))
case object : "Object" -> processobj(value)
case String : "String" -> processval(value)
else-> value 
}
fun processval(value) =
  if (!isEmpty(read(dict, "application/json")filter (($.Source) == value as String))) (read(dict,"application/json") filter (($.Source) == value as String)).Target[0]  
  else
    (value)
---
processpyld(payload)
