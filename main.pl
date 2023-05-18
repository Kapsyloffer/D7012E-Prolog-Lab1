%rooms
room(r1).
room(r2).
room(r2).

%items
item(box).
item(steelKey).
item(brassKey).

%room connections
connected(r1, r2).
connected(r1, r3).

%the robot
robot(B) :-
    item(I1), item(I2). % 2 inventory slots
    B = hold(I1, I2).

room_item(I, R) :-
    item(I), room(R).

%key requirement for the doors
requires_key(2, steelkey).
requires_key(3, brasskey).

%If an item is in the room
in_room(Item, Room) :- item(Item), room(Room), \+ picked_up(Item).

%we can only access a room if we have the key
can_access(Bot, Room) :-
    room(Room),
    (
        \+ requires_key(Room, _) %either no access because no key
        ; % or
        requires_key(Room, Key),
        Bot = hold(Key, _) %%access because key
    ).

% Item has been picked up
picked_up(Item) :- pick_up(Item, _, _).

%moves
%allow the robot to move
move(Bot, CurRoom, NextRoom):-
    room(CurRoom).
    room(NextRoom).
    connected(CurRoom, NextRoom).
    robot(Bot).

%The robot picks up an item in the room
pick_up(Item, Room, Bot) :-
    in_room(Item, Room),
    robot(Bot),
    \+ Bot = hold(_, _),  % The robot cannot hold more than 2 items
    assert(picked_up(Item)).    % Mark it as picked up.

%Let the robot drop a specific item
drop(Item, Bot) :-
    robot(Bot),
    Bot = hold(Item, _),
    retract(picked_up(Item)),   % Mark the item not picked up
    assert(in_room(Item, Room)). % Place it in the room

%Queries
? - move(Bot, CurRoom, NextRoom).
? - can_access(Bot, Room).
% ? - pick_up
% ? - drop