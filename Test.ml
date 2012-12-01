open GameInterface;;
open Board;;

let i = new consoleGameInterface in
let b = new board 16 in
i#gameUpdate b

