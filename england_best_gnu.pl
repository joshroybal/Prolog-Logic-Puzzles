append_list_of_lists([], []).
append_list_of_lists([H|T], Result) :-
    append_list_of_lists(T, TailResult),
    append(H, TailResult, Result).

puzzle(Table) :-
    AllVars = [Americans, Cities, Occupations],
    Americans = [Earl, Gene, Hiram, Homer, Wilbur],
    Cities = [Boston, Denver, LA, NYC, Toledo],
    Occupations = [Army, Bootleggers, Journalists, Ship, Students],
    maplist(fd_all_different, AllVars),
    append_list_of_lists(AllVars, Vs),
    fd_domain(Vs, 1, 5),
    % logical constraints
    % 1.
    LA #= Journalists #/\ LA #\= 1,
    % 2.
    Earl #= 3 #/\ Earl #\= Army #/\ Earl #\= Ship,
    % 3.
    Hiram #= Toledo #/\ Hiram #\= 1,
    % 4.
    Students #= 5,
    % 5.
    Gene #\= 4 #/\ Army #\= 4 #/\ Boston #= 4 #/\ Toledo #\= 2,
    % 6.
    Bootleggers #\= Homer #/\ Bootleggers #\= Boston #/\ Bootleggers #\= Denver,
    % 7.
    Homer #\= Denver #/\ Homer #\= Ship,
    fd_labeling(Vs),
    create_table(Americans, Cities, Occupations, Table).

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

create_table(Americans, Cities, Occupations, Table) :-
    get_strings(Americans, ['Earl K. Gunter', 'Gene Noble III', 'Hiram Berkley',
			    'Homer Fanning', 'Wilbur McGann'], Col2),

    get_strings(Cities, ['Boston', 'Denver', 'Los Angeles', 'New York',
			 'Toledo'], Col3),

    atom_codes(ShipsOfficers, "Ship's Officers"),
    get_strings(Occupations, ['Army officers', 'Bootleggers', 'Journalists',
			      ShipsOfficers, 'Students'], Col4),

    Col1 = ['Archie Frotheringhay', 'Edward Tanqueray', 'Gerald Huntington',
	    'Montague Ffolliott', 'Rupert de Grey'],
    transpose([Col1,Col2,Col3,Col4], Table).

print_row(Row) :- format('~20a~20a~20a~20a~n', Row).
print_table(Table) :- member(Row,Table),print_row(Row),fail.
