(*******************************************************************************
 *  ConsoleGame module: contains the consoleGame class.
 *)
open GameInterface
open Colour
open Board

(*******************************************************************************
 *  Presents the state changes of the underlying game in a human-readable text
 *  format through standard output.
 *)
class consoleGame theGame =
    object (self)
        inherit gameInterface theGame

        method gameUpdate theBoard =
            let pad n str = String.make (n - String.length str) ' ' ^ str in

            let size = theBoard#getSize in
            let rowHeads = Array.init size rowToStr in
            let colHeads = Array.init size colToStr in
            let colWidth = 1 + Array.fold_left max 0 (Array.map String.length colHeads) in
            let headWidth = 1 + Array.fold_left max 0 (Array.map String.length rowHeads) in

            print_string (pad headWidth "");
            Array.iter (fun str -> print_string (pad colWidth str)) colHeads;
            print_newline ();

            for y = 0 to size - 1 do
                print_string (pad headWidth rowHeads.(y));
                for x = 0 to size - 1 do
                    let symbol = match theBoard#getPiece (x, y) with
                    |   Some WHITE  -> "o"
                    |   Some BLACK  -> "x"
                    |   None        -> "." in
                    print_string (pad colWidth symbol)
                done;
                print_newline ()
            done;
            
            print_newline ()

        method gameSkip thePlayer =
            print_endline (thePlayer#getName ^ "'s turn is skipped "
                ^ "because they have no legal moves.");
            print_newline ()

        method gameWon thePlayer =
            print_endline ("Game over: " ^ thePlayer#getName ^ " wins.");
            print_newline ()

        method gameDrawn =
            print_endline ("Game over: the game ends in a draw.");
            print_newline ()
    end;;
