% Move R1, R3
action(
    state(SteelKey, hasBrassKey, Box, Items, r1),
    walk(r1, r3),
    state(SteelKey, hasBrassKey, Box, Items, r3)
).

% Move R3 to R1
action(
    state(SteelKey, hasBrassKey, Box, Items, r3),
    walk(r3, r1),
    state(SteelKey, hasBrassKey, Box, Items, r1)
).



% Move R1, R2
action(
    state(hasSteelKey, BrassKey, Box, Items, r1),
    walk(r1, r2),
    state(hasSteelKey, BrassKey, Box, Items, r2)
).

% Move R2 to R1
action(
    state(hasSteelKey, BrassKey, Box, Items, r2),
    walk(r2, r1),
    state(hasSteelKey, BrassKey, Box, Items, r1)
).



% Grab Steel Key
action(
    state(Room, BrassKey, Box, Items, Room), 
    grab(steelKey, Room), 
    state(hasSteelKey, BrassKey, Box, NewItems, Room)) :-
        Items < 2, 
        NewItems is Items + 1.

% Grab Brass Key
action(
    state(SteelKey, Room, Box, Items, Room), 
    grab(brassKey, Room), 
    state(SteelKey, hasBrassKey, Box, NewItems, Room)) :-
        Items < 2, 
        NewItems is Items + 1.

% Grab Box
action(
    state(SteelKey, BrassKey, Room, Items, Room), 
    grab(box, Room), 
    state(SteelKey, BrassKey, hasBox, NewItems, Room)) :-
        Items < 2, 
        NewItems is Items + 1.



% Drop SteelKey
action(
    state(hasSteelKey, BrassKey, Box, Items, Room), 
    drop(steelKey, Room), 
    state(Room, BrassKey, Box, NewItems, Room)) :-
        Items > 0, 
        NewItems is Items - 1.

% Drop BrassKey
action(
    state(SteelKey, hasBrassKey, Box, Items, Room), 
    drop(brassKey, Room), 
    state(SteelKey, Room, Box, NewItems, Room)) :-
        Items > 0, 
        NewItems is Items - 1.

% Drop Box
action(
    state(SteelKey, BrassKey, hasBox, Items, Room), 
    drop(box, Room), 
    state(SteelKey, BrassKey, Room, NewItems, Room)) :-
        Items > 0, 
        NewItems is Items - 1.


solveR(state(_, _, r2, _, _), _, []).

solveR(State1, N, [Action|Trace2]):-
    N > 0,
    action(State1, Action, State2),
    N2 is N - 1,
    solveR(State2, N2, Trace2),
    format('~w~n', [Action]).

% solveR(state(r1, r2, r3, 0, r1), 12, _).