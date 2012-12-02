open Board
open Player
open Game

class virtual gameInterface (theGame : #game) =
    object (self : #gameListener)
        inherit gameListener

        initializer
            theGame#listen self

        method start
            = theGame#start
    end;;
