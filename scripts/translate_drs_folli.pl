:- use_module(library(ape)).

:- use_module(sem_utils,  [drs_to_fol_top/2, drs_to_fol/2]).


:- use_module('print_fol.pl').

% Load the semantics data file
:- consult('semantics.pl').

% Main predicate to process all semantics
process_all_semantics :-
    writeln('Processing all semantics facts...'),
    process_reduced_semantics,
    writeln('Processing completed!').

process_reduced_semantics :-
    writeln('Starting DRS to FOL conversion...'),
    findall(Number, semantics(Number, reduced, _), Numbers),
    length(Numbers, Count),
    format('Found ~w reduced semantics facts~n', [Count]),
    
    % Clear the output file first
    catch(open('fol_sentences.pl', write, Fd, [alias(folsent_pl), buffer(line)]), _, true),
    close(Fd),
    
    % Process each semantics fact
    forall(semantics(Number, reduced, ReducedSemantics),
        (   format('Processing semantics ~w...~n', [Number]),

            % Wrap each discourse referent (a plain Prolog variable in the
            % cached fact) as '$VAR'(Var), keeping the inner variable UNBOUND.
            % This is the referent form drs_to_fol/2 and the prenex printer pp/1
            % expect, and it is the ORIGINAL naming notation: an unbound inner
            % variable prints as '$VAR'(_NNN) (e.g. '$VAR'(_46164)), which the
            % downstream graillight_to_nltk.py regex '\$VAR'\(_\d+\) relies on.
            % We deliberately do NOT use numbervars/3 here, because that would
            % ground referents to '$VAR'(0),'$VAR'(1),... changing the notation
            % and breaking the downstream consumer.  Wrapping preserves variable
            % identity (sharing), so the reduced-semantics printout and the FOL
            % keep consistent names.
            wrap_referent_variables(ReducedSemantics),

            % Convert the reduced semantics to Prenex form
            (   catch(drs_to_fol_top(ReducedSemantics, PrenexForm), Error, 
                     (format('Error in conversion for ~w: ~w~n', [Number, Error]), fail)) ->
                (   format('Conversion successful for ~w!~n', [Number]),
                    
                    % Open the file in append mode
                    (   catch(open('fol_sentences.pl', append, Fd, [alias(folsent_pl), buffer(line)]), FileError, 
                              (format('Error opening file: ~w~n', [FileError]), fail)) ->
                        (   % Write the reduced semantics and Prenex form to the file
                                ( catch(
          with_output_to(Fd,
              ( format('~n% = Reduced Semantics~2nsemantics(~d, reduced, ~W).~n',
                        [Number, ReducedSemantics, [numbervars(true), quoted(true)]]),
                format('~n% = FOL~2nfol(~d, prenex, ', [Number]),
                pp(PrenexForm),
                format(').~n~n')
              )
          ),
          Error,
          ( format('Error in printing for ~w: ~w~n', [Number, Error]),
            fail
          )
      )
    -> format('Written results for ~w to file~n', [Number])
    ;  format('Skipping ~w due to printing error~n', [Number])
    ),
    close(Fd)
                        )
                    ;   format('Failed to open output file for ~w~n', [Number])
                    )
                )
            ;   format('ERROR: DRS to FOL conversion failed for ~w!~n', [Number])
            )
        )
    ),
    format('Processed all ~w semantics facts~n', [Count]).

% wrap_referent_variables(+Term)
% Bind every unbound Prolog variable in Term to '$VAR'(Fresh) with Fresh left
% unbound.  Shared variables stay shared (each distinct source variable maps to
% one distinct '$VAR'(Fresh)), so referent identity is preserved.  The unbound
% inner variable prints as '$VAR'(_NNN), the established naming notation.
wrap_referent_variables(Term) :-
    term_variables(Term, Vars),
    wrap_each_variable(Vars).

wrap_each_variable([]).
wrap_each_variable([V|Vs]) :-
    V = '$VAR'(_),
    wrap_each_variable(Vs).

% Add a simple test predicate for a specific number
test_specific(Number) :-
    (   semantics(Number, reduced, DRS) ->
        (   format('Testing semantics ~w:~n', [Number]),
            format('Input DRS: ~w~n', [DRS]),
            (   drs_to_fol(DRS, FOL) ->
                (   writeln('Conversion successful!'),
                    format('Output FOL: ~w~n', [FOL])
                )
            ;   writeln('Conversion failed!')
            )
        )
    ;   format('No semantics fact found for number ~w~n', [Number])
    ).

% Test with your specific example
test_19680 :-
    test_specific(19680).

% Quick test for presup conversion
quick_presup_test :-
    TestDRS = presup(drs([variable(B),variable(C)],[appl(femme,B),appl(couteau,C),appl(appl(avec,C),B)]),drs([event(A),variable(D)],[appl(poivre,D),appl(appl(appl(trancher,D),B),A),bool(appl(temps,A),overlaps,maintenant)])),
    writeln('Testing presup conversion...'),
    (   drs_to_fol(TestDRS, FOL) ->
        (   writeln('SUCCESS!'),
            portray(FOL), nl,
            (   FOL = bool(_, &, _) ->
                writeln('Presup correctly converted to conjunction!')
            ;   writeln('WARNING: Result is not a conjunction')
            )
        )
    ;   writeln('FAILED!')
    ).

% Debug test to see what's happening with presup conversion
debug_presup_test :-
    writeln('=== DEBUG: Testing presup conversion ==='),
    % Test the exact DRS from semantics 19680
    TestDRS = presup(drs([variable(B),variable(C)],[appl(femme,B),appl(couteau,C),appl(appl(avec,C),B)]),drs([event(A),variable(D)],[appl(poivre,D),appl(appl(appl(trancher,D),B),A),bool(appl(temps,A),overlaps,maintenant)])),
    writeln('Input DRS:'),
    portray(TestDRS), nl,
    writeln('Attempting conversion...'),
    (   catch(drs_to_fol(TestDRS, FOL), Error, 
             (format('ERROR in drs_to_fol: ~w~n', [Error]), fail)) ->
        (   writeln('SUCCESS! Output FOL:'),
            portray(FOL), nl,
            writeln('Checking if presup was converted to conjunction...'),
            (   compound(FOL), FOL = bool(_, &, _) ->
                writeln('YES: Found conjunction structure at top level')
            ;   writeln('NO: Top level is not a conjunction')
            )
        )
    ;   writeln('FAILED: drs_to_fol returned false')
    ),
    
    % Test if the rule is even being called
    writeln('=== Testing individual presup rule ==='),
    Background = drs([variable(B),variable(C)],[appl(femme,B),appl(couteau,C),appl(appl(avec,C),B)]),
    Main = drs([event(A),variable(D)],[appl(poivre,D),appl(appl(appl(trancher,D),B),A),bool(appl(temps,A),overlaps,maintenant)]),
    (   sem_utils:drs_condition_to_fol(presup(Background, Main), Result) ->
        (   writeln('drs_condition_to_fol succeeded:'),
            portray(Result), nl
        )
    ;   writeln('drs_condition_to_fol failed')
    ),
    
    % Check if our presup rules are actually loaded
    writeln('=== Checking if presup rules are loaded ==='),
    (   current_predicate(sem_utils:drs_condition_to_fol/2) ->
        writeln('drs_condition_to_fol/2 predicate exists')
    ;   writeln('ERROR: drs_condition_to_fol/2 predicate not found!')
    ),
    
    % List all clauses for drs_condition_to_fol to see our rules
    writeln('=== Available drs_condition_to_fol clauses ==='),
    forall(clause(sem_utils:drs_condition_to_fol(Head, _), _),
           (format('Found rule for: ~w~n', [Head]))).

% Simple test to verify the module is working
test_basic_drs :-
    writeln('=== Testing basic DRS conversion ==='),
    BasicDRS = drs([variable(X)], [appl(cat, X)]),
    writeln('Input:'), portray(BasicDRS), nl,
    (   drs_to_fol(BasicDRS, FOL) ->
        (writeln('Output:'), portray(FOL), nl)
    ;   writeln('FAILED')
    ).

