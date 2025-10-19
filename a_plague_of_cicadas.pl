puzzle(Table) :-
    Days = [Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday],

    Groups = [Glory, OK, Reborn, Reflex, Counterfeit, OCTriB, Shadow],
    fd_domain(Groups, 1, 7), fd_all_different(Groups),

    Venues = [Arts, Coronet, McGees, Methane, Park, Playhouse, Star],
    fd_domain(Venues, 1, 7), fd_all_different(Venues),

    Cities = [Belfast, Glasgow, Ipswich, Oxford, Portsmouth, Preston, Rhyl],
    fd_domain(Cities, 1, 7), fd_all_different(Cities),

    % Puzzle Constraints
    Sunday #= 1, Monday #= 2, Tuesday #= 3, Wednesday #= 4, Thursday #= 5,
    Friday #= 6, Saturday #= 7,
    % 1.
    Saturday #= Reborn,
    Saturday #\= Belfast, Saturday #\= Glasgow, Saturday #\= Rhyl,
    % 2.
    Oxford #= Glasgow - 2,
    % 3.
    McGees #= Preston, McGees #= OCTriB - 3,
    % 4.
    Counterfeit #= Playhouse, Playhouse #\= Ipswich, Ipswich #= Monday,
    % 5.
    Belfast #= Shadow,
    % 6.
    Reflex #= Portsmouth - 2, Portsmouth #\= Coronet,
    % 7.
    Sunday #= Methane,
    Arts #\= Ipswich, Arts #\= Oxford, Arts #\= Portsmouth, Arts #\= Preston,
    Arts #= 1 + Star,
    % 8.
    Glory #< OK,

    fd_labeling(Groups), fd_labeling(Venues), fd_labeling(Cities),
    create_table(Groups, Venues, Cities, Table).

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
    [R11, R21, R31, R41, R51, R61, R71] = ['Sunday', 'Monday', 'Tuesday',
					   'Wednesday', 'Thursday', 'Friday',
					   'Saturday'],

    get_strings(Col2, ['Cicadas Glory', 'Cicadas OK', 'Cicadas Reborn',
		       'Cicadas Reflex', 'Counterfeit Cicadas', 'OCTriB',
		      'Shadow Cicadas'], B),
    [R12, R22, R32, R42, R52, R62, R72] = B,

    get_strings(Col3, ['Arts Theatre', 'Coronet Leisure Centre', 'McGee''s Club',
		       'Methane',
		       'Park Theatre', 'Playhouse Theatre', 'Star Club'], C),
    [R13, R23, R33, R43, R53, R63, R73] = C,

    get_strings(Col4, ['Belfast', 'Glasgow', 'Ipswich', 'Oxford', 'Portsmouth',
		      'Preston', 'Rhyl'], D),
    [R14, R24, R34, R44, R54, R64, R74] = D,

    Result = [[R11, R12, R13, R14],
	      [R21, R22, R23, R24],
	      [R31, R32, R33, R34],
	      [R41, R42, R43, R44],
	      [R51, R52, R53, R54],
	      [R61, R62, R63, R64],
	      [R71, R72, R73, R74]].
