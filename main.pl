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