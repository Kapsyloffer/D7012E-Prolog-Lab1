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


hello_world :-
    write("Hello world!").

%pick up the s_key in room 1

%go to room 2

%pick up the b_key

%go to room 1

%drop the s_key

%go to room 3

%pickup the package

%go to room 1

%drop the package

%win


% recursive steps

move( state( middle, onbox, middle, hasnot),
      grasp,
      state( middle, onbox, middle, has) ).    

move( state( P, onfloor, P, H),
      climb,
      state( P, onbox, P, H) ).   

move( state( P1, onfloor, P1, H),
      push( P1, P2),
      state( P2, onfloor, P2, H) ).

move( state( P1, onfloor, B, H),
      walk( P1, P2),
      state( P2, onfloor, B, H) ).                   

canget( state( _, _, _, has), [done| []]).       

canget( State1, [Move| Trace2])  :-
    move( State1, Move, State2),
    canget( State2, Trace2). 

% canget(state(atdoor,onfloor,atwindow,hasnot), R).