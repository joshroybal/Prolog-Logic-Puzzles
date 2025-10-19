:- use_module(library(clpfd)).

puzzle(Sol) :-
    Sol = [[broken_man,_,_,ian_fleming],
	   [david_and_carol,E,sylvia_robb,_], % E \= espionage,
	   [home_defence,_,D,_], %D \= vincent_fox,
	   [narcissus,whodunit,_,_],
	   [seven_passengers,_,_,_]],

    member([_,comic_novel,A,_], Sol),
    member(A, [david_banks, martin_hart, vincent_fox]),
    member([_,espionage,_,catherine_cookson], Sol),
    member([_,historical_novel,_,C], Sol), % C \= rudyard_kipling,
    member([_,science_fiction,martin_hart,F], Sol),

    member([_,_,david_banks,agatha_christie], Sol),
    member([_,_,joanna_may,_], Sol),
    member([_,_,vincent_fox,_], Sol),

    member([_,_,_,conan_doyle], Sol),
    member([_,_,B,rudyard_kipling], Sol), member(B, [joanna_may, sylvia_robb]),
    
    E \= espionage, D \= vincent_fox, C \= rudyard_kipling, F \= conan_doyle.


start(TitleNames, Types, PenNames, IdeasFrom) :-
    Titles = [BrokenMan, DavidAndCarol, HomeDefence, Narcissus, SevenPassengers],
    %Titles ins 1..5, all_distinct(Titles),
    BrokenMan #= 1, DavidAndCarol #= 2, HomeDefence #= 3, Narcissus #= 4,
    SevenPassengers #= 5,

    Types = [ComicNovel, Espionage, HistoricalNovel, ScienceFiction, Whodunit],
    Types ins 1..5, all_distinct(Types),
    %TypeNames = ['Comic Novel', 'Espionage', 'Historical Novel','Science Fiction', 'Whodunit'],

    PenNames = [DavidBanks, JoannaMay, MartinHart, SylviaRobb, VincentFox],
    PenNames ins 1..5, all_distinct(PenNames),

    IdeasFrom = [AgathaChristie, CatherineCookson, ConanDoyle, IanFleming,
		 RudyardKipling], IdeasFrom ins 1..5, all_distinct(IdeasFrom),

    DavidBanks #= AgathaChristie,
    Narcissus #= Whodunit,
    %ComicNovel in [DavidBanks, MartinHart, VincentFox],
    member(ComicNovel, [DavidBanks, MartinHart, VincentFox]),
    %RudyardKipling in [JoannaMay, SylviaRobb],
    member(RudyardKipling, [JoannaMay, SylviaRobb]),
    BrokenMan #= IanFleming,
    HistoricalNovel #\= RudyardKipling,
    HomeDefence #\= VincentFox,
    DavidAndCarol #= SylviaRobb,
    DavidAndCarol #\= Espionage,
    Espionage #= CatherineCookson,
    ScienceFiction #= MartinHart,
    ScienceFiction #\= ConanDoyle,
    maplist(get_title_label, Titles, TitleNames),
    append([Types, PenNames, IdeasFrom], Vs),
    %append([TypeNames, PenNames, IdeasFrom], Vs),
    labeling([], Vs),
    [A,B,C,D,E] = TitleNames,
    %nth1(F, Types, 1), nth1(G, Types, 2), nth1(H, Types, 3), nth1(I, Types, 4),
    %nth1(J, Types, 5),
    idx(Types, Titles, TypeIndexes),
    maplist(get_type_label, TypeIndexes, [F,G,H,I,J]),
    %[F,G,H,I,J] = TypeNames,

    idx(PenNames, Titles, PenNameIndexes),
    maplist(get_pen_name_label, PenNameIndexes, [K,L,M,N,O]),

    idx(IdeasFrom, Titles, IdeaIndexes),
    maplist(get_idea_label, IdeaIndexes, [P,Q,R,S,T]),

    Table = [[A,F,K,P],
	     [B,G,L,Q],
	     [C,H,M,R],
	     [D,I,N,S],
	     [E,J,O,T]],
    member(Row,Table),print(Row),nl,fail.

idx(ListA, ListB, Indexes) :-
    findall(Idx, (member(Element, ListB), nth1(Idx, ListA, Element)), Indexes).

get_idea_label(Key, Label) :-
    idea_names(Pairs),
    member(Key-Label, Pairs).

idea_names([
    1-'Agatha Christie',
    2-'Catherine Cookson',
    3-'Conan Doyle',
    4-'Ian Fleming',
    5-'Rudyard Kipling'
]).


get_pen_name_label(Key, Label) :-
    pen_name_names(Pairs),
    member(Key-Label, Pairs).

pen_name_names([
    1-'David Banks',
    2-'Joanna May',
    3-'Martin Hart',
    4-'Sylvia Robb',
    5-'Vincent Fox'
]).

get_type_label(Key, Label) :-
    type_names(Pairs),
    member(Key-Label, Pairs).

type_names([
    1-'Comic Novel',
    2-'Espionage',
    3-'Historical Novel',
    4-'Science Fiction',
    5-'Whodunit'
]).

get_title_label(Key, Label) :-
    title_names(Pairs),
    member(Key-Label, Pairs).

title_names([
    1-'Broken Man',
    2-'David and Carol',
    3-'Home Defence',
    4-'Narcissus',
    5-'Seven Passengers'
]).
