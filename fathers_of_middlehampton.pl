:- use_module(library(clpfd)).

puzzle(Table) :-
    AllVars = [Name, Title, Costume],
    Name = [Withers, Pateman, Rudhall, Steggall, Monk, Fawley],
    Title = [Castlebury, Doltingham, Gibbleton, Luskford, Mountdenis, Rufflock],
    Costume = [Robes, Armor, Frock, Highland, Military, Toga],
    maplist(all_distinct, AllVars),
    append(AllVars, Vs),
    Vs ins 1..6,

    % Logic puzzle constraints.
    % 1.
    Rudhall #= Toga,
    above(Rudhall, Gibbleton),
    same_level(Gibbleton, Military),
    % 2.
    Rufflock #= 4,
    % 3.
    same_level(Doltingham, Fawley),
    % 4.
    Castlebury #\= 5 #/\ Doltingham #\= 5 #/\ Mountdenis #\= 5,
    % 5.
    Monk #= 2,
    % 6.
    Steggall #= Luskford #/\ Steggall #\= Armor,
    Castlebury #\= Withers,
    above(Castlebury, Pateman),
    abs(Castlebury - Pateman) #\= 2, % not on same side!
    % 7.
    Mountdenis #= Highland,
    % 8.
    Robes #= 3,

    label(Vs),
    create_table(Name, Title, Costume, Table).

% above(X, Y) :- X #> 2, Y #< 5, (X #= 5 #\/ X #= 6) #<==> (Y #= 3 #\/ Y
% #= 4).
% above(X, Y) :- X #> 2, Y #< 5, (X #= 3 #\/ X #= 4) #<==> (Y #= 1 #\/ Y
% #= 2).

above(X, Y) :- (X #= 5 #\/ X #= 6) #/\ (Y #= 3 #\/ Y #= 4).
above(X, Y) :- (X #= 3 #\/ X #= 4) #/\ (Y #= 1 #\/ Y #= 2).

same_level(X, Y) :- (X #= 1 #/\ Y #= 2) #\/ (X #= 2 #/\ Y #= 1).
same_level(X, Y) :- (X #= 3 #/\ Y #= 4) #\/ (X #= 4 #/\ Y #= 3).
same_level(X, Y) :- (X #= 5 #/\ Y #= 6) #\/ (X #= 6 #/\ Y #= 5).

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

create_table(Name, Title, Costume, Table) :-
    get_strings(Name, ['Alexander Withers', 'Herbert Pateman', 'Mervyn Rudhall',
                       'Osmond Steggall', 'Septimus Monk', 'Wilfred Fawley'],
                Col2),

    get_strings(Title, ['Lord Castlebury', 'Lord Doltingham', 'Lord Gibbleton',
                        'Lord Luskford', 'Lord Mountdenis', 'Lord Rufflock'],
                Col3),

    get_strings(Costume, ['academic robes', 'armour', 'frock coat',
                          'Highland dress', 'military uniform', 'toga'], Col4),

    Col1 = ['A', 'B', 'C', 'D', 'E', 'F'],
    transpose([Col1,Col2,Col3,Col4], Table).

print_table(Table) :-
    format('~n~`=t~80|~n'),
    format('~w~t~20|~w~t~40|~w~t~60|~w~n',
           ['Statue', 'Name', 'Title', 'Costume']),
    format('~`=t~80|~n'),
    forall(member([Statue, Name, Title, Costume], Table),
           format('~w~t~20|~w~t~40|~w~t~60|~w~n', [Statue, Name, Title,
                                                   Costume])),
    format('~`=t~80|~n').
