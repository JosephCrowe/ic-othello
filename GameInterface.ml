class virtual gameInterface =
    object (self)
        method virtual gameUpdate : Othello.board -> unit

        method virtual gameOver : Othello.player -> unit
    end;;

class consoleGameInterface =
    object (self)
        inherit gameInterface

        method gameUpdate theBoard =
            let maxIndex = theBoard#getSize - 1 in
            for x = 0 to maxIndex do
                for y = 0 to maxIndex do
                    match theBoard#getPiece x y with
                    |   None                -> print_string ". "
                    |   Some Othello.WHITE  -> print_string "o "
                    |   Some Othello.BLACK  -> print_string "x "
                done
            done
        
        method gameOver winPlayer =
            print_endline (winPlayer#getName ^ " wins.")
    end;;
