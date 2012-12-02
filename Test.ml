open GameInterface
open Board
open Game
open Player
open Colour
open Board

class testGame =
    object (self)
        val thePlayer = new humanPlayer "Joseph" BLACK
        val theBoard = new board 16
        inherit game
        method start =
            self#gameUpdate theBoard;
            let move = thePlayer#getMove in
            theBoard#setPiece move (Some thePlayer#getColour);
            self#start
    end;;

(new consoleGameInterface (new testGame))#start
