% Merwan Chaoui Boudghen
% student number : 041124927

% State of the world


% initial state of the world
cupboard_open(n,[]).
cup_in_hand(n,[]).
cup_on_counter(n,[]).
kettle_filled(n,[]).
kettle_plugged_in(n,[]).
water_hot(n,[]).
water_in_cup(n,[]).
coffee_added(n,[]).


% Define precondition axiom

% open_cupboard
poss([open_cupboard|S]) :-
    cupboard_open(n,S).

% take_cup
poss([take_cup|S]) :-
    cup_in_hand(n,S),
    cupboard_open(y,S).

% place_on_counter
poss([place_on_counter|S]) :-
    cup_in_hand(y,S),
    cup_on_counter(n,S).


% fill_kettle
poss([fill_kettle|S]) :-
    cup_on_counter(y,S),
    kettle_filled(n,S).

% plug_in
poss([plug_in|S]) :-
    kettle_filled(y,S),
    kettle_plugged_in(n,S).


% wait_for_boiling
poss([wait_for_boiling|S]) :-
    kettle_plugged_in(y,S),
    water_hot(n,S).


% pour_hot_water
poss([pour_hot_water|S]) :-
    water_hot(y,S),
    water_in_cup(n,S).

% add instant coffee
poss([add_instant_coffee|S]) :-
    water_in_cup(y,S),
    coffee_added(n,S).


% Define successor state axioms    
% cupboard state in S
cupboard_open(y,[open_cupboard|S]) :-
    poss([open_cupboard|S]).
cupboard_open(X,[A|S]) :-
    poss([A|S]),
    A \= open_cupboard,
    cupboard_open(X,S).

% cup_in_hand state in S
cup_in_hand(y,[take_cup|S]) :-
    poss([take_cup|S]).
cup_in_hand(X,[A|S]) :-
    poss([A|S]),
    A \= take_cup,
    cup_in_hand(X,S).

% cup_on_counter state in S
cup_on_counter(y,[place_on_counter|S]) :-
    poss([place_on_counter|S]).
cup_on_counter(X,[A|S]) :-
    poss([A|S]),
    A \= place_on_counter,
    cup_on_counter(X,S).

% kettle_filled state in S
kettle_filled(y,[fill_kettle|S]) :-
    poss([fill_kettle|S]).
kettle_filled(X,[A|S]) :-
    poss([A|S]),
    A \= fill_kettle,
    kettle_filled(X,S).

% kettle_plugged_in state in S
kettle_plugged_in(y,[plug_in|S]) :-
    poss([plug_in|S]).
kettle_plugged_in(X,[A|S]) :-
    poss([A|S]),
    A \= plug_in,
    kettle_plugged_in(X,S).

% water_hot state in S
water_hot(y,[wait_for_boiling|S]) :-
    poss([wait_for_boiling|S]).
water_hot(X,[A|S]) :-
    poss([A|S]),
    A \= wait_for_boiling,
    water_hot(X,S).

% water_in_cup state in S
water_in_cup(y,[pour_hot_water|S]) :-
    poss([pour_hot_water|S]).
water_in_cup(X,[A|S]) :-
    poss([A|S]),
    A \= pour_hot_water,
    water_in_cup(X,S).

% coffee_added state in S
coffee_added(y,[add_instant_coffee|S]) :-
    poss([add_instant_coffee|S]).
coffee_added(X,[A|S]) :-
    poss([A|S]),
    A \= add_instant_coffee,
    coffee_added(X,S).

% make_coffee, condition for the cup of coffee to be completed
make_coffee(S) :-
    coffee_added(y,S).


% Breadth First Planning

plan(Goal,Plan):-bposs(Plan),Goal.
bposs(S) :- tryposs([],S).

tryposs(S,S) :- poss(S).   % print the plan so far
tryposs(X,S) :- tryposs([_|X],S).   %plan gets longer  


% ---------------
% querie to run : 
% ?- plan(make_coffee(S),S).
% Output (~20 sec) : 
% S = [add_instant_coffee, pour_hot_water, wait_for_boiling, plug_in, fill_kettle, place_on_counter, take_cup, open_cupboard] 

% -----------------------
% validating a solution : 
% querry to run : 
% ?- poss([add_instant_coffee, pour_hot_water, wait_for_boiling, plug_in, fill_kettle, place_on_counter, take_cup, open_cupboard]).
% Output (instantly): 
% True.