----------------------------- MODULE beans -----------------------------
EXTENDS Integers
CONSTANTS R, G, B

ASSUME  /\ R \in 0..200
          /\ G \in 0..200
          /\ B \in 0..200
             
(*
--fair algorithm beansAlgo{
   variable red=R, blue=B, green=G;
   {S:while(TRUE)
   { either
A1blue: {await (blue>1);  \*same color and blue 
         blue:=blue-2; green:=green+1; red:=red+1;
};   
     or
A1red: {await (red>1);  \*same color and red 
         red:=red-2; green:=green+1; blue:=blue+1;
}; 
     or
A1green: {await (green>1);  \*same color and green 
         green:=green-2; blue:=blue+1; red:=red+1;
}; 
     or
A2rg: {await (red>0 /\ green>0); \*different color red and green
       red:=red-1; green:=green-1; blue:=blue+1;
};
     or
A2gb: {await (blue>0 /\ green>0); \*different color blue and green
       blue:=blue-1; green:=green-1; red:=red+1;
};
     or
A2br: {await (red>0 /\ blue>0); \*different color red and blue
       red:=red-1; blue:=blue-1; green:=green+1;
};
   
  } \*end while  
 } \*end algo
} \*end algo
*)
\* BEGIN TRANSLATION
VARIABLES red, blue, green, pc

vars == << red, blue, green, pc >>

Init == (* Global variables *)
        /\ red = R
        /\ blue = B
        /\ green = G
        /\ pc = "S"

S == /\ pc = "S"
     /\ \/ /\ pc' = "A1blue"
        \/ /\ pc' = "A1red"
        \/ /\ pc' = "A1green"
        \/ /\ pc' = "A2rg"
        \/ /\ pc' = "A2gb"
        \/ /\ pc' = "A2br"
     /\ UNCHANGED << red, blue, green >>

A1blue == /\ pc = "A1blue"
          /\ (blue>1)
          /\ blue' = blue-2
          /\ green' = green+1
          /\ red' = red+1
          /\ pc' = "S"

A1red == /\ pc = "A1red"
         /\ (red>1)
         /\ red' = red-2
         /\ green' = green+1
         /\ blue' = blue+1
         /\ pc' = "S"

A1green == /\ pc = "A1green"
           /\ (green>1)
           /\ green' = green-2
           /\ blue' = blue+1
           /\ red' = red+1
           /\ pc' = "S"

A2rg == /\ pc = "A2rg"
        /\ (red>0 /\ green>0)
        /\ red' = red-1
        /\ green' = green-1
        /\ blue' = blue+1
        /\ pc' = "S"

A2gb == /\ pc = "A2gb"
        /\ (blue>0 /\ green>0)
        /\ blue' = blue-1
        /\ green' = green-1
        /\ red' = red+1
        /\ pc' = "S"

A2br == /\ pc = "A2br"
        /\ (red>0 /\ blue>0)
        /\ red' = red-1
        /\ blue' = blue-1
        /\ green' = green+1
        /\ pc' = "S"

Next == S \/ A1blue \/ A1red \/ A1green \/ A2rg \/ A2gb \/ A2br

Spec == /\ Init /\ [][Next]_vars
        /\ WF_vars(Next)

\* END TRANSLATION

Termination == <> (red+green+blue = 1) 
============================================
\* Project Group Members: Ankit Jain(5009 7432), Milky Sahu(5009 6350)



\*Consider a coffee can containing an arbitrary (but finite) number of beans. The beans come
\*in 3 different colors: red, green, and blue.
\*Now consider the following program:
\*Choose two beans from the can;
\*if they are the same color, toss them out and add two beans for the other two colors
\*if they are different colors, toss them out and add a bean of the third color
\*Repeat.



\* ANSWER 1:
\* 3 Invariant Conditions
\* red+green+blue>0
\* red+blue<=400 \/ blue+green<=400 \/ green+red <=400
\* red+green > 0 \/ green+blue >0

\* ANSWER 2:
\* Fixed Point of the Program:
\* Since invariant is red+green+blue>0 i.e. this condition is always satisfied for the program. Now the fixed point can be reached 
\* when the quantity of beans for any two colors falls below 1 in the can and only 1 third bean is present so that 
\* that they don't get picked up in the next iteration (either for same color or different color)
\* (green <= 1 /\ (red <=0 /\ blue <=0)) \/ (blue <= 1  /\ (red <= 0 \/ green <=0)) \/ (red <= 1 /\ (blue <=0 /\ green <=0)) 

\* ANSWER 3:
\* Variant Function or metric function 
\* red+green+blue 
\* As a metric, we choose red+green+blue. This value is bounded below, as evident by the invariant. 
\* Also, it never increases since the rate of decrement in number of beans is greater than their rate of increment.
\* (As, when the beans tossed out are of same color, the count of beans in the box remains the same. If the beans tossed 
\*  out are of different colors, then the rate of decrement is greater than the increment) 
\* Therefore, this program terminates.
\*   

=============================================================================
\* Modification History
\* Last modified Tue Sep 30 18:19:51 EDT 2014 by Ankit
\* Created Thu Sep 25 11:02:02 EDT 2014 by Ankit
