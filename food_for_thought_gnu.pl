%% append_list_of_lists([], []).
%% append_list_of_lists([H|T], Result) :-
%%     append_list_of_lists(T, TailResult),
%%     append(H, TailResult, Result).

append_list_of_lists(Lists, Result) :-
    append_list_of_lists_acc(Lists, [], ResultRev),
    reverse(ResultRev, Result).

append_list_of_lists_acc([], Acc, Acc).
append_list_of_lists_acc([H|T], Acc, Result) :-
    reverse(H, HR),
    append(HR, Acc, NewAcc),
    append_list_of_lists_acc(T, NewAcc, Result).


puzzle(Table) :-
    %AllVars = [Food, Favorite, Hate],
    Food = [Avocados, Bananas, Chicken, Dates, Eggs, Fish],
    fd_domain(Food, 1, 6), fd_all_different(Food),

    Favorite = [AliceFavorite, BeaFavorite, ChrisFavorite, DonaldFavorite,
		EvanFavorite, FloraFavorite],
    fd_domain(Favorite, 1, 6), fd_all_different(Favorite),

    Hate = [AliceHate, BeaHate, ChrisHate, DonaldHate, EvanHate, FloraHate],
    fd_domain(Hate, 1, 6), fd_all_different(Hate),

    %maplist(fd_all_different, AllVars),
    %append_list_of_lists(AllVars, Vs),
    %fd_domain(Vs, 1, 6),
    
    % logical constraints
    maplist(#\=, Favorite, Hate),
    % 1.
    immediately_before(Dates, Chicken),
    % 2.
    BeaFavorite #\= Avocados #/\ FloraHate #\= Avocados #/\ Avocados #>= 3,
    % 3.
    immediately_before(AliceFavorite, AliceHate),
    % 4.
    DonaldFavorite #=< 4,
    % 5.
    EvanFavorite #=< 2, immediately_before(EvanFavorite, EvanHate),
    AliceFavorite #=< 2 #<=> (AliceHate #= 3 #\/ AliceHate #= 4),
    BeaFavorite #=< 2 #<=> (BeaHate #= 3 #\/ BeaHate #= 4),
    ChrisFavorite #=< 2 #<=> (ChrisHate #= 3 #\/ ChrisHate #= 4),
    DonaldFavorite #=< 2 #<=> (DonaldHate #= 3 #\/ DonaldHate #= 4),
    FloraFavorite #=< 2 #<=> (FloraHate #= 3 #\/ FloraHate #= 4),
    % 6.
    AliceFavorite #\= Bananas #/\ AliceHate #\= Dates,
    % Bananas and Dates can't be a favorite, hates combination.
    % 7.
    AliceFavorite #\= Avocados #/\ AliceHate #\= Avocados,
    BeaFavorite #\= Bananas #/\ BeaHate #\= Bananas,
    ChrisFavorite #\= Chicken #/\ ChrisHate #\= Chicken,
    DonaldFavorite #\= Dates #/\ DonaldHate #\= Dates,
    EvanFavorite #\= Eggs #/\ EvanHate #\= Eggs,
    FloraFavorite #\= Fish #/\ FloraHate #\= Fish,
    % 8. [_,_,_]

    (BeaFavorite #\= Bananas #/\ BeaHate #\= Dates)
    #==>
    (BeaFavorite #\= 3 #/\ BeaFavorite #\= 4 #/\ BeaHate #\= 5 #/\ BeaHate #\= 6),
    (ChrisFavorite #\= Bananas #/\ ChrisHate #\= Dates)
    #==>
    (ChrisFavorite #\= 3 #/\ ChrisFavorite #\= 4 #/\ ChrisHate #\= 5 #/\ ChrisHate #\= 6),

    (DonaldFavorite #\= Bananas #/\ DonaldHate #\= Dates)
    #==>
    (DonaldFavorite #\= 3 #/\ DonaldFavorite #\= 4 #/\ DonaldHate #\= 5 #/\ DonaldHate #\= 6),

    (EvanFavorite #\= Bananas #/\ EvanHate #\= Dates)
    #==>
    (EvanFavorite #\= 3 #/\ EvanFavorite #\= 4 #/\ EvanHate #\= 5 #/\ EvanHate #\= 6),

    (FloraFavorite #\= Bananas #/\ FloraHate #\= Dates)
    #==>
    (FloraFavorite #\= 3 #/\ FloraFavorite #\= 4 #/\ FloraHate #\= 5 #/\ FloraHate #\= 6),
    % 9.
    same_meal(FloraFavorite, FloraHate),
    % 10.
    not_exact_opposites(AliceFavorite, AliceHate, BeaFavorite, BeaHate),
    not_exact_opposites(AliceFavorite, AliceHate, ChrisFavorite, ChrisHate),
    not_exact_opposites(AliceFavorite, AliceHate, DonaldFavorite, DonaldHate),
    not_exact_opposites(AliceFavorite, AliceHate, EvanFavorite, EvanHate),
    not_exact_opposites(AliceFavorite, AliceHate, FloraFavorite, FloraHate),
    not_exact_opposites(BeaFavorite, BeaHate, ChrisFavorite, ChrisHate),
    not_exact_opposites(BeaFavorite, BeaHate, DonaldFavorite, DonaldHate),
    not_exact_opposites(BeaFavorite, BeaHate, EvanFavorite, EvanHate),
    not_exact_opposites(BeaFavorite, BeaHate, FloraFavorite, FloraHate),
    not_exact_opposites(ChrisFavorite, ChrisHate, DonaldFavorite, DonaldHate),
    not_exact_opposites(ChrisFavorite, ChrisHate, EvanFavorite, EvanHate),
    not_exact_opposites(ChrisFavorite, ChrisHate, FloraFavorite, FloraHate),
    not_exact_opposites(DonaldFavorite, DonaldHate, EvanFavorite, EvanHate),
    not_exact_opposites(DonaldFavorite, DonaldHate, FloraFavorite, FloraHate),
    not_exact_opposites(EvanFavorite, EvanHate, FloraFavorite, FloraHate),

    %fd_labeling(Vs),
    fd_labeling(Food),
    fd_labeling(Favorite),
    fd_labeling(Hate),
    %Table = [Food, Favorite, Hate].
    create_table(Food, Favorite, Hate, Table).

immediately_before(X, Y) :- X #\= Y
			    #/\
			    (X #= 1 #\/ X #= 2) #/\ (Y #= 3 #\/ Y #= 4).
immediately_before(X, Y) :- X #\= Y
			    #/\
			    (X #= 3 #\/ X #= 4) #/\ (Y #= 5 #\/ Y #= 6).

same_meal(X, Y) :- X #\= Y #/\ (X #= 1 #\/ X #= 2) #/\ (Y #= 1 #\/ Y #= 2).
same_meal(X, Y) :- X #\= Y #/\ (X #= 3 #\/ X #= 4) #/\ (Y #= 3 #\/ Y #= 4).
same_meal(X, Y) :- X #\= Y #/\ (X #= 5 #\/ X #= 6) #/\ (Y #= 5 #\/ Y #= 6).

not_exact_opposites(F1, F2, H1, H2) :-
    F1 #\= H2 #\/ F2 #\= H1.

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

create_table(Food, Favorite, Hate, Table) :-
    get_strings(Food, ['avocados', 'bananas', 'chicken', 'dates', 'eggs',
		       'fish'], Col2),

    get_strings(Favorite, ['Alice', 'Bea', 'Chris', 'Donald', 'Evan', 'Flora'],
		Col3),

    get_strings(Hate, ['Alice', 'Bea', 'Chris', 'Donald', 'Evan', 'Flora'],
		Col4),

    Col1 = ['Breakfast', 'Breakfast', 'Lunch', 'Lunch', 'Dinner', 'Dinner'],
    transpose([Col1,Col2,Col3,Col4], Table).

print_row(Row) :- format('~20a~20a~20a~20a~n', Row).
print_table(Table) :-
    nl,format('~*c~n', [80, 42]),
    format('~20a~20a~20a~20a~n',
	   ['meal', 'food', 'favorite', 'hates']),
    format('~*c~n', [80, 42]),
    member(Row,Table),print_row(Row),fail.
print_table(Table) :- format('~*c~n', [80, 42]),fail.
