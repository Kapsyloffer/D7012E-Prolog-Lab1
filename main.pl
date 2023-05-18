%todo:
%room 1 connects to room 2 and 3, has a steel key
%room 2 has a brass key but requires a steel key to enter
%room 3 has a package but requires the brass key to open
%our robot wants the package

%Write a Prolog program that computes answers to the questions above. If it is possible
%for the robot to deliver the package, your program should produce a list with the actions
%needed given in the order they should be carried out.
%Implement a clause solveR(State,N,Trace) that, given a state State and a positive
%integer N, tries, going no deeper into the state graph that N steps, to find a solution in the
%form of a list Trace of actions taken by the robot. If such a solution can not be found,
%the goal should fail.
%You are free to choose whatever representation of the state as you see fit.

% State representation: state(RobotRoom, RobotItems, Keys)
% RobotRoom: The current room of the robot (r1, r2, or r3)
% RobotItems: The items carried by the robot (a list of keys and the package)
% Keys: The keys available to the robot (a list of keys)

%facts
room(r1).
room(r2).
room(r2).

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

% Item is present in a room
in_room(Item, Room) :- item(Item), room(Room).


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
    \+ Character = hold(_, _),  % Character cannot hold more than two items
    assert(picked_up(Item)).    % Mark item as picked up


%Let the robot drop a specific item
drop(Item, Bot) :-
    robot(Bot),
    robot = hold(Item, _),
    retract(picked_up(Item)),   % Mark item as not picked up
    assert(in_room(Item, Room)). % Mark item as present in the room

%Queries
? - move(Bot, CurRoom, NextRoom).