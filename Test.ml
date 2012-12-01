open GameInterface
open Board
open Game
open Player
open Colour
open Board

class testGame =
    object (self)
        val thePlayer = new humanPlayer "Joseph" BLACK
        val theBoard = new board
        inherit game
        method start =
            let move = thePlayer#getMove in
            theBoard#setPiece move thePlayer#getColour;
            self#gameUpdate
    end;;

(new consoleGameInterface (new testGame))#start
