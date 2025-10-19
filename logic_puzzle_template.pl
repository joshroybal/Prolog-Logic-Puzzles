puzzle(Table) :-
    Col1 = [1, 2, 3, 4, 5, 6, 7],

    Col2 = [_, _, _, _, _, _, _],
    fd_domain(Col2, 1, 7), fd_all_different(Col2),

    Col3 = [_, _, _, _, _, _, _],
    fd_domain(Col3, 1, 7), fd_all_different(Col3),

    Col4 = [_, _, _, _, _, _, _],
    fd_domain(Col4, 1, 7), fd_all_different(Col4),    

    % Puzzle Constraints  

    fd_labeling(Col2), fd_labeling(Col3), fd_labeling(Col4),
    create_table(Col2, Col3, Col4, Table).

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

create_table(Col2, Col3, Col4, Result) :-
    % fixed headers can be relatively static
    [R11, R21, R31, R41, R51, R61, R71] = ['', '', '', '', '', '', ''],

    get_strings(Col2, ['', '', '', '', '', '',''], B),
    [R12, R22, R32, R42, R52, R62, R72] = B,

    get_strings(Col3, ['', '', '', '', '', '', ''], C),
    [R13, R23, R33, R43, R53, R63, R73] = C,

    get_strings(Col4, ['', '', '', '', '', '', ''], D),
    [R14, R24, R34, R44, R54, R64, R74] = D,

    Result = [[R11, R12, R13, R14],
	      [R21, R22, R23, R24],
	      [R31, R32, R33, R34],
	      [R41, R42, R43, R44],
	      [R51, R52, R53, R54],
	      [R61, R62, R63, R64],
	      [R71, R72, R73, R74]].
