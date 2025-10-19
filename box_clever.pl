% [box_no, name, order, prize]

man(X) :- member(X, [charles, thomas]).
women(X) :- member(X, [deena, greta, rosemary, ursula]).
not_bottom_row(X) :- member(X, [1,2,3]).
top_row(X) :- X == 1.
middle_row(X) :- member(X, [2,3]).
bottom_row(X) :- member(X, [4,5,6]).

same_row(X, Y) :- top_row(X), top_row(Y).
same_row(X, Y) :- middle_row(X), middle_row(Y).
same_row(X, Y) :- bottom_row(X), bottom_row(Y).

different_row(X, Y) :- \+ same_row(X, Y).

start(Sol) :-
    Sol = [[1,_,2,_], % 5/
	   [2,_,NotSecond,_],
	   [3,_,NotThird,_],
	   [4,_,NotFourth,_],
	   [5,_,NotFifth,_],
	   [6,_,NotSixth,digital_camera]], % 3.
    member([Not5,charles,CharlesOrder,_], Sol),
    member([_,deena,_,_], Sol),
    member([GretaBox,greta,GretaOrder,paddington_bear], Sol), % 6.
    member([RosemaryBox,rosemary,_,_], Sol),
    member([_,thomas,ThomasOrder,_], Sol),
    member([UrsulaBox,ursula,_,_], Sol),
    member([_,_,1,_], Sol),
    member([_,_,2,_], Sol),
    member([_,Woman,3,2000], Sol),
    member([_,_,4,_], Sol),
    member([_,_,5,_], Sol),
    member([_,_,6,_], Sol),
    member([Box200,NotThomas,_,200], Sol),
    member([_,_,_,500], Sol),
    member([Not1,NotRosemary,_,exotic_holiday], Sol),
    % 1.
    NotSecond \=2, NotThird \= 3, NotFourth \= 4, NotFifth \= 5, NotSixth \= 6,
    % 2.
    NotRosemary \= rosemary, not_bottom_row(RosemaryBox), Not1 \= 1,
    % 4.
    not_bottom_row(UrsulaBox), Not5 \= 5, CharlesOrder < ThomasOrder,
    % 6.
    GretaOrder is 2 + NotThird, GretaBox < Box200, not_bottom_row(GretaBox),
    Box200 \= 1, NotThomas \= thomas, different_row(Box200, GretaBox), 
    % 7.
    women(Woman).
    
:- use_module(library(clpfd)).

below(X, Y) :- X #> Y, Y #= 1, !.
below(X, Y) :- member(X, [4,5,6]), member(Y, [1,2,3]), !.

puzzle(Table) :-
    Table = [Boxes, Names, Orders, Prizes],

    Boxes = [1, 2, 3, 4, 5, 6],

    Names = [Charles, Deena, Greta, Rosemary, Thomas, Ursula],
    Names ins 1..6, all_distinct(Names),

    Orders = [First, Second, Third, Fourth, Fifth, Sixth],
    Orders ins 1..6, all_distinct(Orders),

    Prizes = [_200, _500, _2000, DigitalCamera, ExoticHoliday, PaddingtonBear],
    Prizes ins 1..6, all_distinct(Prizes),

    %labeling([], Names), labeling([], Orders), labeling([], Prizes),
    
    % 1.
    First #\= 1, Second #\= 2, Third #\= 3, Fourth #\= 4, Fifth #\= 5,
    Sixth #\= 6,
    % 2.
    below(ExoticHoliday, Rosemary),
    %(Rosemary #= 1) #==> (ExoticHoliday #> 1),
    %(Rosemary #=< 3) #==> (ExoticHoliday #> 3),
    % 3.
    DigitalCamera #= 6,
    % 4.
    Ursula #=< 3, Charles #\= 5, Charles #\= Sixth, Thomas #\= First,
    (Thomas #= Second) #==> (Charles #= First),
    (Charles #= Third) #==> (Thomas #\= Second),
    (Charles #= Fourth) #==> (Thomas #\= Second #/\ Thomas #\= Third),
    (Charles #= Fifth) #==> (Thomas #= Sixth),
    % 5.
    Second #= 1,
    % 6.
    Greta #= PaddingtonBear, _200 #\= Thomas,
    below(_200, Greta),
    %ThreeOrder in 1..6,
    %(ThreeOrder #= 3) #==> (Greta #= 2 + ThreeOrder),
    (First #= 3) #<==> (Greta #= Third),
    (Second #= 3) #<==> (Greta #= Fourth),
    (Third #= 3) #<==> (Greta #= Fifth),
    (Fourth #= 3) #<==> (Greta #= Sixth),
    % 7.
    _2000 #\= Charles, _2000 #\= Thomas, _2000 #= Third,

    label(Names), label(Orders), label(Prizes).

%% for this puzzle clpfd was much harder than 'straight' prolog,    
    
    

    
