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

%represents a connection between rooms
%door(room1, room2)
door(office, hall).
door(kitchen, office).
door(hall, 'dining room').
door(kitchen, cellar).
door('dining room', kitchen).

%describes foods that are edible
edible(apple).
edible(crackers).

%describes foods that are inedible
tastes_yucky(broccoli).

%start with flashlight off
turned_off(flashlight).

%start location of player at kitchen
here(kitchen).