type colour = BLACK | WHITE
type piece = colour option

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
            
    end



class virtual player (name : string) (givenColour : colour) =
    object (self)        
        method getColour =
            givenColour

        method getName =
            name
            
        method virtual getMove : (int , int)
    end

class humanPlayer (name : string) (givenColour : colour) =
    object(self)
        inherit player name givenColour
        
        method getMove =
            print_string (name ^ ", enter your move as 'row, column' : ");
            let inputs = read_line ();
                    
    end
