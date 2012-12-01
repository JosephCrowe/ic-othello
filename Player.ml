open Colour

class virtual player (name : string) (givenColour : colour) =
    object (self)        
        method getColour =
            givenColour

        method getName =
            name
            
        method virtual getMove : int * int
    end;;

class humanPlayer (name : string) (givenColour : colour) =
    object(self)
        inherit player name givenColour
        
        method getMove =
            print_string (name ^ ", enter your move as 'row, column': ");
            let inputs = read_line () in
            match Str.split (Str.regexp_string ",") inputs with
            | [x; y] ->
                begin
                    try (int_of_string x, int_of_string y)
                    with Failure _ -> self#getMoveFail
                end
            | _ -> self#getMoveFail
        
        method getMoveFail =
            print_endline "Please enter your move as two integers separated by a comma.";
            self#getMove
    end;;

