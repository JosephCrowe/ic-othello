(*******************************************************************************
 *  HumanPlayer module: contains the humanPlayer class.
 *)

open Player
open Colour
open Board

(*******************************************************************************
 *  An interface to a human player who enters their moves through standard
 *  input and reads feedback from standard output. Multiple human players with
 *  different names may play simultaneously without ambiguity.
 *)
class humanPlayer (name : string) (givenColour : colour) =
    object (self)
        inherit player name givenColour
        
        method getMove =
            let move = self#readMove in
            print_newline ();
            move

        (* Like getMove, but does not print a trailing newline. *)
        method private readMove =
            print_string (name ^ ", enter your move as 'column, row': ");
            let inputs = read_line () in
            match Str.split (Str.regexp_string ",") inputs with
            | [x; y] ->
                begin
                    match (strToCol x, strToRow y) with
                    |   (Some x, Some y)    -> (x, y)
                    |   _                   -> self#readMoveFail
                end
            | _ -> self#readMoveFail

        (* The player has entered an invalid move. *)
        method private readMoveFail =
            print_endline
                "Please enter your move as a column name then a comma then a row name.";
            print_newline ();
            self#readMove
        
        method invalidMove =
            print_endline (name ^ ", the move you have given is illegal.");
            print_newline ()
    end;;
