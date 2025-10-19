% [first_name, surname, clain, year]

start(Sol) :-
    Sol = [[alfred,_,_,_],
	   [sir_edwin,C1,A2,1661],
	   [john,_,bishop,_],
	   [martin,_,_,A7],
	   [sir_roland,freeman,_,A5]],
    member([_,barnard,_,A1], Sol),
    member([_,de_moore,scientist,B1], Sol),
    member([_,ganwick,_,1476], Sol),
    member([_,hannington,_,_], Sol),
    member([_,_,poet,_], Sol),
    member([_,_,soldier,_], Sol),
    member([_,_,sailor,1716], Sol),
    %member([_,_,_,1476], Sol),
    member([_,_,_,1530], Sol),
    member([_,_,_,1849], Sol),
    A1 < B1, C1 \= barnard, C1 \= de_moore,
    A2 \= soldier,
    A5 \= 1530,
    A7 \= 1476, A7 \= 1849.
