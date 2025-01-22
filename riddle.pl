% Define the State of the world
bank(e). % e = East bank
bank(w). % w = West bank

% initial state 
% everyone is at the east bank initially
farmer_at(e,[]). 
sheep_at(e,[]).
wolf_at(e,[]).
cabbage_at(e,[]).
    
% Define precondition axiom

% when it's possible for the farmer to cross with the sheep
poss([cross_with_sheep(From,To)|S]):-
    bank(From),bank(To),
    From \= To,
    farmer_at(From,S),
    sheep_at(From,S).

% when it's possible for the farmer to cross with the wolf
poss([cross_with_wolf(From,To)|S]):-
    bank(From),bank(To),
    From \= To,
    farmer_at(From,S),
    wolf_at(From,S),
    \+ (sheep_at(From,S),cabbage_at(From,S)). % sheep and cabbage should not be left together

% when it's possible for the farmer to cross with the cabbage
poss([cross_with_cabbage(From,To)|S]):-
    bank(From),bank(To),
    From \= To,
    farmer_at(From,S),
    cabbage_at(From,S),
    \+ (sheep_at(From,S),wolf_at(From,S)). % sheep and wolf should not be left together
    
% when it's possible for the farmer to cross alone
poss([cross_alone(From,To)|S]):-
    bank(From),bank(To),
    From \= To,
    farmer_at(From,S),
    \+ (cabbage_at(From,S),sheep_at(From,S)), % sheep and cabbage should not be left together
    \+ (wolf_at(From,S),sheep_at(From,S)). % sheep and wolf should not be left together
    
% Define successor state axioms    

% define farmer position in S
farmer_at(To,[cross_with_cabbage(From,To)|S]):- poss([cross_with_cabbage(From,To)|S]).

farmer_at(To,[cross_with_wolf(From,To)|S]):- poss([cross_with_wolf(From,To)|S]).

farmer_at(To,[cross_with_sheep(From,To)|S]):- poss([cross_with_sheep(From,To)|S]).

farmer_at(To,[cross_alone(From,To)|S]):- poss([cross_alone(From,To)|S]).

farmer_at(X,[A|S]):-
    poss([A|S]),
    A \= cross_alone(X,_),
    A \= cross_with_sheep(X,_),
    A \= cross_with_wolf(X,_),
    A \= cross_with_cabbage(X,_),
    farmer_at(X,S).

% define sheep position in S
sheep_at(To,[cross_with_sheep(From,To)|S]):- poss([cross_with_sheep(From,To)|S]).
sheep_at(X,[A|S]):-
    poss([A|S]),
    A \= cross_with_sheep(X,_),
    sheep_at(X,S).

% define wolf position in S
wolf_at(To,[cross_with_wolf(From,To)|S]):- poss([cross_with_wolf(From,To)|S]).
wolf_at(X,[A|S]):-
    poss([A|S]),
    A \= cross_with_wolf(X,_),
    wolf_at(X,S).

% define cabbage position in S
cabbage_at(To,[cross_with_cabbage(From,To)|S]):- poss([cross_with_cabbage(From,To)|S]).
cabbage_at(X,[A|S]):-
    poss([A|S]),
    A \= cross_with_cabbage(X,_),
    cabbage_at(X,S).

% conditions for the riddle to be solved
solve_riddle(S):-
    wolf_at(w,S),
    sheep_at(w,S),
    cabbage_at(w,S).

% Breadth First Planning

plan(Goal,Plan):-bposs(Plan),Goal.
bposs(S) :- tryposs([],S).

tryposs(S,S) :- poss(S).   % print the plan so far
tryposs(X,S) :- tryposs([_|X],S).   %plan gets longer          



% ----------------
% query to run : 
% ?- plan(solve_riddle(S),S).
% output: {should take a few seconds}
% S = [cross_with_sheep(e, w), cross_alone(w, e), cross_with_cabbage(e, w), cross_with_sheep(w, e), cross_with_wolf(e, w), cross_alone(w, e), cross_with_sheep(e, w)] ;
% S = [cross_with_sheep(e, w), cross_alone(w, e), cross_with_wolf(e, w), cross_with_sheep(w, e), cross_with_cabbage(e, w), cross_alone(w, e), cross_with_sheep(e, w)] % ----------------
