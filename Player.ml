open Colour
open Board

class virtual player (name : string) (givenColour : colour) =
    object (self)        
        method getColour =
            givenColour

        method getName =
            name
            
        method virtual getMove : int * int
    end;;

class humanPlayer (name : string) (givenColour : colour) =
    object (self)
        inherit player name givenColour
        
        method getMove =
            print_string (name ^ ", enter your move as 'column, row': ");
            let inputs = read_line () in
            match Str.split (Str.regexp_string ",") inputs with
            | [x; y] ->
                begin
                    match (strToCol x, strToRow y) with
                    |   (Some x, Some y)    -> (x, y)
                    |   _                   -> self#getMoveFail
                end
            | _ -> self#getMoveFail
        
        method getMoveFail =
            print_endline
                "Please enter your move as a column name then a comma then a row name.";
            self#getMove
    end;;

