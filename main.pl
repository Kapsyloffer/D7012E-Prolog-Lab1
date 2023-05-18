%rooms
room(r1).
room(r2).
room(r3).

%items
item(box).
item(steelKey).
item(brassKey).

%room connections
connected(r1, r2).
connected(r1, r3).

%the robot
robot(B) :-
    item(I1), item(I2), % 2 inventory slots
    B = hold(I1, I2).

%place items in the room
room_item(I, R) :-
    item(I), room(R).

%key requirement for the doors
requires_key(r1, r2, steelKey).
requires_key(r2, r1, steelKey).
requires_key(r1, r3, brassKey).
requires_key(r3, r1, brassKey).

%If an item is in the room
in_room(Item, Room) :- item(Item), room(Room).

%we can only access a room if we have the key
can_access(Bot, CurRoom, NextRoom) :-
    room(NextRoom),
    (
        \+ requires_key(CurRoom, NextRoom, _)
        ;
        requires_key(CurRoom, NextRoom, Key),
        Bot = hold(Key, _)
    ).

%moves
%allow the robot to move
move(Bot, CurRoom, NextRoom):-
    room(CurRoom),
    room(NextRoom),
    connected(CurRoom, NextRoom),
    robot(Bot).

%The robot picks up an item in the room
pick_up(Bot, Room, Item) :-
    in_room(Item, Room),
    robot(Bot),
    \+ Bot = hold(_, _),  % The robot cannot hold more than 2 items
    assert(picked_up(Item)).    % Mark it as picked up.

% Let the robot drop a specific item
drop(Bot, Room, Item) :-
    robot(Bot),
    Bot = hold(Item, _),
    room_item(Item, Room).

% Solve the problem within N steps
solveR(State, N, Trace) :-
    solveR(State, State, N, [], Trace).

solveR(_, _, 0, _, _) :-
    fail. % No solution found within N steps.

solveR(_, _, 0, Trace, Trace) :-
    in_room(box, r2).

solveR(State, Bot, N, AccTrace, Trace) :-
    N > 0,
    move(Bot, CurRoom, NextRoom),
    NewN is N - 1,
    solveR(State, Bot, NewN, [move(Bot, CurRoom, NextRoom) | AccTrace], Trace).

solveR(State, Bot, N, AccTrace, Trace) :-
    N > 0,
    drop(Bot, CurRoom, Item),
    NewN is N - 1,
    solveR(State, Bot, NewN, [drop(Bot, CurRoom, Item) | AccTrace], Trace).

solveR(State, Bot, N, AccTrace, Trace) :-
    N > 0,
    pick_up(Bot, CurRoom, Item),
    NewN is N - 1,
    solveR(State, Bot, NewN, [pick_up(Bot, CurRoom, Item) | AccTrace], Trace).
