:- use_module(library(clpfd)).
  distance(c1, c2, 10, 1). distance(c1, c3, 0, 0). distance(c1, c4, 7, 1).
  distance(c1, c5, 5, 1). distance(c2, c3, 4, 1). distance(c2, c4, 12, 1).
  distance(c2, c5, 20, 1). distance(c3, c4, 0, 0). distance(c3, c5, 0, 0).
  distance(c4, c5, 0, 0). distance(c2, c1, 10, 1). distance(c3, c1, 0, 0).
  distance(c4, c1, 7, 1). distance(c5, c1, 5, 1). distance(c3, c2, 4, 1).
  distance(c4, c2, 12, 1). distance(c5, c2, 20, 1). distance(c4, c3, 0, 0).
  distance(c5, c3, 0, 0). distance(c5, c4, 0, 0).



%member(Cabin, [Head|_]) :- member(Cabin, Head).
%member(Cabin, [_|Tail]) :- member(Cabin, Tail).

plan_visited(Cabin, Cabin, Path, TotalDistance, _) :- 
    Path = [Cabin],
    TotalDistance is 0.

plan_visited(Cabin1, Cabin2, Path, TotalDistance, Visited) :-
    not(Cabin1 = Cabin2),
    not(member(Cabin1, Visited)),
    distance(Cabin1, CabinNext, D1, 1),
    plan_visited(CabinNext, Cabin2, TailPath, D2, [Cabin1 | Visited]),
    \+ member(Cabin1, TailPath),
    Path = [Cabin1|TailPath],
    TotalDistance is D1 + D2.

plan(Cabin1, Cabin2, Path, TotalDistance) :-
    plan_visited(Cabin1, Cabin2, Path, TotalDistance, []).

bestplan(Cabin1, Cabin2, Path, Distance) :-
    findallplans(Plans, Cabin1, Cabin2),
    min_in_list(Plans, (Path, Distance))
    .
    
findallplans(Plans, C1, C2) :-
    findall([P, D], plan(C1, C2, P, D), Plans).

min_in_list([[P,D]],(P,D)).              

min_in_list([[P0,D0],[_,D1]|T],(P,D)) :-
    D0 =< D1,                            
    min_in_list([[P0, D0]|T],(P,D)).     

min_in_list([[_,D0],[P1,D1]|T],(P,D)) :-
    D0 > D1,                             
    min_in_list([[P1,D1]|T],(P,D)).

% Run the test case 
bestplan(c1, c2, Path, Distance)
