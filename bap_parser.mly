%{
  open Printf
%}

%token EOF
%token <char> CHAR

%start grammar
%type <unit> grammar
%%

grammar:              {               }
grammar: grammar EOF  { printf "\n\n" ; exit 0   }
grammar: grammar CHAR { printf "<char:%c>\t" $2  }
