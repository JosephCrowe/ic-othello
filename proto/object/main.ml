class test =
    object (self)
        val x = 0
        method get_x = x
        method print_x = print_int self#get_x
    end;;

new test#print_x;
print_newline ()
