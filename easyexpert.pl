% easyexpert.pl - a simple shell used with Prolog
% knowledge bases is in    file.knb
/*-------- How to run  ------
1. Install SWI prolog
2. copy 2 file to desktop: easyexpert.pl,vacation.knb
3. double click easyexpert.pl
4. expertshell.
5. load.
6. solve.
7. why.
8. quit.
---------------------------*/

:-dynamic known/1, answer/1.


expertshell :-
	greeting,
	repeat,
	write('expert-shell> '),
	read(X),
	do(X),
	X == quit,
	writeln('>>>>Goodbye, see you later<<<<'), !.

greeting :-
	write('This is the Easy Expert System shell.'), nl,
	native_help.

do(help) :- native_help, !.
do(load) :- load_kb, !.
do(solve) :- solve, !.
do(why):-why,!.
do(quit).
do(X) :-
	write(X),
	write(' is not a legal command.'), nl,
	fail.

native_help :-
	write('Type  help.   load.   solve.   why.   or quit.'),nl,
	write('at the prompt.'), nl.

load_kb :-
	write('Enter file name in single quotes (ex. ''vacation.knb''.): '),
	read(F),
	reconsult(F).

solve :-
	retractall(known( _) ),retractall(answer(_)),
        %abolish(known,3),
	top_goal(X),
	write('The answer is '),write(X),assert(answer(X)),nl.
solve :-
	write('No answer found.'),nl.

menuask(Pred,Value,Menu):-menuask(Pred,Menu),atomic_list_concat([Pred,'(',Value,')'],X),
                   term_to_atom(T,X),known(T),!.
menuask(Pred,_):-atomic_list_concat([Pred,'(','_',')'],X),
                   term_to_atom(T,X),known(T),!.
menuask(Attribute,Menu):-
	nl,write('What is the value for '),write(Attribute),write('?'),nl,
	writeln(Menu),
	write('Enter the  choice> '),read(V),
	atomic_list_concat([Attribute,'(',V,')'],X),term_to_atom(T,X),asserta(known(T))	.

why:- answer(A),write('The answer is '),writeln(A),
    findall( X , known(X),Result),writeln('The known storage are'),
    writeln(Result).
