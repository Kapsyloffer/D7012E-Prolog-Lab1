% Move R1, R3
action(
    state(SteelKey, hasBrassKey, Box, Items, r1),
    walk(r1, r3),
    state(SteelKey, hasBrassKey, Box, Items, r3),
).

% Move R3 to R1
action(
    state(SteelKey, hasBrassKey, Box, Items, r3),
    walk(r3, r1),
    state(SteelKey, hasBrassKey, Box, Items, r1),
).



% Move R1, R2
action(
    state(hasSteelKey, BrassKey, Box, Items, r1),
    walk(r1, r2),
    state(hasSteelKey, BrassKey, Box, Items, r2),
).

% Move R2 to R1
action(
    state(hasSteelKey, BrassKey, Box, Items, r2),
    walk(r2, r1),
    state(hasSteelKey, BrassKey, Box, Items, r1),
).



% Grab Steel Key
action(
    state(Room, BrassKey, Box, Items, Room),
    grab(SteelKey, Room),
    state(hasSteelKey, BrassKey, Box, ItemsNew, Room)):- 
        Items < 2, 
        ItemsNew is Items + 1.

% Grab Brass Key
action(
    state(Room, BrassKey, Box, Items, Room),
    grab(BrassKey, Room),
    state(SteelKey, hasBrassKey, Box, ItemsNew, Room)):- 
        Items < 2, 
        ItemsNew is Items + 1.

% Grab Box
action(
    state(Room, BrassKey, Box, Items, Room),
    grab(Box, Room),
    state(SteelKey, BrassKey, hasBox, ItemsNew, Room)):- 
        Items < 2, 
        ItemsNew is Items + 1.



% Drop SteelKey
action(
    state(hasSteelKey, BrassKey, Box, Items, Room),
    drop(SteelKey, Room),
    state(Room, BrassKey, Box, ItemsNew, Room)):-
        ItemsNew is Items -1.

% Drop BrassKey
action(
    state(SteelKey, hasBrassKey, Box, Items, Room),
    drop(SteelKey, Room),
    state(SteelKey, Room, Box, ItemsNew, Room)):-
        ItemsNew is Items -1.

% Drop Box
action(
    state(SteelKey, BrassKey, hasBox, Items, Room),
    drop(SteelKey, Room),
    state(SteelKey, BrassKey, Room, ItemsNew, Room)):-
        ItemsNew is Items -1.

%Wincon
solveR(state(_, _, r2, _, _), _,[]). %Om lådan är i rum 2 we good.

%initgame
solveR(State1, N, [Move| Trace2])  :-
    N > 0,
    move(State1, Move, State2),
    N2 is N - 1,
    solveR(State2, N2, Trace2).