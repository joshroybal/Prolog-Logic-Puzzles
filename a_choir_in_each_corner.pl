puzzle(Table) :-
    Corners = [NE, SE, SW, NW],
    NE #= 1, SE #= 2, SW #=3, NW #=4,
    Choirs = [Middlehampton, Norcross, StJohns, SalvationArmy],
    fd_domain(Choirs, 1, 4), fd_all_different(Choirs),
    ChoirLabels = ['Middlehampton Choral Society', 'Norcross School',
		   'St John''s Church', 'Salvation Army'],
    Times = [AM10, PM1230, PM3, PM530],
    fd_domain(Times, 1, 4), fd_all_different(Times),
    Types = [Pops, International, Modern, Traditional],
    fd_domain(Types, 1, 4), fd_all_different(Types),

    fd_labeling(Choirs), fd_labeling(Times), fd_labeling(Types),

    %1.
    SalvationArmy #= Traditional, SalvationArmy #\= NW,
    SalvationArmy #\= AM10, NW #\= PM530,
    (SalvationArmy #= PM1230) #==> (NW #= AM10),
    (SalvationArmy #= PM3) #==> (NW #= PM1230),
    (SalvationArmy #= PM530) #==> (NW #= PM3),
    % 2.
    Norcross #= PM3,
    % 3.
    StJohns #\= SE, StJohns #\= Modern,
    % 4.
    PM530 #= International,
    % 5.
    Pops #= SW,

    %fd_labeling(Choirs), fd_labeling(Times), fd_labeling(Types),

    %Table = [Corners, Choirs, Times, Types],
    %print(Table),nl,
    Table = [['NE', Choir1, Time1, Type1],
	     ['SE', Choir2, Time2, Type2],
	     ['SW', Choir3, Time3, Type3],
	     ['NW', Choir4, Time4, Type4]],
    %nl,member(Row,Sol),print(Row),nl,fail,

    get_strings(Choirs, ['Middlehampton','Norcross','St John','Salvation Army'],
		ChoirCol),
    [Choir1, Choir2, Choir3, Choir4] = ChoirCol,

    get_strings(Times, ['10:00 AM','12:30 PM','3:00 PM','5:30 PM'], TimeCol),
    [Time1, Time2, Time3, Time4] = TimeCol,

    get_strings(Types, ['Christmas Pops', 'International', 'Modern',
			'Traditional'], TypeCol),
    [Type1, Type2, Type3, Type4] = TypeCol.

    %% nth1(Choir1, Choirs, 1), nth1(Choir2, Choirs, 2),
    %% nth1(Choir3, Choirs, 3), nth1(Choir4, Choirs, 4),

    %% nth1(Time1, Times, 1), nth1(Time2, Times, 2),
    %% nth1(Time3, Times, 3), nth1(Time4, Times, 4),

    %% nth1(Type1, Types, 1), nth1(Type2, Types, 2),
    %% nth1(Type3, Types, 3), nth1(Type4, Types, 4),
    %% member(Row,Sol),print(Row),nl,fail.

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
