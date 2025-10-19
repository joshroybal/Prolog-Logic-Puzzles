% X is positions, Y is strings.
start(X) :-
    Strings = ['red', 'yellow', 'green'],
    Positions = [First, Second, Third], fd_domain(Positions, 1, 3),
    fd_all_different(Positions), fd_labeling(Positions),
    get_strings(Positions, Strings, X).

% this yields the elements
%get_indices(List1, List2, Indices) :-
%    findall(Idx, (member(X, List2), nth1(Idx, List1, X)), Indices).

% This yields the positions of Order elements in List.
get_positions(Order, List, Pos) :-
    findall(Pos, (member(X, Order), nth1(Pos, List, X)), Pos).

% This yields the ith elements of List for each i in Order.
get_elements(Order, List, Element) :-
    findall(Element, (member(X, Order), nth1(X, List, Element)), Element).

get_strings(Numbers, Strings, Result) :-
    length(Numbers, N),
    findall(X, between(1, N, X), Enum),
    get_positions(Enum, Numbers, Positions),
    get_elements(Positions, Strings, Result).

enumerate(A, B, Enum) :-
    findall(X, between(A, B, X), Enum).
