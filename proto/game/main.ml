type move = Rock | Paper | Scissors

class player name =
    object (self)
        method get_name =
            name
        method get_move =
            print_string (name ^ ", enter your move: ");
            match read_line () with
            | "rock" ->     Rock
            | "paper" ->    Paper
            | "scissors" -> Scissors
            |  other ->     self#get_move_fail
        method private get_move_fail =
            print_endline "Please enter 'rock', 'paper' or 'scissors'.";
            self#get_move
    end;;

class game player1 player2 =
    object (self)
        method play : unit =
            match (player1#get_move, player2#get_move) with
            |   (Rock, Rock)            -> self#draw
            |   (Rock, Paper)           -> self#win player2
            |   (Rock, Scissors)        -> self#win player1
            |   (Paper, Rock)           -> self#win player1
            |   (Paper, Paper)          -> self#draw
            |   (Paper, Scissors)       -> self#win player2
            |   (Scissors, Rock)        -> self#win player2
            |   (Scissors, Paper)       -> self#win player1
            |   (Scissors, Scissors)    -> self#draw
        method private draw : unit =
            print_endline "The game ends in a draw.";
            self#game_over
        method private win : player -> unit = fun win_player ->
            print_endline (win_player#get_name ^ " wins.");
            self#game_over
        method private game_over : unit =
            print_string "Would you like to play another game? ";
            match read_line () with
            |   "yes"   -> self#play
            |   "no"    -> ()
            |   other   -> self#game_over_fail
        method private game_over_fail : unit =
            print_endline "Please enter 'yes' or 'no'.";
            self#game_over
    end;;

print_string "Enter Player 1's name: ";
let player1 = new player (read_line ()) in
print_string "Enter Player 2's name: ";
let player2 = new player (read_line ()) in

let game = new game player1 player2 in
game#play
