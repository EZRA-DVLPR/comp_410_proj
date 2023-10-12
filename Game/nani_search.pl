%used to show that there are dynamic procedures
:- dynamic
    here/1,
    turnedOff/1.

%defines what constitutes a room
room(kitchen).
room(office).
room(hall).
room('dining room').
room(cellar).

%location(item, room it's located)
location(desk, office).
location(apple, kitchen).
location(flashlight, desk).
location('washing machine', cellar).
location(nani, 'washing machine').
location(broccoli, kitchen).
location(crackers, kitchen).
location(computer, office).
location(envelope, desk).
location(stamp, envelope).
location(key, envelope).

%locations towards new objects with associated descriptions
%in the location specified
%object contains(item, color, size, weight)
locationS(object(candle, red, small, 1), kitchen).
locationS(object(apple, red, small, 1), kitchen).
locationS(object(apple, green, small, 1), kitchen).
locationS(object(table, blue, big, 50), kitchen).

%represents a connection between rooms
%door(room1, room2)
door(office, hall).
door(kitchen, office).
door(hall, 'dining room').
door(kitchen, cellar).
door('dining room', kitchen).

%describes all connections between 2 rooms X,Y
connect(X,Y) :-
    door(X,Y).

connect(X,Y) :-
    door(Y,X).

%describes foods that are edible
edible(apple).
edible(crackers).

%describes foods that are inedible
tastesYucky(broccoli).

%start with flashlight off
turnedOff(flashlight).

%start location of player at kitchen
here(kitchen).

%lists all items within a location
listThings(Place) :-
    location(X, Place),
    tab(2),
    write(X),
    nl,
    fail.
listThings(_).

%better description for list of things in a given Place
listThingsS(Place) :-  
    locationS(object(Thing, Color, Size, Weight),Place),
    write('A '),write(Size),tab(1),
    write(Color),tab(1),
    write(Thing), write(', weighing '),
    writeWeight(Weight), nl,
    fail.
listThingsS(_).

%lists all connections for the specified location
listConnections(Place) :-
    connect(Place, X),
    tab(2),
    write(X),
    nl,
    fail.
listConnections(_).

%displays relevant info based on the current location
look :-
    here(Place),
    write('You are in the '), write(Place), nl,
    write('You can see:'), nl,
    listThings(Place),
    write('You can go to:'), nl,
    listConnections(Place).

%moves the player to the specified Place if possible
goTo(Place) :-
    canGo(Place),
    move(Place),
    look.

%checks if the player can move to the specified Place
canGo(Place) :-
    here(X),
    connect(X, Place).
%error msg to user if not possible
canGo(Place) :-
    write('You can''t get to'),
    write(Place),
    write('from here.'), nl,
    fail.

%moves the location of the player to Place
move(Place) :-
    write('Moving from'), write(here(X)),
    write('to'), write(Place),
    retract(here(X)),
    asserta(here(Place)).

%takes the given object X if possible
take(Object) :-
    canTake(Object),
    takeObject(Object).

%checks if the item can be taken
canTake(Object) :-
    here(Place),
    location(Object, Place).
%on Failure
canTake(Object) :-
    write('There is no '), write(Object),
    write(' here.'),
    nl, fail.
canTakeS(Object) :-
    here(Room),
    locationS(object(Object, _, small, _), Room).
canTakeS(Object) :-
    here(Room),
    locationS(object(Object, _, big, _), Room),
    write('The '), write(Object), 
    write(' is too big to carry.'), nl,
    fail.
canTakeS(Object) :-
    here(Room),
    not(locationS(object(Object, _, _, _), Room)),
    write('There is no '), write(Object), write(' here.'), nl,
    fail.

%removes the object from the location and adds to player inventory
takeObject(Object):-  
    retract(location(Object,_)),
    asserta(have(Object)),
    write('taken'), nl.

%determines if Object is in Location
isContainedIn(Object, Location) :-
    location(Object, Location).
isContainedIn(Object, Location) :-
    location(X, Location),
    isContainedIn(Object, X).

%ALTERNATIVE APPROACH 
%is_contained_in(T1,T2):-
%   location(X,T2),
%   is_contained_in(T1,X).
%is_contained_in(T1,T2):-
%   location(T1,X),
%   is_contained_in(X,T2).

%used to write the weight grammatically correct
writeWeight(1) :-
    write('1 pound').
writeWeight(W) :-
    W > 1,
    write(W), write(' pounds').