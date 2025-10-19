%use_module(library(clpfd)).

even(X) :- 0 is X mod 2.
odd(X) :- 1 is X mod 2.

puzzle(Sol) :-
    Even = [2,4,6,8,10],
    Odd = [1,3,5,7,9,11],
    Names = [John, Luke, Mark, Matthew, Nicholas, Noel, Angela, Carole, Holly,
	     Ivy, Joy, Mary], fd_domain(Names, 1, 12), fd_all_different(Names),
    %Boys = [John, Luke, Mark, Matthew, Nicholas, Noel],
    %Girls = [Angela, Carole, Holly, Ivy, Joy, Mary],
    Dates = [JohnDate, LukeDate, MarkDate, MatthewDate, NicholasDate, NoelDate,
	     AngelaDate, CaroleDate, HollyDate, IvyDate, JoyDate, MaryDate],
    fd_domain(Dates, 1, 12), fd_all_different(Dates),
    Sol = [[John, JohnDate],
	   [Luke, LukeDate],
	   [Mark, MarkDate],
	   [Matthew, MatthewDate],
	   [Nicholas, NicholasDate],
	   [Noel, NoelDate],
	   [Angela, AngelaDate],
	   [Carole, CaroleDate],
	   [Holly, HollyDate],
	   [Ivy, IvyDate],
	   [Joy, JoyDate],
	   [Mary, MaryDate]],
    % 1.
    JohnDate #\= 10, LukeDate #\= 10, MarkDate #\= 10, MatthewDate #\= 10,
    NicholasDate #\= 10, NoelDate #\= 10,
    John #\= 7, Luke #\= 7, Mark #\= 7, Matthew #\= 7, Nicholas #\= 7,
    Noel #\= 7,
    % 2.
    Nicholas #\= 3, Angela #\= 3, Carole #\= 3, Holly #\= 3, Ivy #\= 3,
    Joy #\= 3, Mary #\= 3, (Nicholas - Ivy #= 1; Ivy - Nicholas #= 1),
    member([3,Date3], Sol), fd_domain(Date3, Even), NicholasDate - Date3 #= 1,
    IvyDate #= 5,
    % 3.
    JohnDate #\= 12, LukeDate #\= 12, MarkDate #\= 12, MatthewDate #\= 12,
    NicholasDate #\= 12, NoelDate #\= 12, JohnDate #=< 5,
    member([House12,12], Sol), fd_domain(House12, 1, 12), John - House12 #= 2,
    % % 4.
    Carole #\= 1, Carole #\= 12, CaroleDate #\= 12,
    member([1,Date1], Sol), fd_domain(Date1, 1, 12),
    member([12,Date12], Sol), fd_domain(Date12, 1, 12),
    Date1 - CaroleDate #= 1,  Date12 - Date1 #= 1,
    % % 5.
    Matthew #= 9,
    % % 6.
    member(Mark, Odd), member(Holly, Even),
    MarkDate - HollyDate #= 1,
    % % 7.
    member([4,Date4], Sol), fd_domain(Date4, 1, 12), NoelDate - Date4 #= 2,
    % 8.
    member([6,2], Sol),
    member(AngelaDate, Odd), AngelaDate - LukeDate #= 1,
    % 9.
    MaryDate #< JoyDate, member(Joy, [10,11,12]),
    % 10,
    \+ memberchk([X,X], Sol).

    
