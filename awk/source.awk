BEGIN {RS="\n"; FS=",";}
{
    initState[NR]=$1;
    initSymbol[NR]=$2;
    newState[NR]=$3;
    newSymbol[NR]=$4;
    move[NR]=$5;
}

function get_transition_line(state, symbol,    i)
{
    for (i=1; i<=NR; i++)
    {
        if (initState[i] == state && initSymbol[i] == symbol)
            return i;
    }
    return -1;
}

function print_tape(tape,    OLD_ORS, s)
{
    OLD_ORS=ORS;
    ORS="";
    for (s in tape) print tape[s] " ";
    print "\n\n";
    ORS=OLD_ORS;
}

END {

    print "";
    print "INPUT FILE" INPUT;

    getline line < INPUT;
    sub("\n", "", line);
    split(line,tape,"");

    print "With the input tape:"
    print_tape(tape)

    ORS="";

    state=0;
    symbol_n=1;
    while ((transition_n=get_transition_line(state, tape[symbol_n])) != -1)
    {
        print "State: " state "; tape position: " symbol_n "; transition rule: " transition_n;
        print "\n";

        state=newState[transition_n];
        tape[symbol_n]=newSymbol[transition_n];
        if (move[symbol_n]=="L")
            symbol_n--;
        else
            symbol_n++;

        #for (s in tape) print "^" tape[s] "$"; FOR DEBUGGING
        print_tape(tape);
    }

    print_tape(tape);
    print "Done!";
    print "\n";
}
