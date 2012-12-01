class board (size : int) =
    object (self)
        val pieces : piece array array
            = Array.make_matrix size size None
            
        initializer
            if size <= 2 || size mod 2 = 0 then
                invalid_arg "Size must be greater than 2 and even."

        method setPiece x y givenPiece =
            pieces.(x).(y) <- givenPiece

        method getPiece x y =
            pieces.(x).(y)            

        method getSize =
            size
    end;;

let colToStr x : int -> string =
    "";;

let rowToStr y : int -> string =
    "";;

let strToRow x : string -> int =
    0;;

let strToCol y : string -> int option =
    0;;
