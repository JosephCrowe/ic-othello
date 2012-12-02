open Player
open HumanPlayer
open Board
open Game
open ConsoleGame
open Colour

class twoPlayersGame (player1 :player) (player2 :player) (currentBoard : board) =
    object(self)
        inherit game 
        
        val fs = [| 
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
            
        method keepCount currentPlayer nextPlayer count =
            if count = 2 then self#gameEnd
            else
                begin
                    match self#move currentPlayer nextPlayer with
                    |   []  ->  self#keepCount nextPlayer currentPlayer (count+1)
                    |   xs  ->
                            self#flipForAllPairs xs currentPlayer nextPlayer;
                            self#gameUpdate currentBoard;
                            self#keepCount nextPlayer currentPlayer 0;
                end
        
        method flipForAllPairs pairsOfPairs currentPlayer nextPlayer =
            match pairsOfPairs with
            |   []           ->   ()   
            |   (p1,p2)::ps  ->   self#flipInbetweeners p1 p2 (Some currentPlayer#getColour);
                                  self#flipForAllPairs ps currentPlayer nextPlayer
                
                
        method move currentPlayer nextPlayer =
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
                       	        self#printing zs;
                       	        zs
                    in loop ()
        
        
        method printing l =
            match l with
            | [] -> print_newline ()
            | ((a,b),(c,d)) :: xs ->
                    Printf.printf "(%s,%s),(%s,%s); "
                        (colToStr a) (rowToStr b) (colToStr c) (rowToStr d);
                    self#printing xs
            
        method getPossibleMoves currentPiece oppositePiece=
            let results = ref [] in
            for x = 0 to 7 do
                for y = 0 to 7 do
                    if (currentBoard#getPiece (x,y) = None) then
                        begin
                            for i = 0 to 7 do
                                if currentBoard#getPieceNone (fs.(i) (x,y)) = oppositePiece then 
                                    let (l,m) = self#checkDirection i (x,y) (fs.(i) (x,y)) currentPiece oppositePiece in
                                        if ((x,y) <> (l,m)) then
                                            results := ((x,y), (l,m)) :: results.contents
                            done    
                        end
                done
            done;
            results.contents


                
        method flipInbetweeners (a,b) (c,d) playerPiece =
            if (a,b) = (c,d) then ()
            else 
                begin
                    let (x,y) = (self#add (a,b) (self#adderUnit (a,b) (c,d))) in
                    currentBoard#setPiece (a,b) playerPiece;
                    self#flipInbetweeners (x,y) (c,d) playerPiece
                end
        
        method add (x1,y1) (x2,y2) = (x1  +x2 , y1 + y2)
        
        (*  *)
        method adderUnit (a,b) (c,d) =
            if (a = c && b = d) then (0,0)
            else if (a = c)     then (0 , abs(d-b)/(d-b))
            else if (b = d)        then (abs(c-a)/(c-a) , 0)
            else                     (abs(c-a)/(c-a) , abs(d-b)/(d-b))
                
        method checkDirection i (x,y) (l,m) playerPiece opponentPiece=
            if (l < 0 || l > 7 || m < 0 || m > 7)
                then (x,y)
            else if (currentBoard#getPiece (l,m) = playerPiece)
                then (l,m)
            else if (currentBoard#getPiece (l,m) = opponentPiece)
                then self#checkDirection i (x,y) (fs.(i) (l,m))
                    playerPiece opponentPiece
            else (x,y)

    end;;                
                
print_string "Enter Player 1's name: ";
let player1Name = "Player1" (*read_line ()*) in
print_string "Enter Player 2's name: ";
let player2Name = "Player2" (*read_line ()*) in
(*print_endline (player1Name ^ ", please choose your colour as 'black' or 'white'");

let rec readColour () =
    match read_line () with
    |   "black" -> BLACK
    |   "white" -> WHITE
    |   _       -> readColour ()
in

let player1Colour = readColour () in
let player2Colour = if player1Colour = BLACK then WHITE else BLACK in
*)
let (player1Colour, player2Colour) = (BLACK, WHITE) in
let player1 = new humanPlayer player1Name player1Colour in
let player2 = new humanPlayer player2Name player2Colour in
let currentBoard = new board 8 in
let currentGame = new twoPlayersGame player1 player2 currentBoard in

let interface = new consoleGame currentGame in
interface#start

