open Board
open Player
open Game

class virtual gameInterface (theGame : #game) =
    object (self : #gameListener)
        initializer
            theGame#listen self

        method start
            = theGame#start
    
        method virtual gameUpdate : board -> unit

        method virtual gameWon : player -> unit

        method virtual gameDrawn : unit
    end;;
