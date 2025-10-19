:- use_module(library(clpfd)).

puzzle(Table) :-
    Dates = [Second, Ninth, Sixteenth, Twentythird, Thirtieth],
    Second #= 1, Ninth #= 2, Sixteenth #= 3, Twentythird #= 4, Thirtieth #= 5,
    FirstNames = [Angelica, Clive, Gordon, Philippa, Rodney],
    FirstNames ins 1..5, all_distinct(FirstNames),
    Surnames = [Fame, Goode, Merritt, Rankin, Worthington],
    Surnames ins 1..5, all_distinct(Surnames),
    Descriptions = [BettingShopMgr, CIDOfficer, CouncilLeader, EditorOfPaper,
		    WeatherForecaster],
    Descriptions ins 1..5, all_distinct(Descriptions),

    % 1.
    Rankin #= CIDOfficer, % Rankin #\= Second, Gordon #\= Thirtieth,
    Rankin #> Second, Gordon #< Thirtieth,
    Rankin #= Gordon + 1,

    %2.
    EditorOfPaper #< Thirtieth, Rodney #> Second,
    EditorOfPaper #= Rodney - 1,

    %3.
    Merritt #= Sixteenth,

    %4.
    Angelica #= WeatherForecaster, Angelica #\= Second,
    Worthington #\= Thirtieth,
    (Angelica #= Ninth) #<==> (Worthington #= Second),
    (Angelica #= Sixteenth) #<==> (Worthington #= Ninth),
    (Angelica #= Twentythird) #<==> (Worthington #= Sixteenth),
    (Angelica #= Thirtieth) #<==> (Worthington #= Twentythird),

    % 5.
    Clive #\= Fame,

    % 6.
    BettingShopMgr #= Thirtieth,

    % 7.
    Philippa #= Second,

    % label after constraining!
    label(FirstNames), label(Surnames), label(Descriptions),
  
    Table = [['2nd', F1, S1, D1],
	     ['9th', F2, S2, D2],
	     ['16th', F3, S3, D3],
	     ['23rd', F4, S4, D4],
	     ['30th', F5, S5, D5]],

    get_strings(FirstNames,
		['Angelica', 'Clive', 'Gordon', 'Philippa', 'Rodney'], FCol),
    [F1, F2, F3, F4, F5] = FCol,

    get_strings(Surnames, ['Fame', 'Goode', 'Merritt', 'Rankin', 'Worthington'],
		SCol),
    [S1, S2, S3, S4, S5] = SCol,

    get_strings(Descriptions, ['Betting shop manager', 'CID Officer',
			       'Council Leader', 'Editor of paper',
			       'Weather forecaster'], DCol),
    [D1, D2, D3, D4, D5] = DCol.
    
    

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
