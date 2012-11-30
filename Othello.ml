type colour = BLACK | WHITE
type piece = colour option

class board size =
    object (self)
        initializer
            if size <= 2 || size mod 2 = 0 then
                invalid_arg "Size must be greater than 2 and even."
        val pieces = Array.make_matrix size size None
        
        method setPiece x y givenPiece =
            pieces.(x).(y) <- givenPiece
        
        method getPiece x y =
            pieces.(x).(y)
        
    end



class player name givenColour =
    object (self)        
        method getColour =
            givenColour
        
        method getName =
            name
    end


