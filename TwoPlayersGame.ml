(*******************************************************************************
 *  ThePlayersGame module: contains the class twoPlayersGame.
 *)

open Game
open Player
open Board
open Colour

let add (x1,y1) (x2,y2) = (x1 + x2 , y1 + y2);;

(*******************************************************************************
 *  Implements the game Othello with standard rules for a Two-player game on
 *  a single board
 *)
class twoPlayersGame (player1 : player) (player2 : player) (currentBoard : board) =
    object(self)
        inherit game

        val boardSize = currentBoard#getSize

	    (* An array of functions that translate points in 2-D as described below *)
        val translations = [|
                    (fun (x,y) -> (x+1,y)) ;
                    (fun (x,y) -> (x+1,y+1)) ;
                    (fun (x,y) -> (x,y+1)) ;
                    (fun (x,y) -> (x-1,y+1)) ;
                    (fun (x,y) -> (x-1,y)) ;
                    (fun (x,y) -> (x-1,y-1)) ;
                    (fun (x,y) -> (x,y-1)) ;
                    (fun (x,y) -> (x+1,y-1))
                 |];

        method start =
            self#gameUpdate currentBoard;
            self#keepCount player1 player2 0

	    (* Ends the game when called *)
        method private gameEnd =
            let noOfPlayer1s, noOfPlayer2s = ref 0, ref 0 in
            let player1Piece = Some player1#getColour in
            let player2Piece = Some player2#getColour in
            for x = 0 to boardSize - 1 do
                for y = 0 to boardSize - 1 do
                    if currentBoard#getPiece (x,y) = player1Piece then noOfPlayer1s := noOfPlayer1s.contents + 1
                    else if currentBoard#getPiece (x,y) = player2Piece then noOfPlayer2s := noOfPlayer2s.contents + 1
                done
            done;
            match noOfPlayer1s.contents - noOfPlayer2s.contents with
            | diff when diff > 0 -> self#gameWon player1
            | diff when diff < 0 -> self#gameWon player2
            | _                  -> self#gameDrawn

        (* Calls gameEnd when both the players don't have any viable move available *)
        method private keepCount currentPlayer nextPlayer count =
            if count = 2 then self#gameEnd
            else
                begin
                    match self#move currentPlayer nextPlayer with
                    |   []  ->  self#gameSkip currentPlayer;
                                self#keepCount nextPlayer currentPlayer (count+1)
                    |   xs  ->
                            self#flipForAllPairs xs currentPlayer nextPlayer;
                            self#gameUpdate currentBoard;
                            self#keepCount nextPlayer currentPlayer 0;
                end

        (* Flips the pieces in between two placed pieces to the current player's colour. *)
        method private flipInbetweeners (a,b) (c,d) playerPiece =
            if (a,b) = (c,d) then ()
            else
                begin
                    let (x,y) = (add (a,b) (self#adderUnit (a,b) (c,d))) in
                    currentBoard#setPiece (a,b) playerPiece;
                    self#flipInbetweeners (x,y) (c,d) playerPiece
                end

        (* An addable unit pair to add to a point to make it's transltion in the
           method flipInbetweeners *)
        method private adderUnit (a,b) (c,d) =
            if (a = c && b = d) then (0,0)
            else if (a = c)     then (0 , abs(d-b)/(d-b))
            else if (b = d)        then (abs(c-a)/(c-a) , 0)
            else                     (abs(c-a)/(c-a) , abs(d-b)/(d-b))

        (* Calls flipInbetweeners to account for all possible changes because of placing of a piece*)
        method private flipForAllPairs pairsOfPairs currentPlayer nextPlayer =
            match pairsOfPairs with
            |   []           ->   ()
            |   (p1,p2)::ps  ->   self#flipInbetweeners p1 p2 (Some currentPlayer#getColour);
                                  self#flipForAllPairs ps currentPlayer nextPlayer

        (* Calls for a move from current player and returns a list of pairs of
           2-D points. The pairs of points are, in fact, directed vectors
           representing all possible changes that can happen by the move. *)
        method private move currentPlayer nextPlayer =
                let moves = self#getPossibleMoves
                    (Some currentPlayer#getColour) (Some nextPlayer#getColour) in
                match moves with
                | []    -> []
                | x::xs ->
                    let rec loop () =
                        let theMove = currentPlayer#getMove in
                        match List.filter (fun (m, _) -> m = theMove) moves with
                       	|   [] ->
                       	        currentPlayer#invalidMove;
                       	        loop ()
                       	|   zs ->
                       	        zs
                    in loop ()

        (* Returns a list of all possible moves in the form of directed vectors,
           or pairs of 2-D points that can be played on the current board with the
           current piece *)
        method private getPossibleMoves currentPiece oppositePiece=
            let results = ref [] in
            for x = 0 to boardSize - 1 do
                for y = 0 to boardSize - 1 do
                    if (currentBoard#getPiece (x,y) = None) then
                        begin
                            for i = 0 to 7 do
                                if currentBoard#getPieceNone (translations.(i) (x,y)) = oppositePiece then
                                    let (l,m) = self#checkDirection i (x,y) (translations.(i) (x,y)) currentPiece oppositePiece in
                                        if ((x,y) <> (l,m)) then
                                            results := ((x,y), (l,m)) :: results.contents
                            done
                        end
                done
            done;
            results.contents

	    (* Helper method for getAllPossibleMoves, returns the second point to
           make a pair, given a point and direction *)
        method private checkDirection i (x,y) (l,m) playerPiece opponentPiece=
            if (l < 0 || l > boardSize - 1 || m < 0 || m > boardSize - 1)
                then (x,y)
            else if (currentBoard#getPiece (l,m) = playerPiece)
                then (l,m)
            else if (currentBoard#getPiece (l,m) = opponentPiece)
                then self#checkDirection i (x,y) (translations.(i) (l,m))
                    playerPiece opponentPiece
            else (x,y)
    end;;
