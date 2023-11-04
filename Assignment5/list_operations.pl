% Implement the procedures below.
% It's ok if a query seems to "hang" as if there is another answer,
% and then produce false if another answer is requested from the user.

% 1. TODO: Write a procedure named myFirst that takes:
%    1.) A list
%    2.) The first element of the list
% Example queries follow:
% ?- myFirst([1, 2, 3], X).
% X = 1.
% ?- myFirst([], X).
% false.
%
% Code expectation: 1 line

myFirst([H|_], H).

% 2. TODO: Write a procedure named myLast that takes:
%    1.) A list
%    2.) The last element of the list
% Example queries follow:
% ?- myLast([1, 2, 3], X).
% X = 3 .
% ?- myLast([1], X).
% X = 1 .
% ?- myLast([], X).
% false.
%
% Code expectation: ~3 lines

myLast([T], T).
myLast([_|T], Tail) :-
    myLast(T, Tail).

% 3. TODO: Write a procedure named myInit that takes:
%    1.) A list
%    2.) All the elements of the previous list, without
%        the last element.
% Example queries follow:
% ?- myInit([], X).
% false.
% ?- myInit([1,2,3], X).
% X = [1, 2] .
% ?- myInit([1], X).
% X = [] .
%
% Code expectation: ~3 lines

myInit([_], []).
myInit([H|T], [H|Result]) :-
    myInit(T, Result).

% 4. TODO: Write a procedure named myAppend that takes:
%    1.) A list
%    2.) A second list
%    3.) The result of appending the first and second lists
%        together
% Example queries follow:
% ?- myAppend([1, 2, 3], [4, 5, 6], X).
% X = [1, 2, 3, 4, 5, 6].
% ?- myAppend([], [1, 2, 3], X).
% X = [1, 2, 3].
% ?- myAppend(L1, L2, [1, 2, 3]).
% L1 = [],
% L2 = [1, 2, 3] ;
% L1 = [1],
% L2 = [2, 3] ;
% L1 = [1, 2],
% L2 = [3] ;
% L1 = [1, 2, 3],
% L2 = [] ;
% false.
%
% Note that semicolon (;) was repeatedly pressed in the
% third query above to get all the solutions.
% Code expectation: ~3 lines

myAppend([], List2, List2).
myAppend([H|T], List2, [H|AppendList]) :-
    myAppend(T, List2, AppendList).

% 5. TODO: Write a procedure named myLength that takes:
%    1.) A list
%    2.) The length of that list, as an integer
% You may assume that the list will always be provided.
% Example queries follow:
% ?- myLength([], N).
% N = 0.
% ?- myLength([foo], N).
% N = 1.
% ?- myLength([foo, bar], N).
% N = 2.
% ?- myLength([foo, bar, baz], N).
% N = 3.
%
% Code expectation: ~4 lines

myLength([], 0).
myLength([_|T], Length) :-
    myLength(T, NewLength),
    Length is NewLength + 1.

% 6. TODO: Write a procedure named myFlatten that takes:
%    1.) A possibly nested list
%    2.) A "flattened" version of the list, with all the
%        nested lists removed
% You may assume that the first parameter will always be
% provided.
% Example queries follow:
% ?- myFlatten([], Result).
% Result = [].
% ?- myFlatten([1, 2, 3], Result).
% Result = [1, 2, 3].
% ?- myFlatten([[1, 2, 3]], Result).
% Result = [1, 2, 3] .
% ?- myFlatten([[1, 2, 3], [4, 5, 6]], Result).
% Result = [1, 2, 3, 4, 5, 6] .
% ?- myFlatten([[1, [2, 3]], [[4, 5], 6]], Result).
% Result = [1, 2, 3, 4, 5, 6] .
%
% As a hint, \= can be used to determine if two
% terms do NOT unify; for example, [] \= [A]
% succeeds.
%
% Code expectation: ~12 lines

%No more items to add
myFlatten([], []).

%Head is not a list and we append it to Flatten
myFlatten([H|T], [H|Flatten]) :-
    H \= [_|_],
    H \= [_],
    myFlatten(T, Flatten).

%Given list has a List as the Head,
%Head is a List with only 1 elt
myFlatten([[H]|T], [H|Flatten]) :-
    myFlatten(T, Flatten).

%Given list has a List as the Head,
%Head is a List with multiple elts,
myFlatten([[H2|T2]|T], Flatten) :-
    %First obtain the Flattened Tail
    myFlatten(T, TailFlatten),

    %Now we break apart the Head's List
    %Start from the end, so do T2
    myFlatten(T2, TailTwoFlatten),
    
    %append The flattened List of T2 to T
    myAppend(TailTwoFlatten, TailFlatten, TFlatten),

    %Flatten H2
    myFlatten([H2], HeadTwoFlatten),

    %append the flattened list of H2 to TFlatten
    myAppend(HeadTwoFlatten, TFlatten, Flatten).

% 7. TODO: Write a procedure named insertPosition that
%    takes:
%    1.) A list
%    2.) An element to insert into the list
%    3.) A position at which to insert the element, starting
%        from zero
%    4.) The resulting list after performing the insertion
% You may assume that the first three parameters will always
% be provided.
% Example queries follow:
% ?- insertPosition([], foo, 0, Result).
% Result = [foo].
% ?- insertPosition([], foo, 1, Result).
% false.
% ?- insertPosition([foo, bar, baz], blah, 0, Result).
% Result = [blah, foo, bar, baz] .
% ?- insertPosition([foo, bar, baz], blah, 1, Result).
% Result = [foo, blah, bar, baz] .
% ?- insertPosition([foo, bar, baz], blah, 2, Result).
% Result = [foo, bar, blah, baz] .
% ?- insertPosition([foo, bar, baz], blah, 3, Result).
% Result = [foo, bar, baz, blah].
% ?- insertPosition([foo, bar, baz], blah, 4, Result).
% false.
%
% Code expectation: ~5 lines


%This one is a little longer than expected because I wanted
%to ensure that the bounds on Position were valid.

%list is empty and add at head
insertPosition([], Elt, 0, [Elt]).

%list is nonempty and add at head
insertPosition([H|T], Elt, 0, [Elt, H|T]).

%list is nonempty and add at non-head position
insertPosition([H|T], Elt, Position, [H|NewList]) :-
    Position >= 0,
    myLength([H|T], Len),
    Position =< Len,
    NewPosition is Position - 1,
    insertPosition(T, Elt, NewPosition, NewList).

% 8. TODO: Write a procedure named insertSorted that takes:
%    1.) A sorted list of integers
%    2.) An integer to insert
%    3.) The result of inserting the integer into the list
%        where the resulting list will be sorted.
% You may assume the first two parameters will always be
% provided.
% You do not need to worry about efficiency.
% Example queries follow:
% ?- insertSorted([], 5, Result).
% Result = [5].
% ?- insertSorted([1, 2, 3, 4], 5, Result).
% Result = [1, 2, 3, 4, 5].
% ?- insertSorted([1, 2, 3, 4], 0, Result).
% Result = [0, 1, 2, 3, 4] .
% ?- insertSorted([1, 2, 3, 4], 3, Result).
% Result = [1, 2, 3, 3, 4] .
%
% Code expectation: ~6 lines

%List is empty
insertSorted([], Int, [Int]).

%List is nonempty and Int =< H
insertSorted([H|T], Int, [Int, H|T]) :-
    Int =< H.

%List is nonempty and Int > H
insertSorted([H|T], Int, [H|InList]) :-
    Int > H,
    insertSorted(T, Int, InList).

% 9. TODO: Write a procedure named insertionSort that
%    takes:
%    1.) A possibly unsorted list of integers
%    2.) The same integers, sorted in ascending order.
% You may assume the first parameter will always be provided.
% Example queries follow:
% ?- insertionSort([], Result).
% Result = [].
% ?- insertionSort([1, 2, 3], Result).
% Result = [1, 2, 3].
% ?- insertionSort([3, 2, 1], Result).
% Result = [1, 2, 3] .
% ?- insertionSort([3, 1, 2], Result).
% Result = [1, 2, 3] .
%
% The following hints may come in handy:
% 1.) You will likely need to introduce a helper procedure
%     which takes an accumulator
% 2.) insertSorted can be used to help
% 3.) Empty lists are always sorted
%
% Code expectation: ~6 lines

%empty list to sort
insertionSort([], []).

%only 1 elt in list to sort
insertionSort([H], [H]).

%nonempty list to sort of > 1 elt
insertionSort([H|T], Sorted) :-
    %sort T => TSorted
    insertionSort(T, TSorted),
    
    %insert H into TSorted
    insertSorted(TSorted, H, Sorted).
