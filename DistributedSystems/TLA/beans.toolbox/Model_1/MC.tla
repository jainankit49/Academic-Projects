---- MODULE MC ----
EXTENDS beans, TLC

\* CONSTANT definitions @modelParameterConstants:0B
const_1412115613904224000 == 
5
----

\* CONSTANT definitions @modelParameterConstants:1G
const_1412115613914225000 == 
5
----

\* CONSTANT definitions @modelParameterConstants:2R
const_1412115613924226000 == 
5
----

\* SPECIFICATION definition @modelBehaviorSpec:0
spec_1412115613934227000 ==
Spec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1412115613945228000 ==
red+green+blue>0
----
\* INVARIANT definition @modelCorrectnessInvariants:1
inv_1412115613955229000 ==
red+blue<=400 \/ blue+green<=400 \/ green+red <=400
----
\* INVARIANT definition @modelCorrectnessInvariants:2
inv_1412115613965230000 ==
red+green > 0 \/ green+blue >0
----
=============================================================================
\* Modification History
\* Created Tue Sep 30 18:20:13 EDT 2014 by Ankit
