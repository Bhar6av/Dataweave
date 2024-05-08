%dw 2.0
output application/json
var b = (1 to 999) as Array // range or you can pass a custom array
var a = [3,5] // array of number for which you want to calculate the sum of multiples
//in this function flatten is used  to combine all the arrays
//disictnBy $ used to remove duplicate item form the array
fun mult(num,rng)= (flatten(num map ((val, index) ->  (rng filter ((item , index) -> (item mod val)==0)))))   distinctBy $

---
sum(mult(a,b) map ((item, index) -> item as Number))