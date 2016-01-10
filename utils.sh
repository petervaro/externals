#!/bin/bash
## INFO ##
## INFO ##

run()
{
    printf "$1:\n==> $2";
    eval $2;
    printf " ... DONE\n";
}

sudorun()
{
    sudo printf "$1:\n==> $2";
    eval "sudo $2";
    printf " ... DONE\n";
}
