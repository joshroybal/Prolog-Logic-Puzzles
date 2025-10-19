puzzle(Table) :-
    Members = [Betty, Dorothy, Heather, Margaret, Sylvia],
    fd_domain(Members, 1, 5), fd_all_different(Members),
    Descriptions = [BusinessWoman, Hairdresser, HeadTeacher, SeniorCitizen,
		    VicarsWife],
    fd_domain(Descriptions, 1, 5), fd_all_different(Descriptions),
    Speakers = [1, 2, 3, 4, 5],
    Comments = [Amusing, Educational, Exciting, Interesting, Useful],
    fd_domain(Comments, 1, 5), fd_all_different(Comments),
    % 1.
    % talk order -> senior citizen, educational, sylvia
    SeniorCitizen #< Educational, Educational #< Sylvia,
    % 2.
    Hairdresser #< 3,
    % 3.
    HeadTeacher #= Interesting, Interesting #\= 2, Interesting #\= 4,
    % 4.
    BusinessWoman #\= 4,
    % 5.
    Dorothy #= Exciting,
    % 6.
    % talk order -> Useful, Betty
    Betty #> Useful, Useful #>= 3,
    % 7.
    % talk order -> Vicar's wife, amusing
    Heather #= VicarsWife, Heather #< Amusing,
    % 8.
    Margaret #> 1,

    fd_labeling(Members),
    fd_labeling(Descriptions),
    fd_labeling(Comments),
    %Table = [Members, Descriptions, Speakers, Comments].
    Table = [[M1,D1,'Philippa',C1],
	     [M2,D2,'Angelica',C2],
	     [M3,D3,'Gordon',C3],
	     [M4,D4,'Rodney',C4],
	     [M5,D5,'Clive',C5]],
    get_strings(Members, ['Betty','Dorothy','Heather','Margaret','Syvlia'],
		Col1), [M1,M2,M3,M4,M5] = Col1,
    get_strings(Descriptions, ['Business-woman', 'Hairdresser', 'Head teacher',
			       'Senior citizen', 'Vicar''s wife'], Col2),
    [D1,D2,D3,D4,D5] = Col2,
    get_strings(Comments, ['Amusing', 'Educational', 'Exciting', 'Interesting',
			   'Useful'], Col4), [C1,C2,C3,C4,C5] = Col4.

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
