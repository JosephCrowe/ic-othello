open Colour

class virtual player (name : string) (givenColour : colour) =
    object (self)        
        method getColour =
            givenColour

        method getName =
            name
            
        method virtual getMove : int * int
        
        method virtual invalidMove : unit
    end;;
