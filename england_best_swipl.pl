:- use_module(library(clpfd)).

puzzle(Table) :-
    AllVars = [Americans, Cities, Occupations],
    Americans = [Earl, Gene, Hiram, Homer, Wilbur],
    Cities = [Boston, Denver, LA, NYC, Toledo],
    Occupations = [Army, Bootleggers, Journalists, Ship, Students],
    maplist(all_distinct, AllVars),
    append(AllVars, Vs),
    Vs ins 1..5,
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
    label(Vs),
    create_table(Americans, Cities, Occupations, Table).

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

create_table(Americans, Cities, Occupations, Table) :-
    get_strings(Americans, ['Earl K. Gunter', 'Gene Noble III', 'Hiram Berkley',
			    'Homer Fanning', 'Wilbur McGann'], Col2),

    get_strings(Cities, ['Boston', 'Denver', 'Los Angeles', 'New York',
			 'Toledo'], Col3),

    get_strings(Occupations, ['army officers', 'bootleggers', 'journalists',
			      "ship's officers", 'students'], Col4),

    Col1 = ['Archie Frotheringhay', 'Edward Tanqueray', 'Gerald Huntington',
	    'Montague Ffolliott', 'Rupert de Grey'],
    transpose([Col1,Col2,Col3,Col4], Table).

print_table(Table) :-
    format('~n~`=t~80|~n'),
    format('~w~t~20|~w~t~40|~w~t~60|~w~n',
           ['Drone', 'American', 'City', 'Occupations']),
    format('~`=t~80|~n'),
    forall(member([Drone, American, City, Occupation], Table),
           format('~w~t~20|~w~t~40|~w~t~60|~w~n', [Drone, American, City,
						   Occupation])),
    format('~`=t~80|~n').

:- puzzle(Table),print_table(Table),nl,fail.
