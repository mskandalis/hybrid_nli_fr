:- use_module(library(ape)).

:- use_module(sem_utils,  [drs_to_fol/2]).

:- ['pp.pl'].

% Load the semantics data file
:- consult('semantics_sick.pl').

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
            
            % Convert the reduced semantics to Prenex form
            (   catch(drs_to_fol(ReducedSemantics, PrenexForm), Error, 
                     (format('Error in conversion for ~w: ~w~n', [Number, Error]), fail)) ->
                (   format('Conversion successful for ~w!~n', [Number]),
                    
                    % Open the file in append mode
                    (   catch(open('fol_sentences.pl', append, Fd, [alias(folsent_pl), buffer(line)]), FileError, 
                              (format('Error opening file: ~w~n', [FileError]), fail)) ->
                        (   % Write the reduced semantics and Prenex form to the file
                            format(Fd, '~n% = Reduced Semantics~2nsemantics(~d, reduced, ~W).~n', [Number, ReducedSemantics, [numbervars(true), quoted(true)]]),
                            with_output_to(Fd,
                                (
                                    format('~n% = FOL~2nfol(~d, prenex, ', [Number]),
                                    portray(PrenexForm),
                                    format(').~n~n')
                                )
                            ),
                            close(Fd),
                            format('Written results for ~w to file~n', [Number])
                        )
                    ;   format('Failed to open output file for ~w~n', [Number])
                    )
                )
            ;   format('ERROR: DRS to FOL conversion failed for ~w!~n', [Number])
            )
        )
    ),
    format('Processed all ~w semantics facts~n', [Count]).

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

% Quick test for the actual problem
quick_presup_test :-
    writeln('=== QUICK PRESUP TEST ==='),
    % Use the exact structure from semantics 19680
    TestDRS = presup(drs([variable(B),variable(C)],[appl(femme,B),appl(couteau,C),appl(appl(avec,C),B)]),drs([event(A),variable(D)],[appl(poivre,D),appl(appl(appl(trancher,D),B),A),bool(appl(temps,A),overlaps,maintenant)])),
    
    writeln('Testing presup DRS conversion:'),
    portray(TestDRS), nl,
    
    (   drs_to_fol(TestDRS, Result) ->
        (   writeln('SUCCESS! Result:'),
            portray(Result), nl,
            % Check if it contains conjunction at top level
            (   Result = bool(_, &, _) ->
                writeln('✓ Presup correctly converted to conjunction')
            ;   writeln('✗ Presup NOT converted to conjunction'),
                format('Top level structure: ~w~n', [functor(Result)])
            )
        )
    ;   writeln('FAILED: Conversion returned false')
    ).

