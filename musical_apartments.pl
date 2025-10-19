%% GNU Prolog

start(Sol) :-
    Sol = [A, B, C, D, E, F],
    member(A, [102, 104, 106, 108]),
    member(B, [202, 204, 206, 208]),
    member(C, [302, 304, 306, 308]),
    member(D, [402, 404, 406, 408]),
    member(E, [502, 504, 506, 508]),
    member(F, [602, 604, 606, 608]),
    AB is abs(A - B), AB \= 100,
    BC is abs(B - C), BC \= 100,
    CD is abs(C - D), CD \= 100,
    DE is abs(D - E), DE \= 100,
    EF is abs(E - F), EF \= 100,
    2130 is A + B + C + D + E + F,
    (member(202, Sol); member(404, Sol); member(606, Sol)),
    (member(204, Sol), member(402, Sol);
     member(206, Sol), member(602, Sol);
     member(406, Sol), member(604, Sol)),
    (member(204, Sol), member(608, Sol);
     member(206, Sol), member(606, Sol);
     member(208, Sol), member(604, Sol);
     member(304, Sol), member(508, Sol);
     member(306, Sol), member(506, Sol);
     member(304, Sol), member(508, Sol)).

% above yields [106, 202, 304, 406, 508, 604] for apt. #s.

puzzle(Table) :-  
    FirstName = [Alf, Jan, Kit, Lee, Pat, Sal],
    fd_domain(FirstName, 1, 6), fd_all_different(FirstName),

    LastName = [Davis, Meade, North, Unger, Wyeth, Young],
    fd_domain(LastName, 1, 6), fd_all_different(LastName),

    Instrument = [Bassoon, Cello, Flute, Oboe, Trumpet, Viola],
    fd_domain(Instrument, 1, 6), fd_all_different(Instrument),

    % Logic puzzle constraints.
    % 3.
    North - Trumpet #= 1 #\/ Trumpet - North #= 1,
    % 4.
    (Kit #= 4 #/\ Wyeth #= 6 #\/ Kit #= 6 #/\ Wyeth #= 4) #/\ Flute #= 6,
    % 5.
    Jan - Oboe #= 2 #\/ Oboe - Jan #= 2,
    Jan - Young #= 1 #\/ Young - Jan #= 1,
    Oboe - Young #= 1 #\/ Young - Oboe #= 1,
    % 6.
    Pat #= 2,
    % 7.
    Cello #> Unger #/\ Cello + Unger #= 8,
    % 8.
    Alf - Davis #= 1 #\/ Davis - Alf #= 1,
    % 9.
    Bassoon #= 1 #<=> Trumpet #= 4,
    Trumpet #= 1 #<=> Bassoon #= 4,
    Bassoon #= 3 #<=> Trumpet #= 6,
    Trumpet #= 3 #<=> Bassoon #= 6,
    Bassoon #> Trumpet #==> Bassoon #= Sal,
    Trumpet #> Bassoon #==> Trumpet #= Sal,
    
    fd_labeling(FirstName),
    fd_labeling(LastName),
    fd_labeling(Instrument),
    %print([FirstName, LastName, Instrument]).
    create_table(FirstName, LastName, Instrument, Table).

% This yields the positions of Order elements in List.
get_positions(Order, List, Pos) :-
    findall(P, (member(X, Order), nth1(P, List, X)), Pos).

% This yields the ith elements of List for each i in Order.
get_elements(Order, List, Element) :-
    findall(Element, (member(X, Order), nth1(X, List, Element)), Element).

get_strings(Numbers, Strings, Result) :-
    length(Numbers, N),
    findall(X, between(1, N, X), Enum),
    get_positions(Enum, Numbers, Positions),
    get_elements(Positions, Strings, Result).

transpose([], []).
transpose([[]|_], []).
transpose(T, [Row|Rows]) :- get_1st_col(T, Row, Rest), transpose(Rest, Rows).
get_1st_col([], [], []).
get_1st_col([[H|T]|Rows], [H|Hs], [T|Ts]) :- get_1st_col(Rows, Hs, Ts).

create_table(FirstName, LastName, Instrument, Table) :-
    get_strings(FirstName, ['Alf', 'Jan', 'Kit', 'Lee', 'Pat', 'Sal'], Col2),

    get_strings(LastName, ['Davis', 'Meade', 'North', 'Unger', 'Wyeth',
			   'Young'], Col3),

    get_strings(Instrument, ['bassoon', 'cello', 'flute', 'oboe', 'trumpet',
			     'viola'], Col4),

    Col1 = ['106', '202', '304', '406', '508', '604'],
    transpose([Col1,Col2,Col3,Col4], Table).

print_row(Row) :- format('~20a~20a~20a~20a~n', Row).
print_table(Table) :-
    nl,format('~*c~n', [80, 42]),
    format('~20a~20a~20a~20a~n',
	   ['apartment #', 'first name', 'last name', 'instrument']),
    format('~*c~n', [80, 42]),
    member(Row,Table),print_row(Row),fail.
print_table(Table) :- format('~*c~n', [80, 42]),fail.
