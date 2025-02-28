
% = Semantics

semantics(2, unreduced, appl(lambda(F,F),appl(lambda(R,merge(drs([event(S)],[]),appl(R,S))),appl(appl(lambda(K,lambda(L,lambda(M,presup(drs([],[bool(appl(temps,M),overlaps,maintenant)]),appl(appl(K,L),M))))),lambda(N,lambda(O,appl(N,lambda(P,drs([variable(Q)],[bool(Q,=,'context?'),appl(appl(appl(asseoir,P),Q),O)])))))),appl(lambda(G,lambda(H,merge(merge(drs([variable(I)],[bool(num(I),>,1)]),appl(G,I)),appl(H,I)))),lambda(J,drs([],[appl(chien,J)]))))))).

% = Reduced Semantics

semantics(2, reduced, presup(drs([],[bool(appl(temps,A),overlaps,maintenant)]),drs([event(A),variable(B),variable(C)],[bool(num(B),>,1),appl(chien,B),bool(C,=,'context?'),appl(appl(appl(asseoir,B),C),A)]))).


% = Semantics

semantics(4, unreduced, appl(lambda(G,G),appl(lambda(R,merge(drs([event(S)],[]),appl(R,S))),appl(lambda(P,lambda(Q,drs([],[not(appl(P,Q))]))),appl(appl(lambda(L,L),lambda(M,lambda(N,appl(M,lambda(O,drs([],[appl(appl(courir,O),N),bool(appl(temps,N),overlaps,maintenant)])))))),appl(lambda(H,lambda(I,merge(merge(drs([variable(J)],[bool(num(J),>,1)]),appl(H,J)),appl(I,J)))),lambda(K,drs([],[appl(chien,K)])))))))).

% = Reduced Semantics

semantics(4, reduced, drs([event(A)],[not(drs([variable(B)],[bool(num(B),>,1),appl(chien,B),appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant)]))])).


% = Semantics

semantics(6, unreduced, appl(lambda(E,E),appl(lambda(M,merge(drs([event(N)],[]),appl(M,N))),appl(lambda(J,lambda(K,appl(J,lambda(L,drs([],[appl(appl(court,L),K)]))))),appl(lambda(F,lambda(G,drs([],[bool(merge(drs([variable(H)],[]),appl(F,H)),->,appl(G,H))]))),lambda(I,drs([],[appl(chien,I)]))))))).

% = Reduced Semantics

semantics(6, reduced, drs([event(A)],[bool(drs([variable(B)],[appl(chien,B)]),->,drs([],[appl(appl(court,B),A)]))])).


% = Semantics

semantics(8, unreduced, appl(lambda(H,H),appl(lambda(X,merge(drs([event(Y)],[]),appl(X,Y))),appl(appl(lambda(Q,lambda(R,lambda(S,presup(drs([],[bool(appl(temps,S),overlaps,maintenant)]),appl(appl(Q,R),S))))),lambda(T,lambda(U,appl(T,lambda(V,drs([variable(W)],[bool(W,=,'context?'),appl(appl(appl(asseoir,V),W),U)])))))),appl(lambda(I,lambda(J,appl(I,lambda(K,merge(appl(J,K),drs([],[appl(plus_de,K)])))))),appl(lambda(L,L),appl(lambda(M,lambda(N,merge(merge(drs([variable(O)],[]),appl(M,O)),appl(N,O)))),lambda(P,drs([],[appl(chien,P)]))))))))).

% = Reduced Semantics

semantics(8, reduced, presup(drs([],[bool(appl(temps,A),overlaps,maintenant)]),drs([event(A),variable(B),variable(C)],[appl(chien,B),bool(C,=,'context?'),appl(appl(appl(asseoir,B),C),A),appl(plus_de,B)]))).


% = Semantics

semantics(10, unreduced, appl(lambda(F,F),appl(lambda(Q,merge(drs([event(R)],[]),appl(Q,R))),appl(lambda(N,lambda(O,appl(N,lambda(P,drs([],[appl(appl(courir,P),O),bool(appl(temps,O),overlaps,maintenant)]))))),appl(lambda(G,lambda(H,appl(G,lambda(I,merge(appl(H,I),drs([],[appl(tout,I)])))))),appl(lambda(J,lambda(K,presup(merge(drs([variable(L)],[bool(num(L),>,1)]),appl(J,L)),appl(K,L)))),lambda(M,drs([],[appl(chien,M)])))))))).

% = Reduced Semantics

semantics(10, reduced, presup(drs([variable(B)],[bool(num(B),>,1),appl(chien,B)]),drs([event(A)],[appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant),appl(tout,B)]))).


% = Semantics

semantics(12, unreduced, appl(lambda(G,G),appl(lambda(S,merge(drs([event(T)],[]),appl(S,T))),appl(lambda(P,lambda(Q,appl(P,lambda(R,drs([],[appl(appl(courir,R),Q),bool(appl(temps,Q),overlaps,maintenant)]))))),appl(lambda(H,lambda(I,appl(H,lambda(J,merge(appl(I,J),drs([],[appl(plus_de,J)])))))),appl(lambda(K,K),appl(lambda(L,lambda(M,merge(merge(drs([variable(N)],[bool(num(N),=,2)]),appl(L,N)),appl(M,N)))),lambda(O,drs([],[appl(chien,O)]))))))))).

% = Reduced Semantics

semantics(12, reduced, drs([event(A),variable(B)],[bool(num(B),=,2),appl(chien,B),appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant),appl(plus_de,B)])).


% = Semantics

semantics(14, unreduced, appl(lambda(H,H),appl(lambda(X,merge(drs([event(Y)],[]),appl(X,Y))),appl(appl(lambda(Q,lambda(R,lambda(S,presup(drs([],[bool(appl(temps,S),overlaps,maintenant)]),appl(appl(Q,R),S))))),lambda(T,lambda(U,appl(T,lambda(V,drs([variable(W)],[bool(W,=,'context?'),appl(appl(appl(asseoir,V),W),U)])))))),appl(lambda(I,lambda(J,appl(I,lambda(K,merge(appl(J,K),drs([],[appl(plus_de,K)])))))),appl(lambda(L,L),appl(lambda(M,lambda(N,merge(merge(drs([variable(O)],[bool(num(O),=,4)]),appl(M,O)),appl(N,O)))),lambda(P,drs([],[appl(chien,P)]))))))))).

% = Reduced Semantics

semantics(14, reduced, presup(drs([],[bool(appl(temps,A),overlaps,maintenant)]),drs([event(A),variable(B),variable(C)],[bool(num(B),=,4),appl(chien,B),bool(C,=,'context?'),appl(appl(appl(asseoir,B),C),A),appl(plus_de,B)]))).


% = Semantics

semantics(16, unreduced, appl(lambda(J,J),appl(lambda(D1,merge(drs([event(E1)],[]),appl(D1,E1))),appl(appl(lambda(S,S),appl(lambda(T,lambda(U,lambda(V,presup(drs([],[bool(appl(temps,V),overlaps,maintenant)]),appl(appl(T,U),V))))),appl(lambda(W,lambda(X,lambda(Y,drs([],[not(appl(appl(W,X),Y))])))),lambda(Z,lambda(A1,appl(Z,lambda(B1,drs([variable(C1)],[bool(C1,=,'context?'),appl(appl(appl(asseoir,B1),C1),A1)])))))))),appl(lambda(K,lambda(L,appl(K,lambda(M,merge(appl(L,M),drs([],[appl(plus_de,M)])))))),appl(lambda(N,N),appl(lambda(O,lambda(P,merge(merge(drs([variable(Q)],[bool(num(Q),=,3)]),appl(O,Q)),appl(P,Q)))),lambda(R,drs([],[appl(chien,R)]))))))))).

% = Reduced Semantics

semantics(16, reduced, presup(drs([],[bool(appl(temps,A),overlaps,maintenant)]),drs([event(A)],[not(drs([variable(B),variable(C)],[bool(num(B),=,3),appl(chien,B),bool(C,=,'context?'),appl(appl(appl(asseoir,B),C),A),appl(plus_de,B)]))]))).


% = Semantics

semantics(18, unreduced, appl(lambda(G,G),appl(lambda(S,merge(drs([event(T)],[]),appl(S,T))),appl(lambda(P,lambda(Q,appl(P,lambda(R,drs([],[appl(appl(courir,R),Q),bool(appl(temps,Q),overlaps,maintenant)]))))),appl(lambda(H,lambda(I,appl(H,lambda(J,merge(appl(I,J),drs([],[appl(moins_de,J)])))))),appl(lambda(K,K),appl(lambda(L,lambda(M,merge(merge(drs([variable(N)],[bool(num(N),=,6)]),appl(L,N)),appl(M,N)))),lambda(O,drs([],[appl(chien,O)]))))))))).

% = Reduced Semantics

semantics(18, reduced, drs([event(A),variable(B)],[bool(num(B),=,6),appl(chien,B),appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant),appl(moins_de,B)])).


% = Semantics

semantics(20, unreduced, appl(lambda(F,F),appl(lambda(R,merge(drs([event(S)],[]),appl(R,S))),appl(appl(lambda(K,lambda(L,lambda(M,presup(drs([],[bool(appl(temps,M),overlaps,maintenant)]),appl(appl(K,L),M))))),lambda(N,lambda(O,appl(N,lambda(P,drs([variable(Q)],[bool(Q,=,'context?'),appl(appl(appl(asseoir,P),Q),O)])))))),appl(lambda(G,lambda(H,merge(merge(drs([variable(I)],[]),appl(G,I)),appl(H,I)))),lambda(J,drs([],[appl(chien,J)]))))))).

% = Reduced Semantics

semantics(20, reduced, presup(drs([],[bool(appl(temps,A),overlaps,maintenant)]),drs([event(A),variable(B),variable(C)],[appl(chien,B),bool(C,=,'context?'),appl(appl(appl(asseoir,B),C),A)]))).


% = Semantics

semantics(22, unreduced, appl(lambda(E,E),appl(lambda(M,merge(drs([event(N)],[]),appl(M,N))),appl(lambda(J,lambda(K,appl(J,lambda(L,drs([],[appl(appl(courir,L),K),bool(appl(temps,K),overlaps,maintenant)]))))),appl(lambda(F,lambda(G,merge(merge(drs([variable(H)],[bool(num(H),=,3)]),appl(F,H)),appl(G,H)))),lambda(I,drs([],[appl(chien,I)]))))))).

% = Reduced Semantics

semantics(22, reduced, drs([event(A),variable(B)],[bool(num(B),=,3),appl(chien,B),appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant)])).


% = Semantics

semantics(24, unreduced, appl(lambda(H,H),appl(lambda(Z,merge(drs([event(A1)],[]),appl(Z,A1))),appl(lambda(W,lambda(X,appl(W,lambda(Y,drs([],[appl(appl(courir,Y),X),bool(appl(temps,X),overlaps,maintenant)]))))),appl(lambda(I,lambda(J,appl(I,lambda(K,merge(appl(J,K),drs([],[appl(entre,K)])))))),appl(appl(appl(lambda(O,lambda(P,lambda(Q,lambda(R,merge(appl(appl(O,Q),R),appl(appl(P,Q),R)))))),lambda(S,lambda(T,merge(merge(drs([variable(U)],[bool(num(U),=,7)]),appl(S,U)),appl(T,U))))),lambda(L,lambda(M,merge(merge(drs([variable(N)],[bool(num(N),=,6)]),appl(L,N)),appl(M,N))))),lambda(V,drs([],[appl(chien,V)])))))))).

% = Reduced Semantics

semantics(24, reduced, drs([event(A),variable(B),variable(C)],[bool(num(B),=,7),appl(chien,B),appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant),appl(entre,B),bool(num(C),=,6),appl(chien,C),appl(appl(courir,C),A),appl(entre,C)])).


% = Semantics

semantics(30, unreduced, appl(lambda(F,F),appl(lambda(O,appl(O,lambda(P,drs([],[])))),appl(lambda(G,lambda(H,merge(merge(drs([variable(I)],[]),appl(G,I)),appl(H,I)))),appl(lambda(M,lambda(N,merge(drs([],[appl(court,N)]),appl(M,N)))),appl(lambda(K,lambda(L,merge(drs([],[appl(rouge,L)]),appl(K,L)))),lambda(J,drs([],[appl(chien,J)])))))))).

% = Reduced Semantics

semantics(30, reduced, drs([variable(A)],[appl(court,A),appl(rouge,A),appl(chien,A)])).


% = Semantics

semantics(32, unreduced, appl(lambda(G,G),appl(lambda(T,merge(drs([event(U)],[]),appl(T,U))),appl(lambda(Q,lambda(R,appl(Q,lambda(S,drs([],[appl(appl(courir,S),R),bool(appl(temps,R),overlaps,maintenant)]))))),appl(lambda(H,lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,60)]),appl(H,J)),appl(I,J)))),appl(appl(lambda(L,lambda(M,lambda(N,presup(merge(drs([variable(O)],[bool(num(O),>,1)]),appl(L,O)),merge(appl(M,N),drs([],[appl(appl(de,O),N)])))))),lambda(P,drs([],[appl(chien,P)]))),lambda(K,drs([],[appl('%',K)])))))))).

% = Reduced Semantics

semantics(32, reduced, presup(drs([variable(C)],[bool(num(C),>,1),appl(chien,C)]),drs([event(A),variable(B)],[bool(num(B),=,60),appl('%',B),appl(appl(de,C),B),appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant)]))).


% = Semantics

semantics(34, unreduced, appl(lambda(H,H),appl(lambda(Y,merge(drs([event(Z)],[]),appl(Y,Z))),appl(appl(lambda(R,lambda(S,lambda(T,presup(drs([],[bool(appl(temps,T),overlaps,maintenant)]),appl(appl(R,S),T))))),lambda(U,lambda(V,appl(U,lambda(W,drs([variable(X)],[bool(X,=,'context?'),appl(appl(appl(asseoir,W),X),V)])))))),appl(lambda(I,lambda(J,merge(merge(drs([variable(K)],[bool(num(K),=,40)]),appl(I,K)),appl(J,K)))),appl(appl(lambda(M,lambda(N,lambda(O,presup(merge(drs([variable(P)],[bool(num(P),>,1)]),appl(M,P)),merge(appl(N,O),drs([],[appl(appl(de,P),O)])))))),lambda(Q,drs([],[appl(chien,Q)]))),lambda(L,drs([],[appl('%',L)])))))))).

% = Reduced Semantics

semantics(34, reduced, presup(drs([variable(C)],[bool(appl(temps,A),overlaps,maintenant),bool(num(C),>,1),appl(chien,C)]),drs([event(A),variable(B),variable(D)],[bool(num(B),=,40),appl('%',B),appl(appl(de,C),B),bool(D,=,'context?'),appl(appl(appl(asseoir,B),D),A)]))).


% = Semantics

semantics(36, unreduced, appl(lambda(I,I),appl(lambda(Z,merge(drs([event(A1)],[]),appl(Z,A1))),appl(lambda(W,lambda(X,appl(W,lambda(Y,drs([],[appl(appl(courir,Y),X),bool(appl(temps,X),overlaps,maintenant)]))))),appl(lambda(J,lambda(K,appl(J,lambda(L,merge(appl(K,L),drs([],[appl(plus_de,L)])))))),appl(lambda(M,M),appl(lambda(N,lambda(O,merge(merge(drs([variable(P)],[bool(num(P),=,40)]),appl(N,P)),appl(O,P)))),appl(appl(lambda(R,lambda(S,lambda(T,presup(merge(drs([variable(U)],[bool(num(U),>,1)]),appl(R,U)),merge(appl(S,T),drs([],[appl(appl(de,U),T)])))))),lambda(V,drs([],[appl(chien,V)]))),lambda(Q,drs([],[appl('%',Q)])))))))))).

% = Reduced Semantics

semantics(36, reduced, presup(drs([variable(C)],[bool(num(C),>,1),appl(chien,C)]),drs([event(A),variable(B)],[bool(num(B),=,40),appl('%',B),appl(appl(de,C),B),appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant),appl(plus_de,B)]))).


% = Semantics

semantics(38, unreduced, appl(lambda(K,K),appl(lambda(I1,merge(drs([event(J1)],[]),appl(I1,J1))),appl(appl(lambda(E1,lambda(F1,lambda(G1,appl(F1,lambda(H1,drs([],[appl(appl(appl(poursuivre,H1),H1),G1),bool(appl(temps,G1),overlaps,maintenant)])))))),lambda(C1,appl(C1,D1))),appl(appl(lambda(R,lambda(S,lambda(T,merge(appl(S,lambda(U,appl(T,U))),appl(R,lambda(V,appl(T,V))))))),appl(lambda(W,lambda(X,merge(merge(drs([variable(Y)],[]),appl(W,Y)),appl(X,Y)))),appl(lambda(A1,lambda(B1,merge(drs([],[appl(rouge,B1)]),appl(A1,B1)))),lambda(Z,drs([],[appl(chien,Z)]))))),appl(lambda(L,lambda(M,merge(merge(drs([variable(N)],[]),appl(L,N)),appl(M,N)))),appl(lambda(P,lambda(Q,merge(drs([],[appl(brun,Q)]),appl(P,Q)))),lambda(O,drs([],[appl(chien,O)]))))))))).

% = Reduced Semantics

semantics(38, reduced, drs([event(A),variable(B),variable(C)],[appl(brun,B),appl(chien,B),appl(appl(appl(poursuivre,B),B),A),bool(appl(temps,A),overlaps,maintenant),appl(rouge,C),appl(chien,C),appl(appl(appl(poursuivre,C),C),A)])).


% = Semantics

semantics(40, unreduced, appl(lambda(K,K),appl(lambda(I1,merge(drs([event(J1)],[]),appl(I1,J1))),appl(appl(lambda(X,lambda(Y,lambda(Z,merge(merge(drs([variable(A1)],[bool(Z,subseteq,A1)]),appl(X,A1)),appl(Y,Z))))),appl(appl(lambda(C1,lambda(D1,lambda(E1,merge(appl(D1,E1),merge(drs([variable(F1)],[appl(appl('l\'',F1),E1)]),appl(C1,F1)))))),lambda(G1,presup(drs([variable(H1)],[bool(H1,=,'context?')]),drs([],[bool(bool(G1,intersect,H1),=,nil)])))),lambda(B1,drs([],[bool(num(B1),=,1)])))),appl(appl(lambda(T,lambda(U,lambda(V,appl(U,lambda(W,drs([],[appl(appl(appl(poursuivre,W),W),V),bool(appl(temps,V),overlaps,maintenant)])))))),lambda(R,appl(R,S))),appl(lambda(L,lambda(M,merge(merge(drs([variable(N)],[bool(num(N),=,2)]),appl(L,N)),appl(M,N)))),appl(lambda(P,lambda(Q,merge(drs([],[appl(rouge,Q)]),appl(P,Q)))),lambda(O,drs([],[appl(chien,O)]))))))))).

% = Reduced Semantics

semantics(40, reduced, presup(drs([variable(D)],[bool(D,=,'context?')]),drs([event(A),variable(B),variable(C),variable(E)],[bool(A,subseteq,B),bool(num(B),=,1),appl(appl('l\'',C),B),bool(bool(C,intersect,D),=,nil),bool(num(E),=,2),appl(rouge,E),appl(chien,E),appl(appl(appl(poursuivre,E),E),A),bool(appl(temps,A),overlaps,maintenant)]))).


% = Semantics

semantics(101, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(vert,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(rouge,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(101, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(vert,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(rouge,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(102, unreduced, appl(lambda(P,P),appl(lambda(X1,merge(drs([event(Y1)],[]),appl(X1,Y1))),appl(appl(lambda(K1,lambda(L1,lambda(M1,presup(merge(drs([variable(N1)],[]),appl(K1,N1)),merge(appl(L1,M1),drs([],[appl(appl(à,N1),M1)])))))),appl(appl(lambda(P1,lambda(Q1,lambda(R1,merge(appl(Q1,R1),appl(P1,lambda(S1,drs([],[appl(appl(de,S1),R1)]))))))),appl(lambda(T1,lambda(U1,merge(merge(drs([variable(V1)],[]),appl(T1,V1)),appl(U1,V1)))),lambda(W1,drs([],[appl(montagne,W1)])))),lambda(O1,drs([],[appl(sommet,O1)])))),appl(appl(appl(tenir,lambda(I1,lambda(J1,merge(drs([],[appl(debout,J1)]),appl(I1,J1))))),lambda(G1,appl(G1,H1))),appl(lambda(Q,lambda(R,merge(merge(drs([variable(S)],[bool(num(S),=,6)]),appl(Q,S)),appl(R,S)))),appl(lambda(E1,lambda(F1,merge(drs([],[appl(rouge,F1)]),appl(E1,F1)))),appl(appl(lambda(U,lambda(V,lambda(W,merge(appl(U,lambda(X,drs([event(Y),variable(Z)],[appl(generic,Z),appl(appl(appl(appl(porter,X),W),Z),Y)]))),appl(V,W))))),appl(lambda(A1,lambda(B1,merge(merge(drs([variable(C1)],[bool(num(C1),>,1)]),appl(A1,C1)),appl(B1,C1)))),lambda(D1,drs([],[appl(haut,D1)])))),lambda(T,drs([],[appl(enfant,T)])))))))))).

% = Reduced Semantics

semantics(102, reduced, presup(drs([variable(B),variable(C)],[appl(sommet,B),appl(montagne,C),appl(appl(de,C),B)]),merge(drs([event(A)],[]),merge(appl(appl(appl(appl(tenir,lambda(D,lambda(E,merge(drs([],[appl(debout,E)]),appl(D,E))))),lambda(F,appl(F,G))),lambda(H,merge(merge(drs([variable(I)],[bool(num(I),=,6)]),merge(drs([],[appl(rouge,I)]),merge(merge(merge(drs([variable(J)],[bool(num(J),>,1)]),drs([],[appl(haut,J)])),drs([event(K),variable(L)],[appl(generic,L),appl(appl(appl(appl(porter,J),I),L),K)])),drs([],[appl(enfant,I)])))),appl(H,I)))),A),drs([],[appl(appl(à,B),A)]))))).


% = Semantics

semantics(103, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(vert,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(rouge,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(103, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(vert,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(rouge,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(105, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(vert,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(rouge,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(105, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(vert,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(rouge,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(107, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(vert,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(rouge,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(107, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(vert,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(rouge,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(108, unreduced, appl(lambda(H,H),appl(lambda(X,merge(drs([event(Y)],[]),appl(X,Y))),appl(appl(lambda(M,lambda(N,lambda(O,appl(N,lambda(P,appl(M,lambda(Q,drs([],[appl(appl(appl(porter,Q),P),O),bool(appl(temps,O),overlaps,maintenant)])))))))),appl(lambda(R,lambda(S,merge(merge(drs([variable(T)],[bool(num(T),>,1)]),appl(R,T)),appl(S,T)))),appl(lambda(V,lambda(W,merge(drs([],[appl(rouge,W)]),appl(V,W)))),lambda(U,drs([],[appl(haut,U)]))))),appl(lambda(I,lambda(J,merge(merge(drs([variable(K)],[bool(num(K),=,4)]),appl(I,K)),appl(J,K)))),lambda(L,drs([],[appl(enfant,L)]))))))).

% = Reduced Semantics

semantics(108, reduced, drs([event(A),variable(B),variable(C)],[bool(num(B),=,4),appl(enfant,B),bool(num(C),>,1),appl(rouge,C),appl(haut,C),appl(appl(appl(porter,C),B),A),bool(appl(temps,A),overlaps,maintenant)])).


% = Semantics

semantics(109, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(vert,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(rouge,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(109, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(vert,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(rouge,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(111, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(vert,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(rouge,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(111, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(vert,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(rouge,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(112, unreduced, appl(lambda(H,H),appl(lambda(Y,merge(drs([event(Z)],[]),appl(Y,Z))),appl(appl(lambda(P,lambda(Q,lambda(R,appl(Q,lambda(S,appl(P,lambda(T,drs([],[appl(appl(appl(porter,T),S),R),bool(appl(temps,R),overlaps,maintenant)])))))))),appl(lambda(U,lambda(V,merge(merge(drs([variable(W)],[bool(num(W),>,1)]),appl(U,W)),appl(V,W)))),lambda(X,drs([],[appl(haut,X)])))),appl(lambda(I,lambda(J,appl(I,lambda(K,merge(appl(J,K),drs([],[appl(tout,K)])))))),appl(lambda(L,lambda(M,presup(merge(drs([variable(N)],[bool(num(N),>,1)]),appl(L,N)),appl(M,N)))),lambda(O,drs([],[appl(enfant,O)])))))))).

% = Reduced Semantics

semantics(112, reduced, presup(drs([variable(B)],[bool(num(B),>,1),appl(enfant,B)]),drs([event(A),variable(C)],[bool(num(C),>,1),appl(haut,C),appl(appl(appl(porter,C),B),A),bool(appl(temps,A),overlaps,maintenant),appl(tout,B)]))).


% = Semantics

semantics(113, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(vert,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(rouge,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(113, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(vert,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(rouge,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(115, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(vert,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(rouge,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(115, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(vert,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(rouge,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(116, unreduced, appl(lambda(J,J),appl(lambda(D1,merge(drs([event(E1)],[]),appl(D1,E1))),appl(appl(lambda(S,lambda(T,lambda(U,appl(T,lambda(V,appl(S,lambda(W,drs([],[appl(appl(appl(porter,W),V),U),bool(appl(temps,U),overlaps,maintenant)])))))))),appl(lambda(X,lambda(Y,merge(merge(drs([variable(Z)],[bool(num(Z),>,1)]),appl(X,Z)),appl(Y,Z)))),appl(lambda(B1,lambda(C1,merge(drs([],[appl(rouge,C1)]),appl(B1,C1)))),lambda(A1,drs([],[appl(haut,A1)]))))),appl(lambda(K,lambda(L,appl(K,lambda(M,merge(appl(L,M),drs([],[appl(moins_de,M)])))))),appl(lambda(N,N),appl(lambda(O,lambda(P,merge(merge(drs([variable(Q)],[bool(num(Q),=,5)]),appl(O,Q)),appl(P,Q)))),lambda(R,drs([],[appl(enfant,R)]))))))))).

% = Reduced Semantics

semantics(116, reduced, drs([event(A),variable(B),variable(C)],[bool(num(B),=,5),appl(enfant,B),bool(num(C),>,1),appl(rouge,C),appl(haut,C),appl(appl(appl(porter,C),B),A),bool(appl(temps,A),overlaps,maintenant),appl(moins_de,B)])).


% = Semantics

semantics(117, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(vert,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(rouge,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(117, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(vert,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(rouge,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(119, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(vert,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(rouge,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(119, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(vert,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(rouge,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(121, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(vert,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(rouge,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(121, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(vert,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(rouge,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(123, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(vert,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(rouge,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(123, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(vert,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(rouge,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(124, unreduced, appl(lambda(H,H),appl(lambda(X,merge(drs([event(Y)],[]),appl(X,Y))),appl(appl(lambda(M,lambda(N,lambda(O,appl(N,lambda(P,appl(M,lambda(Q,drs([],[appl(appl(appl(avoir,Q),P),O),bool(appl(temps,O),overlaps,maintenant)])))))))),appl(lambda(R,lambda(S,presup(merge(drs([variable(T)],[bool(num(T),>,1)]),appl(R,T)),appl(S,T)))),appl(lambda(V,lambda(W,merge(drs([],[appl(roux,W)]),appl(V,W)))),lambda(U,drs([],[appl(cheveu,U)]))))),appl(lambda(I,lambda(J,merge(merge(drs([variable(K)],[bool(num(K),>,1)]),appl(I,K)),appl(J,K)))),lambda(L,drs([],[appl(enfant,L)]))))))).

% = Reduced Semantics

semantics(124, reduced, presup(drs([variable(C)],[bool(num(C),>,1),appl(roux,C),appl(cheveu,C)]),drs([event(A),variable(B)],[bool(num(B),>,1),appl(enfant,B),appl(appl(appl(avoir,C),B),A),bool(appl(temps,A),overlaps,maintenant)]))).


% = Semantics

semantics(126, unreduced, appl(lambda(J,J),appl(lambda(F1,merge(drs([event(G1)],[]),appl(F1,G1))),appl(appl(lambda(S,lambda(T,lambda(U,merge(appl(appl(S,T),U),drs([],[drs([event(V)],[bool(appl(temps,U),<,appl(temps,V)),bool(appl(temps,V),overlaps,maintenant)])]))))),appl(lambda(W,lambda(X,lambda(Y,appl(X,lambda(Z,appl(W,lambda(A1,drs([],[appl(appl(appl(originaire_de,A1),Z),Y)])))))))),appl(lambda(B1,lambda(C1,merge(merge(drs([variable(D1)],[]),appl(B1,D1)),appl(C1,D1)))),lambda(E1,drs([],[appl(argentin,E1)]))))),appl(lambda(K,lambda(L,appl(K,lambda(M,merge(appl(L,M),drs([],[appl(plus_de,M)])))))),appl(lambda(N,N),appl(lambda(O,lambda(P,merge(merge(drs([variable(Q)],[bool(num(Q),=,4)]),appl(O,Q)),appl(P,Q)))),lambda(R,drs([],[appl(chanteur,R)]))))))))).

% = Reduced Semantics

semantics(126, reduced, drs([event(A),variable(B),variable(C)],[bool(num(B),=,4),appl(chanteur,B),appl(argentin,C),appl(appl(appl(originaire_de,C),B),A),appl(plus_de,B),drs([event(D)],[bool(appl(temps,A),<,appl(temps,D)),bool(appl(temps,D),overlaps,maintenant)])])).


% = Semantics

semantics(128, unreduced, appl(lambda(K,K),appl(lambda(J1,merge(drs([event(K1)],[]),appl(J1,K1))),appl(appl(lambda(W,lambda(X,lambda(Y,merge(appl(appl(W,X),Y),drs([],[drs([event(Z)],[bool(appl(temps,Y),<,appl(temps,Z)),bool(appl(temps,Z),overlaps,maintenant)])]))))),appl(lambda(A1,lambda(B1,lambda(C1,appl(B1,lambda(D1,appl(A1,lambda(E1,drs([],[appl(appl(appl(originaire_de,E1),D1),C1)])))))))),appl(lambda(F1,lambda(G1,merge(merge(drs([variable(H1)],[]),appl(F1,H1)),appl(G1,H1)))),lambda(I1,drs([],[appl(argentin,I1)]))))),appl(lambda(L,lambda(M,presup(merge(drs([variable(N)],[bool(num(N),>,1)]),appl(L,N)),appl(M,N)))),appl(appl(lambda(R,lambda(S,lambda(T,presup(merge(drs([variable(U)],[bool(num(U),>,1)]),appl(R,U)),merge(appl(S,T),drs([],[appl(appl(de,U),T)])))))),lambda(V,drs([],[appl(chanteur,V)]))),appl(lambda(O,lambda(P,merge(drs([],[bool(num(P),=,2)]),appl(O,P)))),lambda(Q,drs([],[appl(tiers,Q)]))))))))).

% = Reduced Semantics

semantics(128, reduced, presup(drs([variable(C),variable(B)],[bool(num(C),>,1),appl(chanteur,C),bool(num(B),>,1),bool(num(B),=,2),appl(tiers,B),appl(appl(de,C),B)]),drs([event(A),variable(D)],[appl(argentin,D),appl(appl(appl(originaire_de,D),B),A),drs([event(E)],[bool(appl(temps,A),<,appl(temps,E)),bool(appl(temps,E),overlaps,maintenant)])]))).


% = Semantics

semantics(130, unreduced, appl(lambda(G,G),appl(lambda(U,merge(drs([event(V)],[]),appl(U,V))),appl(appl(lambda(L,lambda(M,lambda(N,appl(M,lambda(O,appl(L,lambda(P,drs([],[appl(appl(appl(venir_de,P),O),N),bool(appl(temps,N),overlaps,maintenant)])))))))),appl(lambda(Q,lambda(R,merge(merge(drs([variable(S)],[]),appl(Q,S)),appl(R,S)))),lambda(T,drs([],[appl(argentin,T)])))),appl(lambda(H,lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,2)]),appl(H,J)),appl(I,J)))),lambda(K,drs([],[appl(chanteur,K)]))))))).

% = Reduced Semantics

semantics(130, reduced, drs([event(A),variable(B),variable(C)],[bool(num(B),=,2),appl(chanteur,B),appl(argentin,C),appl(appl(appl(venir_de,C),B),A),bool(appl(temps,A),overlaps,maintenant)])).


% = Semantics

semantics(132, unreduced, appl(lambda(I,I),appl(lambda(C1,merge(drs([event(D1)],[]),appl(C1,D1))),appl(appl(lambda(T,lambda(U,lambda(V,appl(U,lambda(W,appl(T,lambda(X,drs([],[appl(appl(appl(venir_de,X),W),V),bool(appl(temps,V),overlaps,maintenant)])))))))),appl(lambda(Y,lambda(Z,merge(merge(drs([variable(A1)],[]),appl(Y,A1)),appl(Z,A1)))),lambda(B1,drs([],[appl(argentin,B1)])))),appl(lambda(J,lambda(K,presup(merge(drs([variable(L)],[]),appl(J,L)),appl(K,L)))),appl(lambda(M,lambda(N,appl(M,lambda(O,drs([],[appl(plupart_de,O)]))))),appl(lambda(P,lambda(Q,presup(merge(drs([variable(R)],[bool(num(R),>,1)]),appl(P,R)),appl(Q,R)))),lambda(S,drs([],[appl(chanteur,S)]))))))))).

% = Reduced Semantics

semantics(132, reduced, presup(drs([variable(C),variable(B)],[bool(num(C),>,1),appl(chanteur,C),appl(plupart_de,C)]),drs([event(A),variable(D)],[appl(argentin,D),appl(appl(appl(venir_de,D),B),A),bool(appl(temps,A),overlaps,maintenant)]))).


% = Semantics

semantics(134, unreduced, appl(lambda(I,I),appl(lambda(Z,merge(drs([event(A1)],[]),appl(Z,A1))),appl(appl(lambda(N,N),lambda(A,appl(lambda(T,lambda(U,drs([],[not(appl(T,U))]))),appl(appl(lambda(O,lambda(P,lambda(Q,appl(P,lambda(R,appl(O,lambda(S,drs([],[appl(appl(appl(venir_de,S),R),Q),bool(appl(temps,Q),overlaps,maintenant)])))))))),appl(lambda(V,lambda(W,merge(merge(drs([variable(X)],[]),appl(V,X)),appl(W,X)))),lambda(Y,presup(drs([],[appl(appl(nommé,'Chili'),Y)]),drs([],[]))))),A)))),appl(lambda(J,lambda(K,merge(merge(drs([variable(L)],[bool(num(L),>,1)]),appl(J,L)),appl(K,L)))),lambda(M,drs([],[appl(chanteur,M)]))))))).

% = Reduced Semantics

semantics(134, reduced, presup(drs([],[appl(appl(nommé,'Chili'),C)]),drs([event(A)],[not(drs([variable(B),variable(C)],[bool(num(B),>,1),appl(chanteur,B),appl(appl(appl(venir_de,C),B),A),bool(appl(temps,A),overlaps,maintenant)]))]))).


% = Semantics

semantics(160, unreduced, appl(lambda(L,L),appl(lambda(K1,merge(drs([event(L1)],[]),appl(K1,L1))),appl(appl(lambda(A1,lambda(B1,lambda(C1,appl(B1,lambda(D1,appl(A1,lambda(E1,drs([],[appl(appl(appl(vivre_dans,E1),D1),C1),bool(appl(temps,C1),overlaps,maintenant)])))))))),appl(lambda(F1,F1),appl(lambda(G1,lambda(H1,presup(merge(drs([variable(I1)],[]),appl(G1,I1)),appl(H1,I1)))),lambda(J1,drs([],[appl(richesse,J1)]))))),appl(lambda(M,lambda(N,merge(merge(drs([variable(O)],[bool(num(O),=,36)]),appl(M,O)),appl(N,O)))),appl(lambda(Y,lambda(Z,merge(drs([],[appl(africain,Z)]),appl(Y,Z)))),appl(appl(lambda(Q,lambda(R,lambda(S,merge(appl(R,S),appl(Q,lambda(T,drs([],[appl(appl(de,T),S)]))))))),appl(lambda(U,lambda(V,presup(merge(drs([variable(W)],[]),appl(U,W)),appl(V,W)))),lambda(X,drs([],[appl(population,X)])))),lambda(P,drs([],[appl('%',P)]))))))))).

% = Reduced Semantics

semantics(160, reduced, presup(drs([variable(C),variable(D)],[appl(population,C),appl(richesse,D)]),drs([event(A),variable(B)],[bool(num(B),=,36),appl(africain,B),appl('%',B),appl(appl(de,C),B),appl(appl(appl(vivre_dans,D),B),A),bool(appl(temps,A),overlaps,maintenant)]))).


% = Semantics

semantics(162, unreduced, appl(lambda(M,M),appl(lambda(E1,merge(drs([event(F1)],[]),appl(E1,F1))),appl(appl(lambda(Z,lambda(A1,lambda(B1,merge(merge(drs([variable(C1)],[appl(appl(en,C1),B1)]),appl(Z,C1)),appl(A1,B1))))),lambda(D1,presup(drs([],[appl(appl(nommé,'Ukraine'),D1)]),drs([],[])))),appl(appl(appl(avoir,appl(appl(plus,appl(lambda(R,lambda(S,merge(merge(drs([variable(T)],[]),appl(R,T)),appl(S,T)))),lambda(U,drs([],[appl(femme,U)])))),appl(que,appl(lambda(V,lambda(W,merge(merge(drs([variable(X)],[]),appl(V,X)),appl(W,X)))),lambda(Y,drs([],[appl(homme,Y)])))))),lambda(P,merge(drs([variable(Q)],[bool(Q,=,?)]),appl(P,Q)))),lambda(N,merge(drs([variable(O)],[bool(O,=,'masculin?')]),appl(N,O)))))))).

% = Reduced Semantics

semantics(162, reduced, merge(drs([event(A)],[]),merge(presup(drs([],[appl(appl(nommé,'Ukraine'),B)]),drs([variable(B)],[appl(appl(en,B),A)])),appl(appl(appl(appl(avoir,appl(appl(plus,lambda(C,merge(merge(drs([variable(D)],[]),drs([],[appl(femme,D)])),appl(C,D)))),appl(que,lambda(E,merge(merge(drs([variable(F)],[]),drs([],[appl(homme,F)])),appl(E,F)))))),lambda(G,merge(drs([variable(H)],[bool(H,=,?)]),appl(G,H)))),lambda(I,merge(drs([variable(J)],[bool(J,=,'masculin?')]),appl(I,J)))),A)))).


% = Semantics

semantics(164, unreduced, appl(lambda(P,P),appl('87.',appl(appl(appl(lambda(L1,lambda(M1,lambda(N1,lambda(O1,appl(N1,lambda(P1,appl(L1,lambda(Q1,drs([],[appl(appl(appl(se_situer_entre,Q1),P1),O1),drs([event(R1)],[bool(appl(temps,R1),subseteq,appl(temps,O1)),bool(appl(temps,R1),<,maintenant)])]))))))))),appl(lambda(S1,S1),appl(appl(lambda(V1,lambda(W1,lambda(X1,merge(appl(W1,lambda(Y1,appl(X1,Y1))),appl(V1,lambda(Z1,appl(X1,Z1))))))),lambda(A2,merge(drs([variable(B2)],[appl('.',B2)]),appl(A2,B2)))),lambda(T1,merge(drs([variable(U1)],[bool(U1,=,86)]),appl(T1,U1)))))),lambda(J1,appl(J1,K1))),appl(lambda(Q,lambda(R,presup(merge(drs([variable(S)],[]),appl(Q,S)),appl(R,S)))),appl(appl(lambda(E1,lambda(F1,lambda(G1,merge(appl(F1,G1),merge(drs([variable(H1)],[appl(appl(en,H1),G1)]),appl(E1,H1)))))),lambda(I1,presup(drs([],[appl(appl(nommé,'Ukraine'),I1)]),drs([],[])))),appl(appl(lambda(W,lambda(X,lambda(Y,merge(appl(X,Y),appl(W,lambda(Z,drs([],[appl(appl(pour,Z),Y)]))))))),appl(lambda(A1,lambda(B1,merge(merge(drs([variable(C1)],[bool(num(C1),=,100)]),appl(A1,C1)),appl(B1,C1)))),lambda(D1,drs([],[appl(femme,D1)])))),appl(lambda(U,lambda(V,merge(drs([],[appl('hommes-femmes',V)]),appl(U,V)))),lambda(T,drs([],[appl(ratio,T)])))))))))).

% = Reduced Semantics

semantics(164, reduced, appl('87.',lambda(A,presup(merge(drs([variable(B)],[]),merge(merge(merge(drs([],[appl('hommes-femmes',B)]),drs([],[appl(ratio,B)])),merge(merge(drs([variable(C)],[bool(num(C),=,100)]),drs([],[appl(femme,C)])),drs([],[appl(appl(pour,C),B)]))),merge(drs([variable(D)],[appl(appl(en,D),B)]),presup(drs([],[appl(appl(nommé,'Ukraine'),D)]),drs([],[]))))),merge(merge(drs([variable(E)],[bool(E,=,86)]),drs([],[appl(appl(appl(se_situer_entre,E),B),A),drs([event(F)],[bool(appl(temps,F),subseteq,appl(temps,A)),bool(appl(temps,F),<,maintenant)])])),merge(drs([variable(G)],[appl('.',G)]),drs([],[appl(appl(appl(se_situer_entre,G),B),A),drs([event(F)],[bool(appl(temps,F),subseteq,appl(temps,A)),bool(appl(temps,F),<,maintenant)])]))))))).


% = Semantics

semantics(166, unreduced, appl(lambda(N,N),appl(lambda(I1,merge(drs([event(J1)],[]),appl(I1,J1))),appl(appl(lambda(A1,lambda(B1,lambda(C1,merge(appl(A1,lambda(D1,drs([],[appl(appl(dans,D1),C1)]))),appl(B1,C1))))),appl(lambda(E1,lambda(F1,presup(merge(drs([variable(G1)],[]),appl(E1,G1)),appl(F1,G1)))),lambda(H1,drs([],[appl(monde,H1)])))),appl(appl(appl(avoir,appl(appl(plus,appl(lambda(S,lambda(T,merge(merge(drs([variable(U)],[]),appl(S,U)),appl(T,U)))),lambda(V,drs([],[appl(femme,V)])))),appl(que,appl(lambda(W,lambda(X,merge(merge(drs([variable(Y)],[]),appl(W,Y)),appl(X,Y)))),lambda(Z,drs([],[appl(homme,Z)])))))),lambda(Q,merge(drs([variable(R)],[bool(R,=,?)]),appl(Q,R)))),lambda(O,merge(drs([variable(P)],[bool(P,=,'masculin?')]),appl(O,P)))))))).

% = Reduced Semantics

semantics(166, reduced, merge(drs([event(A)],[]),merge(presup(drs([variable(B)],[appl(monde,B)]),drs([],[appl(appl(dans,B),A)])),appl(appl(appl(appl(avoir,appl(appl(plus,lambda(C,merge(merge(drs([variable(D)],[]),drs([],[appl(femme,D)])),appl(C,D)))),appl(que,lambda(E,merge(merge(drs([variable(F)],[]),drs([],[appl(homme,F)])),appl(E,F)))))),lambda(G,merge(drs([variable(H)],[bool(H,=,?)]),appl(G,H)))),lambda(I,merge(drs([variable(J)],[bool(J,=,'masculin?')]),appl(I,J)))),A)))).


% = Semantics

semantics(168, unreduced, appl(lambda(M,M),appl(lambda(E1,merge(drs([event(F1)],[]),appl(E1,F1))),appl(appl(lambda(Z,lambda(A1,lambda(B1,merge(merge(drs([variable(C1)],[appl(appl(en,C1),B1)]),appl(Z,C1)),appl(A1,B1))))),lambda(D1,presup(drs([],[appl(appl(nommé,'Ukraine'),D1)]),drs([],[])))),appl(appl(appl(avoir,appl(appl(plus,appl(lambda(R,lambda(S,merge(merge(drs([variable(T)],[]),appl(R,T)),appl(S,T)))),lambda(U,drs([],[appl(homme,U)])))),appl(que,appl(lambda(V,lambda(W,merge(merge(drs([variable(X)],[]),appl(V,X)),appl(W,X)))),lambda(Y,drs([],[appl(femme,Y)])))))),lambda(P,merge(drs([variable(Q)],[bool(Q,=,?)]),appl(P,Q)))),lambda(N,merge(drs([variable(O)],[bool(O,=,'masculin?')]),appl(N,O)))))))).

% = Reduced Semantics

semantics(168, reduced, merge(drs([event(A)],[]),merge(presup(drs([],[appl(appl(nommé,'Ukraine'),B)]),drs([variable(B)],[appl(appl(en,B),A)])),appl(appl(appl(appl(avoir,appl(appl(plus,lambda(C,merge(merge(drs([variable(D)],[]),drs([],[appl(homme,D)])),appl(C,D)))),appl(que,lambda(E,merge(merge(drs([variable(F)],[]),drs([],[appl(femme,F)])),appl(E,F)))))),lambda(G,merge(drs([variable(H)],[bool(H,=,?)]),appl(G,H)))),lambda(I,merge(drs([variable(J)],[bool(J,=,'masculin?')]),appl(I,J)))),A)))).


% = Semantics

semantics(174, unreduced, appl(lambda(I,I),appl(lambda(A1,merge(drs([event(B1)],[]),appl(A1,B1))),appl(appl(lambda(N,N),appl(lambda(O,lambda(P,lambda(Q,appl(P,lambda(R,appl(O,lambda(S,drs([],[appl(appl(appl(porter,S),R),Q),bool(appl(temps,Q),overlaps,maintenant)])))))))),appl(lambda(T,lambda(U,appl(T,lambda(V,merge(appl(U,V),drs([],[appl(pas_de,V)])))))),appl(lambda(W,lambda(X,merge(merge(drs([variable(Y)],[]),appl(W,Y)),appl(X,Y)))),lambda(Z,drs([],[appl(bleu,Z)])))))),appl(lambda(J,lambda(K,merge(merge(drs([variable(L)],[bool(num(L),>,1)]),appl(J,L)),appl(K,L)))),lambda(M,drs([],[appl(homme,M)]))))))).

% = Reduced Semantics

semantics(174, reduced, drs([event(A),variable(B),variable(C)],[bool(num(B),>,1),appl(homme,B),appl(bleu,C),appl(appl(appl(porter,C),B),A),bool(appl(temps,A),overlaps,maintenant),appl(pas_de,C)])).


% = Semantics

semantics(180, unreduced, appl(lambda(I,I),appl(lambda(C1,merge(drs([event(D1)],[]),appl(C1,D1))),appl(appl(lambda(T,lambda(U,lambda(V,appl(U,lambda(W,appl(T,lambda(X,drs([],[appl(appl(appl(porter,X),W),V),bool(appl(temps,V),overlaps,maintenant)])))))))),appl(lambda(Y,lambda(Z,merge(merge(drs([variable(A1)],[]),appl(Y,A1)),appl(Z,A1)))),lambda(B1,drs([],[appl(bleu,B1)])))),appl(lambda(J,lambda(K,presup(merge(drs([variable(L)],[]),appl(J,L)),appl(K,L)))),appl(lambda(M,lambda(N,appl(M,lambda(O,drs([],[appl(plupart_de,O)]))))),appl(lambda(P,lambda(Q,presup(merge(drs([variable(R)],[bool(num(R),>,1)]),appl(P,R)),appl(Q,R)))),lambda(S,drs([],[appl(homme,S)]))))))))).

% = Reduced Semantics

semantics(180, reduced, presup(drs([variable(C),variable(B)],[bool(num(C),>,1),appl(homme,C),appl(plupart_de,C)]),drs([event(A),variable(D)],[appl(bleu,D),appl(appl(appl(porter,D),B),A),bool(appl(temps,A),overlaps,maintenant)]))).


% = Semantics

semantics(182, unreduced, appl(lambda(I,I),appl(lambda(X,merge(drs([event(Y)],[]),appl(X,Y))),appl(appl(lambda(O,lambda(P,lambda(Q,appl(P,lambda(R,appl(O,lambda(S,drs([],[appl(appl(appl(porter,S),R),Q),bool(appl(temps,Q),overlaps,maintenant)])))))))),appl(lambda(T,lambda(U,merge(merge(drs([variable(V)],[]),appl(T,V)),appl(U,V)))),lambda(W,drs([],[appl(rouge,W)])))),appl(appl(au,lambda(J,drs([],[appl(moins,J)]))),appl(lambda(K,lambda(L,merge(merge(drs([variable(M)],[bool(num(M),=,2)]),appl(K,M)),appl(L,M)))),lambda(N,drs([],[appl(homme,N)])))))))).

% = Reduced Semantics

semantics(182, reduced, merge(drs([event(A)],[]),appl(appl(appl(au,lambda(B,drs([],[appl(moins,B)]))),lambda(C,merge(merge(drs([variable(D)],[bool(num(D),=,2)]),drs([],[appl(homme,D)])),appl(C,D)))),lambda(E,merge(merge(drs([variable(F)],[]),drs([],[appl(rouge,F)])),drs([],[appl(appl(appl(porter,F),E),A),bool(appl(temps,A),overlaps,maintenant)])))))).


% = Semantics

semantics(201, unreduced, appl(lambda(A1,A1),appl(lambda(S3,merge(drs([event(T3)],[]),appl(S3,T3))),appl(appl(lambda(D3,lambda(E3,lambda(F3,merge(merge(drs([variable(G3)],[bool(F3,subseteq,G3)]),appl(D3,G3)),appl(E3,F3))))),appl(lambda(Q3,lambda(R3,merge(drs([],[appl(gris,R3)]),appl(Q3,R3)))),appl(appl(lambda(I3,lambda(J3,lambda(K3,merge(appl(J3,K3),appl(I3,lambda(L3,drs([],[appl(appl(de,L3),K3)]))))))),appl(lambda(M3,lambda(N3,presup(merge(drs([variable(O3)],[]),appl(M3,O3)),appl(N3,O3)))),lambda(P3,drs([],[appl(herbe,P3)])))),lambda(H3,drs([],[appl(long,H3)]))))),appl(appl(appl(lambda(F1,lambda(G1,lambda(H1,lambda(I1,appl(F1,lambda(J1,drs([event(I1)],[appl(appl(existe,J1),I1)]))))))),appl(appl(lambda(K2,lambda(L2,lambda(M2,merge(appl(L2,lambda(N2,appl(M2,N2))),appl(K2,lambda(O2,appl(M2,O2))))))),appl(lambda(P2,lambda(Q2,merge(merge(drs([variable(R2)],[]),appl(P2,R2)),appl(Q2,R2)))),appl(appl(lambda(V2,lambda(W2,lambda(X2,merge(appl(W2,X2),merge(drs([event(Y2)],[]),appl(appl(V2,lambda(Z2,appl(Z2,X2))),Y2)))))),lambda(A3,lambda(B3,appl(A3,lambda(C3,drs([],[appl(appl(courir,C3),B3),bool(appl(temps,B3),overlaps,maintenant)])))))),appl(lambda(T2,lambda(U2,merge(drs([],[appl(blanc,U2)]),appl(T2,U2)))),lambda(S2,drs([],[appl(chat,S2)])))))),appl(appl(lambda(Z1,lambda(A2,lambda(B2,merge(appl(A2,lambda(C2,appl(B2,C2))),appl(Z1,lambda(D2,appl(B2,D2))))))),appl(lambda(E2,lambda(F2,merge(merge(drs([variable(G2)],[]),appl(E2,G2)),appl(F2,G2)))),appl(lambda(I2,lambda(J2,merge(drs([],[appl(noir,J2)]),appl(I2,J2)))),lambda(H2,drs([],[appl(chat,H2)]))))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(P1,lambda(R1,appl(Q1,R1))),appl(O1,lambda(S1,appl(Q1,S1))))))),appl(lambda(T1,lambda(U1,merge(merge(drs([variable(V1)],[bool(num(V1),=,3)]),appl(T1,V1)),appl(U1,V1)))),appl(lambda(X1,lambda(Y1,merge(drs([],[appl(violet,Y1)]),appl(X1,Y1)))),lambda(W1,drs([],[appl(chat,W1)]))))),appl(lambda(K1,lambda(L1,merge(merge(drs([variable(M1)],[bool(num(M1),=,6)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(chat,N1)]))))))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,?)]),appl(D1,E1)))),lambda(B1,merge(drs([variable(C1)],[bool(C1,=,'masculin?')]),appl(B1,C1)))))))).

% = Reduced Semantics

semantics(201, reduced, presup(drs([variable(C)],[appl(herbe,C)]),drs([event(A),variable(B),variable(D),event(E),variable(F),variable(G),variable(H),event(I)],[bool(A,subseteq,B),appl(gris,B),appl(long,B),appl(appl(de,C),B),bool(num(D),=,6),appl(chat,D),appl(appl(existe,D),A),bool(num(F),=,3),appl(violet,F),appl(chat,F),appl(appl(existe,F),A),appl(noir,G),appl(chat,G),appl(appl(existe,G),A),appl(blanc,H),appl(chat,H),appl(appl(courir,H),I),bool(appl(temps,I),overlaps,maintenant),appl(appl(existe,H),A)]))).


% = Semantics

semantics(202, unreduced, appl(lambda(F,F),appl(lambda(Q,merge(drs([event(R)],[]),appl(Q,R))),appl(appl(lambda(M,lambda(N,lambda(O,appl(N,lambda(P,drs([],[appl(appl('s\'asseoir',P),O),bool(appl(temps,O),overlaps,maintenant)])))))),lambda(K,appl(K,L))),appl(lambda(G,lambda(H,merge(merge(drs([variable(I)],[bool(num(I),>,1)]),appl(G,I)),appl(H,I)))),lambda(J,drs([],[appl(chat,J)]))))))).

% = Reduced Semantics

semantics(202, reduced, drs([event(A),variable(B)],[bool(num(B),>,1),appl(chat,B),appl(appl('s\'asseoir',B),A),bool(appl(temps,A),overlaps,maintenant)])).


% = Semantics

semantics(203, unreduced, appl(lambda(A1,A1),appl(lambda(S3,merge(drs([event(T3)],[]),appl(S3,T3))),appl(appl(lambda(D3,lambda(E3,lambda(F3,merge(merge(drs([variable(G3)],[bool(F3,subseteq,G3)]),appl(D3,G3)),appl(E3,F3))))),appl(lambda(Q3,lambda(R3,merge(drs([],[appl(gris,R3)]),appl(Q3,R3)))),appl(appl(lambda(I3,lambda(J3,lambda(K3,merge(appl(J3,K3),appl(I3,lambda(L3,drs([],[appl(appl(de,L3),K3)]))))))),appl(lambda(M3,lambda(N3,presup(merge(drs([variable(O3)],[]),appl(M3,O3)),appl(N3,O3)))),lambda(P3,drs([],[appl(herbe,P3)])))),lambda(H3,drs([],[appl(long,H3)]))))),appl(appl(appl(lambda(F1,lambda(G1,lambda(H1,lambda(I1,appl(F1,lambda(J1,drs([event(I1)],[appl(appl(existe,J1),I1)]))))))),appl(appl(lambda(K2,lambda(L2,lambda(M2,merge(appl(L2,lambda(N2,appl(M2,N2))),appl(K2,lambda(O2,appl(M2,O2))))))),appl(lambda(P2,lambda(Q2,merge(merge(drs([variable(R2)],[]),appl(P2,R2)),appl(Q2,R2)))),appl(appl(lambda(V2,lambda(W2,lambda(X2,merge(appl(W2,X2),merge(drs([event(Y2)],[]),appl(appl(V2,lambda(Z2,appl(Z2,X2))),Y2)))))),lambda(A3,lambda(B3,appl(A3,lambda(C3,drs([],[appl(appl(courir,C3),B3),bool(appl(temps,B3),overlaps,maintenant)])))))),appl(lambda(T2,lambda(U2,merge(drs([],[appl(blanc,U2)]),appl(T2,U2)))),lambda(S2,drs([],[appl(chat,S2)])))))),appl(appl(lambda(Z1,lambda(A2,lambda(B2,merge(appl(A2,lambda(C2,appl(B2,C2))),appl(Z1,lambda(D2,appl(B2,D2))))))),appl(lambda(E2,lambda(F2,merge(merge(drs([variable(G2)],[]),appl(E2,G2)),appl(F2,G2)))),appl(lambda(I2,lambda(J2,merge(drs([],[appl(noir,J2)]),appl(I2,J2)))),lambda(H2,drs([],[appl(chat,H2)]))))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(P1,lambda(R1,appl(Q1,R1))),appl(O1,lambda(S1,appl(Q1,S1))))))),appl(lambda(T1,lambda(U1,merge(merge(drs([variable(V1)],[bool(num(V1),=,3)]),appl(T1,V1)),appl(U1,V1)))),appl(lambda(X1,lambda(Y1,merge(drs([],[appl(violet,Y1)]),appl(X1,Y1)))),lambda(W1,drs([],[appl(chat,W1)]))))),appl(lambda(K1,lambda(L1,merge(merge(drs([variable(M1)],[bool(num(M1),=,6)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(chat,N1)]))))))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,?)]),appl(D1,E1)))),lambda(B1,merge(drs([variable(C1)],[bool(C1,=,'masculin?')]),appl(B1,C1)))))))).

% = Reduced Semantics

semantics(203, reduced, presup(drs([variable(C)],[appl(herbe,C)]),drs([event(A),variable(B),variable(D),event(E),variable(F),variable(G),variable(H),event(I)],[bool(A,subseteq,B),appl(gris,B),appl(long,B),appl(appl(de,C),B),bool(num(D),=,6),appl(chat,D),appl(appl(existe,D),A),bool(num(F),=,3),appl(violet,F),appl(chat,F),appl(appl(existe,F),A),appl(noir,G),appl(chat,G),appl(appl(existe,G),A),appl(blanc,H),appl(chat,H),appl(appl(courir,H),I),bool(appl(temps,I),overlaps,maintenant),appl(appl(existe,H),A)]))).


% = Semantics

semantics(204, unreduced, appl(lambda(G,G),appl(lambda(R,merge(drs([event(S)],[]),appl(R,S))),appl(lambda(P,lambda(Q,drs([],[not(appl(P,Q))]))),appl(appl(lambda(L,L),lambda(M,lambda(N,appl(M,lambda(O,drs([],[appl(appl(courir,O),N),bool(appl(temps,N),overlaps,maintenant)])))))),appl(lambda(H,lambda(I,merge(merge(drs([variable(J)],[bool(num(J),>,1)]),appl(H,J)),appl(I,J)))),lambda(K,drs([],[appl(chat,K)])))))))).

% = Reduced Semantics

semantics(204, reduced, drs([event(A)],[not(drs([variable(B)],[bool(num(B),>,1),appl(chat,B),appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant)]))])).


% = Semantics

semantics(205, unreduced, appl(lambda(A1,A1),appl(lambda(S3,merge(drs([event(T3)],[]),appl(S3,T3))),appl(appl(lambda(D3,lambda(E3,lambda(F3,merge(merge(drs([variable(G3)],[bool(F3,subseteq,G3)]),appl(D3,G3)),appl(E3,F3))))),appl(lambda(Q3,lambda(R3,merge(drs([],[appl(gris,R3)]),appl(Q3,R3)))),appl(appl(lambda(I3,lambda(J3,lambda(K3,merge(appl(J3,K3),appl(I3,lambda(L3,drs([],[appl(appl(de,L3),K3)]))))))),appl(lambda(M3,lambda(N3,presup(merge(drs([variable(O3)],[]),appl(M3,O3)),appl(N3,O3)))),lambda(P3,drs([],[appl(herbe,P3)])))),lambda(H3,drs([],[appl(long,H3)]))))),appl(appl(appl(lambda(F1,lambda(G1,lambda(H1,lambda(I1,appl(F1,lambda(J1,drs([event(I1)],[appl(appl(existe,J1),I1)]))))))),appl(appl(lambda(K2,lambda(L2,lambda(M2,merge(appl(L2,lambda(N2,appl(M2,N2))),appl(K2,lambda(O2,appl(M2,O2))))))),appl(lambda(P2,lambda(Q2,merge(merge(drs([variable(R2)],[]),appl(P2,R2)),appl(Q2,R2)))),appl(appl(lambda(V2,lambda(W2,lambda(X2,merge(appl(W2,X2),merge(drs([event(Y2)],[]),appl(appl(V2,lambda(Z2,appl(Z2,X2))),Y2)))))),lambda(A3,lambda(B3,appl(A3,lambda(C3,drs([],[appl(appl(courir,C3),B3),bool(appl(temps,B3),overlaps,maintenant)])))))),appl(lambda(T2,lambda(U2,merge(drs([],[appl(blanc,U2)]),appl(T2,U2)))),lambda(S2,drs([],[appl(chat,S2)])))))),appl(appl(lambda(Z1,lambda(A2,lambda(B2,merge(appl(A2,lambda(C2,appl(B2,C2))),appl(Z1,lambda(D2,appl(B2,D2))))))),appl(lambda(E2,lambda(F2,merge(merge(drs([variable(G2)],[]),appl(E2,G2)),appl(F2,G2)))),appl(lambda(I2,lambda(J2,merge(drs([],[appl(noir,J2)]),appl(I2,J2)))),lambda(H2,drs([],[appl(chat,H2)]))))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(P1,lambda(R1,appl(Q1,R1))),appl(O1,lambda(S1,appl(Q1,S1))))))),appl(lambda(T1,lambda(U1,merge(merge(drs([variable(V1)],[bool(num(V1),=,3)]),appl(T1,V1)),appl(U1,V1)))),appl(lambda(X1,lambda(Y1,merge(drs([],[appl(violet,Y1)]),appl(X1,Y1)))),lambda(W1,drs([],[appl(chat,W1)]))))),appl(lambda(K1,lambda(L1,merge(merge(drs([variable(M1)],[bool(num(M1),=,6)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(chat,N1)]))))))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,?)]),appl(D1,E1)))),lambda(B1,merge(drs([variable(C1)],[bool(C1,=,'masculin?')]),appl(B1,C1)))))))).

% = Reduced Semantics

semantics(205, reduced, presup(drs([variable(C)],[appl(herbe,C)]),drs([event(A),variable(B),variable(D),event(E),variable(F),variable(G),variable(H),event(I)],[bool(A,subseteq,B),appl(gris,B),appl(long,B),appl(appl(de,C),B),bool(num(D),=,6),appl(chat,D),appl(appl(existe,D),A),bool(num(F),=,3),appl(violet,F),appl(chat,F),appl(appl(existe,F),A),appl(noir,G),appl(chat,G),appl(appl(existe,G),A),appl(blanc,H),appl(chat,H),appl(appl(courir,H),I),bool(appl(temps,I),overlaps,maintenant),appl(appl(existe,H),A)]))).


% = Semantics

semantics(206, unreduced, appl(lambda(E,E),appl(lambda(M,merge(drs([event(N)],[]),appl(M,N))),appl(lambda(J,lambda(K,appl(J,lambda(L,drs([],[appl(appl(court,L),K)]))))),appl(lambda(F,lambda(G,drs([],[bool(merge(drs([variable(H)],[]),appl(F,H)),->,appl(G,H))]))),lambda(I,drs([],[appl(chat,I)]))))))).

% = Reduced Semantics

semantics(206, reduced, drs([event(A)],[bool(drs([variable(B)],[appl(chat,B)]),->,drs([],[appl(appl(court,B),A)]))])).


% = Semantics

semantics(207, unreduced, appl(lambda(A1,A1),appl(lambda(S3,merge(drs([event(T3)],[]),appl(S3,T3))),appl(appl(lambda(D3,lambda(E3,lambda(F3,merge(merge(drs([variable(G3)],[bool(F3,subseteq,G3)]),appl(D3,G3)),appl(E3,F3))))),appl(lambda(Q3,lambda(R3,merge(drs([],[appl(gris,R3)]),appl(Q3,R3)))),appl(appl(lambda(I3,lambda(J3,lambda(K3,merge(appl(J3,K3),appl(I3,lambda(L3,drs([],[appl(appl(de,L3),K3)]))))))),appl(lambda(M3,lambda(N3,presup(merge(drs([variable(O3)],[]),appl(M3,O3)),appl(N3,O3)))),lambda(P3,drs([],[appl(herbe,P3)])))),lambda(H3,drs([],[appl(long,H3)]))))),appl(appl(appl(lambda(F1,lambda(G1,lambda(H1,lambda(I1,appl(F1,lambda(J1,drs([event(I1)],[appl(appl(existe,J1),I1)]))))))),appl(appl(lambda(K2,lambda(L2,lambda(M2,merge(appl(L2,lambda(N2,appl(M2,N2))),appl(K2,lambda(O2,appl(M2,O2))))))),appl(lambda(P2,lambda(Q2,merge(merge(drs([variable(R2)],[]),appl(P2,R2)),appl(Q2,R2)))),appl(appl(lambda(V2,lambda(W2,lambda(X2,merge(appl(W2,X2),merge(drs([event(Y2)],[]),appl(appl(V2,lambda(Z2,appl(Z2,X2))),Y2)))))),lambda(A3,lambda(B3,appl(A3,lambda(C3,drs([],[appl(appl(courir,C3),B3),bool(appl(temps,B3),overlaps,maintenant)])))))),appl(lambda(T2,lambda(U2,merge(drs([],[appl(blanc,U2)]),appl(T2,U2)))),lambda(S2,drs([],[appl(chat,S2)])))))),appl(appl(lambda(Z1,lambda(A2,lambda(B2,merge(appl(A2,lambda(C2,appl(B2,C2))),appl(Z1,lambda(D2,appl(B2,D2))))))),appl(lambda(E2,lambda(F2,merge(merge(drs([variable(G2)],[]),appl(E2,G2)),appl(F2,G2)))),appl(lambda(I2,lambda(J2,merge(drs([],[appl(noir,J2)]),appl(I2,J2)))),lambda(H2,drs([],[appl(chat,H2)]))))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(P1,lambda(R1,appl(Q1,R1))),appl(O1,lambda(S1,appl(Q1,S1))))))),appl(lambda(T1,lambda(U1,merge(merge(drs([variable(V1)],[bool(num(V1),=,3)]),appl(T1,V1)),appl(U1,V1)))),appl(lambda(X1,lambda(Y1,merge(drs([],[appl(violet,Y1)]),appl(X1,Y1)))),lambda(W1,drs([],[appl(chat,W1)]))))),appl(lambda(K1,lambda(L1,merge(merge(drs([variable(M1)],[bool(num(M1),=,6)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(chat,N1)]))))))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,?)]),appl(D1,E1)))),lambda(B1,merge(drs([variable(C1)],[bool(C1,=,'masculin?')]),appl(B1,C1)))))))).

% = Reduced Semantics

semantics(207, reduced, presup(drs([variable(C)],[appl(herbe,C)]),drs([event(A),variable(B),variable(D),event(E),variable(F),variable(G),variable(H),event(I)],[bool(A,subseteq,B),appl(gris,B),appl(long,B),appl(appl(de,C),B),bool(num(D),=,6),appl(chat,D),appl(appl(existe,D),A),bool(num(F),=,3),appl(violet,F),appl(chat,F),appl(appl(existe,F),A),appl(noir,G),appl(chat,G),appl(appl(existe,G),A),appl(blanc,H),appl(chat,H),appl(appl(courir,H),I),bool(appl(temps,I),overlaps,maintenant),appl(appl(existe,H),A)]))).


% = Semantics

semantics(208, unreduced, appl(lambda(H,H),appl(lambda(X,merge(drs([event(Y)],[]),appl(X,Y))),appl(appl(lambda(Q,lambda(R,lambda(S,presup(drs([],[bool(appl(temps,S),overlaps,maintenant)]),appl(appl(Q,R),S))))),lambda(T,lambda(U,appl(T,lambda(V,drs([variable(W)],[bool(W,=,'context?'),appl(appl(appl(asseoir,V),W),U)])))))),appl(lambda(I,lambda(J,appl(I,lambda(K,merge(appl(J,K),drs([],[appl(plus_de,K)])))))),appl(lambda(L,L),appl(lambda(M,lambda(N,merge(merge(drs([variable(O)],[]),appl(M,O)),appl(N,O)))),lambda(P,drs([],[appl(chat,P)]))))))))).

% = Reduced Semantics

semantics(208, reduced, presup(drs([],[bool(appl(temps,A),overlaps,maintenant)]),drs([event(A),variable(B),variable(C)],[appl(chat,B),bool(C,=,'context?'),appl(appl(appl(asseoir,B),C),A),appl(plus_de,B)]))).


% = Semantics

semantics(209, unreduced, appl(lambda(A1,A1),appl(lambda(S3,merge(drs([event(T3)],[]),appl(S3,T3))),appl(appl(lambda(D3,lambda(E3,lambda(F3,merge(merge(drs([variable(G3)],[bool(F3,subseteq,G3)]),appl(D3,G3)),appl(E3,F3))))),appl(lambda(Q3,lambda(R3,merge(drs([],[appl(gris,R3)]),appl(Q3,R3)))),appl(appl(lambda(I3,lambda(J3,lambda(K3,merge(appl(J3,K3),appl(I3,lambda(L3,drs([],[appl(appl(de,L3),K3)]))))))),appl(lambda(M3,lambda(N3,presup(merge(drs([variable(O3)],[]),appl(M3,O3)),appl(N3,O3)))),lambda(P3,drs([],[appl(herbe,P3)])))),lambda(H3,drs([],[appl(long,H3)]))))),appl(appl(appl(lambda(F1,lambda(G1,lambda(H1,lambda(I1,appl(F1,lambda(J1,drs([event(I1)],[appl(appl(existe,J1),I1)]))))))),appl(appl(lambda(K2,lambda(L2,lambda(M2,merge(appl(L2,lambda(N2,appl(M2,N2))),appl(K2,lambda(O2,appl(M2,O2))))))),appl(lambda(P2,lambda(Q2,merge(merge(drs([variable(R2)],[]),appl(P2,R2)),appl(Q2,R2)))),appl(appl(lambda(V2,lambda(W2,lambda(X2,merge(appl(W2,X2),merge(drs([event(Y2)],[]),appl(appl(V2,lambda(Z2,appl(Z2,X2))),Y2)))))),lambda(A3,lambda(B3,appl(A3,lambda(C3,drs([],[appl(appl(courir,C3),B3),bool(appl(temps,B3),overlaps,maintenant)])))))),appl(lambda(T2,lambda(U2,merge(drs([],[appl(blanc,U2)]),appl(T2,U2)))),lambda(S2,drs([],[appl(chat,S2)])))))),appl(appl(lambda(Z1,lambda(A2,lambda(B2,merge(appl(A2,lambda(C2,appl(B2,C2))),appl(Z1,lambda(D2,appl(B2,D2))))))),appl(lambda(E2,lambda(F2,merge(merge(drs([variable(G2)],[]),appl(E2,G2)),appl(F2,G2)))),appl(lambda(I2,lambda(J2,merge(drs([],[appl(noir,J2)]),appl(I2,J2)))),lambda(H2,drs([],[appl(chat,H2)]))))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(P1,lambda(R1,appl(Q1,R1))),appl(O1,lambda(S1,appl(Q1,S1))))))),appl(lambda(T1,lambda(U1,merge(merge(drs([variable(V1)],[bool(num(V1),=,3)]),appl(T1,V1)),appl(U1,V1)))),appl(lambda(X1,lambda(Y1,merge(drs([],[appl(violet,Y1)]),appl(X1,Y1)))),lambda(W1,drs([],[appl(chat,W1)]))))),appl(lambda(K1,lambda(L1,merge(merge(drs([variable(M1)],[bool(num(M1),=,6)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(chat,N1)]))))))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,?)]),appl(D1,E1)))),lambda(B1,merge(drs([variable(C1)],[bool(C1,=,'masculin?')]),appl(B1,C1)))))))).

% = Reduced Semantics

semantics(209, reduced, presup(drs([variable(C)],[appl(herbe,C)]),drs([event(A),variable(B),variable(D),event(E),variable(F),variable(G),variable(H),event(I)],[bool(A,subseteq,B),appl(gris,B),appl(long,B),appl(appl(de,C),B),bool(num(D),=,6),appl(chat,D),appl(appl(existe,D),A),bool(num(F),=,3),appl(violet,F),appl(chat,F),appl(appl(existe,F),A),appl(noir,G),appl(chat,G),appl(appl(existe,G),A),appl(blanc,H),appl(chat,H),appl(appl(courir,H),I),bool(appl(temps,I),overlaps,maintenant),appl(appl(existe,H),A)]))).


% = Semantics

semantics(210, unreduced, appl(lambda(F,F),appl(lambda(Q,merge(drs([event(R)],[]),appl(Q,R))),appl(lambda(N,lambda(O,appl(N,lambda(P,drs([],[appl(appl(courir,P),O),bool(appl(temps,O),overlaps,maintenant)]))))),appl(lambda(G,lambda(H,appl(G,lambda(I,merge(appl(H,I),drs([],[appl(tout,I)])))))),appl(lambda(J,lambda(K,presup(merge(drs([variable(L)],[bool(num(L),>,1)]),appl(J,L)),appl(K,L)))),lambda(M,drs([],[appl(chat,M)])))))))).

% = Reduced Semantics

semantics(210, reduced, presup(drs([variable(B)],[bool(num(B),>,1),appl(chat,B)]),drs([event(A)],[appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant),appl(tout,B)]))).


% = Semantics

semantics(211, unreduced, appl(lambda(A1,A1),appl(lambda(S3,merge(drs([event(T3)],[]),appl(S3,T3))),appl(appl(lambda(D3,lambda(E3,lambda(F3,merge(merge(drs([variable(G3)],[bool(F3,subseteq,G3)]),appl(D3,G3)),appl(E3,F3))))),appl(lambda(Q3,lambda(R3,merge(drs([],[appl(gris,R3)]),appl(Q3,R3)))),appl(appl(lambda(I3,lambda(J3,lambda(K3,merge(appl(J3,K3),appl(I3,lambda(L3,drs([],[appl(appl(de,L3),K3)]))))))),appl(lambda(M3,lambda(N3,presup(merge(drs([variable(O3)],[]),appl(M3,O3)),appl(N3,O3)))),lambda(P3,drs([],[appl(herbe,P3)])))),lambda(H3,drs([],[appl(long,H3)]))))),appl(appl(appl(lambda(F1,lambda(G1,lambda(H1,lambda(I1,appl(F1,lambda(J1,drs([event(I1)],[appl(appl(existe,J1),I1)]))))))),appl(appl(lambda(K2,lambda(L2,lambda(M2,merge(appl(L2,lambda(N2,appl(M2,N2))),appl(K2,lambda(O2,appl(M2,O2))))))),appl(lambda(P2,lambda(Q2,merge(merge(drs([variable(R2)],[]),appl(P2,R2)),appl(Q2,R2)))),appl(appl(lambda(V2,lambda(W2,lambda(X2,merge(appl(W2,X2),merge(drs([event(Y2)],[]),appl(appl(V2,lambda(Z2,appl(Z2,X2))),Y2)))))),lambda(A3,lambda(B3,appl(A3,lambda(C3,drs([],[appl(appl(courir,C3),B3),bool(appl(temps,B3),overlaps,maintenant)])))))),appl(lambda(T2,lambda(U2,merge(drs([],[appl(blanc,U2)]),appl(T2,U2)))),lambda(S2,drs([],[appl(chat,S2)])))))),appl(appl(lambda(Z1,lambda(A2,lambda(B2,merge(appl(A2,lambda(C2,appl(B2,C2))),appl(Z1,lambda(D2,appl(B2,D2))))))),appl(lambda(E2,lambda(F2,merge(merge(drs([variable(G2)],[]),appl(E2,G2)),appl(F2,G2)))),appl(lambda(I2,lambda(J2,merge(drs([],[appl(noir,J2)]),appl(I2,J2)))),lambda(H2,drs([],[appl(chat,H2)]))))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(P1,lambda(R1,appl(Q1,R1))),appl(O1,lambda(S1,appl(Q1,S1))))))),appl(lambda(T1,lambda(U1,merge(merge(drs([variable(V1)],[bool(num(V1),=,3)]),appl(T1,V1)),appl(U1,V1)))),appl(lambda(X1,lambda(Y1,merge(drs([],[appl(violet,Y1)]),appl(X1,Y1)))),lambda(W1,drs([],[appl(chat,W1)]))))),appl(lambda(K1,lambda(L1,merge(merge(drs([variable(M1)],[bool(num(M1),=,6)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(chat,N1)]))))))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,?)]),appl(D1,E1)))),lambda(B1,merge(drs([variable(C1)],[bool(C1,=,'masculin?')]),appl(B1,C1)))))))).

% = Reduced Semantics

semantics(211, reduced, presup(drs([variable(C)],[appl(herbe,C)]),drs([event(A),variable(B),variable(D),event(E),variable(F),variable(G),variable(H),event(I)],[bool(A,subseteq,B),appl(gris,B),appl(long,B),appl(appl(de,C),B),bool(num(D),=,6),appl(chat,D),appl(appl(existe,D),A),bool(num(F),=,3),appl(violet,F),appl(chat,F),appl(appl(existe,F),A),appl(noir,G),appl(chat,G),appl(appl(existe,G),A),appl(blanc,H),appl(chat,H),appl(appl(courir,H),I),bool(appl(temps,I),overlaps,maintenant),appl(appl(existe,H),A)]))).


% = Semantics

semantics(212, unreduced, appl(lambda(G,G),appl(lambda(S,merge(drs([event(T)],[]),appl(S,T))),appl(lambda(P,lambda(Q,appl(P,lambda(R,drs([],[appl(appl(courir,R),Q),bool(appl(temps,Q),overlaps,maintenant)]))))),appl(lambda(H,lambda(I,appl(H,lambda(J,merge(appl(I,J),drs([],[appl(plus_de,J)])))))),appl(lambda(K,K),appl(lambda(L,lambda(M,merge(merge(drs([variable(N)],[bool(num(N),=,2)]),appl(L,N)),appl(M,N)))),lambda(O,drs([],[appl(chat,O)]))))))))).

% = Reduced Semantics

semantics(212, reduced, drs([event(A),variable(B)],[bool(num(B),=,2),appl(chat,B),appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant),appl(plus_de,B)])).


% = Semantics

semantics(213, unreduced, appl(lambda(A1,A1),appl(lambda(S3,merge(drs([event(T3)],[]),appl(S3,T3))),appl(appl(lambda(D3,lambda(E3,lambda(F3,merge(merge(drs([variable(G3)],[bool(F3,subseteq,G3)]),appl(D3,G3)),appl(E3,F3))))),appl(lambda(Q3,lambda(R3,merge(drs([],[appl(gris,R3)]),appl(Q3,R3)))),appl(appl(lambda(I3,lambda(J3,lambda(K3,merge(appl(J3,K3),appl(I3,lambda(L3,drs([],[appl(appl(de,L3),K3)]))))))),appl(lambda(M3,lambda(N3,presup(merge(drs([variable(O3)],[]),appl(M3,O3)),appl(N3,O3)))),lambda(P3,drs([],[appl(herbe,P3)])))),lambda(H3,drs([],[appl(long,H3)]))))),appl(appl(appl(lambda(F1,lambda(G1,lambda(H1,lambda(I1,appl(F1,lambda(J1,drs([event(I1)],[appl(appl(existe,J1),I1)]))))))),appl(appl(lambda(K2,lambda(L2,lambda(M2,merge(appl(L2,lambda(N2,appl(M2,N2))),appl(K2,lambda(O2,appl(M2,O2))))))),appl(lambda(P2,lambda(Q2,merge(merge(drs([variable(R2)],[]),appl(P2,R2)),appl(Q2,R2)))),appl(appl(lambda(V2,lambda(W2,lambda(X2,merge(appl(W2,X2),merge(drs([event(Y2)],[]),appl(appl(V2,lambda(Z2,appl(Z2,X2))),Y2)))))),lambda(A3,lambda(B3,appl(A3,lambda(C3,drs([],[appl(appl(courir,C3),B3),bool(appl(temps,B3),overlaps,maintenant)])))))),appl(lambda(T2,lambda(U2,merge(drs([],[appl(blanc,U2)]),appl(T2,U2)))),lambda(S2,drs([],[appl(chat,S2)])))))),appl(appl(lambda(Z1,lambda(A2,lambda(B2,merge(appl(A2,lambda(C2,appl(B2,C2))),appl(Z1,lambda(D2,appl(B2,D2))))))),appl(lambda(E2,lambda(F2,merge(merge(drs([variable(G2)],[]),appl(E2,G2)),appl(F2,G2)))),appl(lambda(I2,lambda(J2,merge(drs([],[appl(noir,J2)]),appl(I2,J2)))),lambda(H2,drs([],[appl(chat,H2)]))))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(P1,lambda(R1,appl(Q1,R1))),appl(O1,lambda(S1,appl(Q1,S1))))))),appl(lambda(T1,lambda(U1,merge(merge(drs([variable(V1)],[bool(num(V1),=,3)]),appl(T1,V1)),appl(U1,V1)))),appl(lambda(X1,lambda(Y1,merge(drs([],[appl(violet,Y1)]),appl(X1,Y1)))),lambda(W1,drs([],[appl(chat,W1)]))))),appl(lambda(K1,lambda(L1,merge(merge(drs([variable(M1)],[bool(num(M1),=,6)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(chat,N1)]))))))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,?)]),appl(D1,E1)))),lambda(B1,merge(drs([variable(C1)],[bool(C1,=,'masculin?')]),appl(B1,C1)))))))).

% = Reduced Semantics

semantics(213, reduced, presup(drs([variable(C)],[appl(herbe,C)]),drs([event(A),variable(B),variable(D),event(E),variable(F),variable(G),variable(H),event(I)],[bool(A,subseteq,B),appl(gris,B),appl(long,B),appl(appl(de,C),B),bool(num(D),=,6),appl(chat,D),appl(appl(existe,D),A),bool(num(F),=,3),appl(violet,F),appl(chat,F),appl(appl(existe,F),A),appl(noir,G),appl(chat,G),appl(appl(existe,G),A),appl(blanc,H),appl(chat,H),appl(appl(courir,H),I),bool(appl(temps,I),overlaps,maintenant),appl(appl(existe,H),A)]))).


% = Semantics

semantics(214, unreduced, appl(lambda(H,H),appl(lambda(X,merge(drs([event(Y)],[]),appl(X,Y))),appl(appl(lambda(Q,lambda(R,lambda(S,presup(drs([],[bool(appl(temps,S),overlaps,maintenant)]),appl(appl(Q,R),S))))),lambda(T,lambda(U,appl(T,lambda(V,drs([variable(W)],[bool(W,=,'context?'),appl(appl(appl(asseoir,V),W),U)])))))),appl(lambda(I,lambda(J,appl(I,lambda(K,merge(appl(J,K),drs([],[appl(plus_de,K)])))))),appl(lambda(L,L),appl(lambda(M,lambda(N,merge(merge(drs([variable(O)],[bool(num(O),=,4)]),appl(M,O)),appl(N,O)))),lambda(P,drs([],[appl(chat,P)]))))))))).

% = Reduced Semantics

semantics(214, reduced, presup(drs([],[bool(appl(temps,A),overlaps,maintenant)]),drs([event(A),variable(B),variable(C)],[bool(num(B),=,4),appl(chat,B),bool(C,=,'context?'),appl(appl(appl(asseoir,B),C),A),appl(plus_de,B)]))).


% = Semantics

semantics(215, unreduced, appl(lambda(A1,A1),appl(lambda(S3,merge(drs([event(T3)],[]),appl(S3,T3))),appl(appl(lambda(D3,lambda(E3,lambda(F3,merge(merge(drs([variable(G3)],[bool(F3,subseteq,G3)]),appl(D3,G3)),appl(E3,F3))))),appl(lambda(Q3,lambda(R3,merge(drs([],[appl(gris,R3)]),appl(Q3,R3)))),appl(appl(lambda(I3,lambda(J3,lambda(K3,merge(appl(J3,K3),appl(I3,lambda(L3,drs([],[appl(appl(de,L3),K3)]))))))),appl(lambda(M3,lambda(N3,presup(merge(drs([variable(O3)],[]),appl(M3,O3)),appl(N3,O3)))),lambda(P3,drs([],[appl(herbe,P3)])))),lambda(H3,drs([],[appl(long,H3)]))))),appl(appl(appl(lambda(F1,lambda(G1,lambda(H1,lambda(I1,appl(F1,lambda(J1,drs([event(I1)],[appl(appl(existe,J1),I1)]))))))),appl(appl(lambda(K2,lambda(L2,lambda(M2,merge(appl(L2,lambda(N2,appl(M2,N2))),appl(K2,lambda(O2,appl(M2,O2))))))),appl(lambda(P2,lambda(Q2,merge(merge(drs([variable(R2)],[]),appl(P2,R2)),appl(Q2,R2)))),appl(appl(lambda(V2,lambda(W2,lambda(X2,merge(appl(W2,X2),merge(drs([event(Y2)],[]),appl(appl(V2,lambda(Z2,appl(Z2,X2))),Y2)))))),lambda(A3,lambda(B3,appl(A3,lambda(C3,drs([],[appl(appl(courir,C3),B3),bool(appl(temps,B3),overlaps,maintenant)])))))),appl(lambda(T2,lambda(U2,merge(drs([],[appl(blanc,U2)]),appl(T2,U2)))),lambda(S2,drs([],[appl(chat,S2)])))))),appl(appl(lambda(Z1,lambda(A2,lambda(B2,merge(appl(A2,lambda(C2,appl(B2,C2))),appl(Z1,lambda(D2,appl(B2,D2))))))),appl(lambda(E2,lambda(F2,merge(merge(drs([variable(G2)],[]),appl(E2,G2)),appl(F2,G2)))),appl(lambda(I2,lambda(J2,merge(drs([],[appl(noir,J2)]),appl(I2,J2)))),lambda(H2,drs([],[appl(chat,H2)]))))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(P1,lambda(R1,appl(Q1,R1))),appl(O1,lambda(S1,appl(Q1,S1))))))),appl(lambda(T1,lambda(U1,merge(merge(drs([variable(V1)],[bool(num(V1),=,3)]),appl(T1,V1)),appl(U1,V1)))),appl(lambda(X1,lambda(Y1,merge(drs([],[appl(violet,Y1)]),appl(X1,Y1)))),lambda(W1,drs([],[appl(chat,W1)]))))),appl(lambda(K1,lambda(L1,merge(merge(drs([variable(M1)],[bool(num(M1),=,6)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(chat,N1)]))))))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,?)]),appl(D1,E1)))),lambda(B1,merge(drs([variable(C1)],[bool(C1,=,'masculin?')]),appl(B1,C1)))))))).

% = Reduced Semantics

semantics(215, reduced, presup(drs([variable(C)],[appl(herbe,C)]),drs([event(A),variable(B),variable(D),event(E),variable(F),variable(G),variable(H),event(I)],[bool(A,subseteq,B),appl(gris,B),appl(long,B),appl(appl(de,C),B),bool(num(D),=,6),appl(chat,D),appl(appl(existe,D),A),bool(num(F),=,3),appl(violet,F),appl(chat,F),appl(appl(existe,F),A),appl(noir,G),appl(chat,G),appl(appl(existe,G),A),appl(blanc,H),appl(chat,H),appl(appl(courir,H),I),bool(appl(temps,I),overlaps,maintenant),appl(appl(existe,H),A)]))).


% = Semantics

semantics(216, unreduced, appl(lambda(J,J),appl(lambda(B1,merge(drs([event(C1)],[]),appl(B1,C1))),appl(lambda(Z,lambda(A1,drs([],[not(appl(Z,A1))]))),appl(appl(lambda(S,S),appl(lambda(V,lambda(W,lambda(X,appl(W,lambda(Y,drs([],[appl(appl('s\'asseoir',Y),X),bool(appl(temps,X),overlaps,maintenant)])))))),lambda(T,appl(T,U)))),appl(lambda(K,lambda(L,appl(K,lambda(M,merge(appl(L,M),drs([],[appl(plus_de,M)])))))),appl(lambda(N,N),appl(lambda(O,lambda(P,merge(merge(drs([variable(Q)],[bool(num(Q),=,3)]),appl(O,Q)),appl(P,Q)))),lambda(R,drs([],[appl(chat,R)])))))))))).

% = Reduced Semantics

semantics(216, reduced, drs([event(A)],[not(drs([variable(B)],[bool(num(B),=,3),appl(chat,B),appl(appl('s\'asseoir',B),A),bool(appl(temps,A),overlaps,maintenant),appl(plus_de,B)]))])).


% = Semantics

semantics(217, unreduced, appl(lambda(A1,A1),appl(lambda(S3,merge(drs([event(T3)],[]),appl(S3,T3))),appl(appl(lambda(D3,lambda(E3,lambda(F3,merge(merge(drs([variable(G3)],[bool(F3,subseteq,G3)]),appl(D3,G3)),appl(E3,F3))))),appl(lambda(Q3,lambda(R3,merge(drs([],[appl(gris,R3)]),appl(Q3,R3)))),appl(appl(lambda(I3,lambda(J3,lambda(K3,merge(appl(J3,K3),appl(I3,lambda(L3,drs([],[appl(appl(de,L3),K3)]))))))),appl(lambda(M3,lambda(N3,presup(merge(drs([variable(O3)],[]),appl(M3,O3)),appl(N3,O3)))),lambda(P3,drs([],[appl(herbe,P3)])))),lambda(H3,drs([],[appl(long,H3)]))))),appl(appl(appl(lambda(F1,lambda(G1,lambda(H1,lambda(I1,appl(F1,lambda(J1,drs([event(I1)],[appl(appl(existe,J1),I1)]))))))),appl(appl(lambda(K2,lambda(L2,lambda(M2,merge(appl(L2,lambda(N2,appl(M2,N2))),appl(K2,lambda(O2,appl(M2,O2))))))),appl(lambda(P2,lambda(Q2,merge(merge(drs([variable(R2)],[]),appl(P2,R2)),appl(Q2,R2)))),appl(appl(lambda(V2,lambda(W2,lambda(X2,merge(appl(W2,X2),merge(drs([event(Y2)],[]),appl(appl(V2,lambda(Z2,appl(Z2,X2))),Y2)))))),lambda(A3,lambda(B3,appl(A3,lambda(C3,drs([],[appl(appl(courir,C3),B3),bool(appl(temps,B3),overlaps,maintenant)])))))),appl(lambda(T2,lambda(U2,merge(drs([],[appl(blanc,U2)]),appl(T2,U2)))),lambda(S2,drs([],[appl(chat,S2)])))))),appl(appl(lambda(Z1,lambda(A2,lambda(B2,merge(appl(A2,lambda(C2,appl(B2,C2))),appl(Z1,lambda(D2,appl(B2,D2))))))),appl(lambda(E2,lambda(F2,merge(merge(drs([variable(G2)],[]),appl(E2,G2)),appl(F2,G2)))),appl(lambda(I2,lambda(J2,merge(drs([],[appl(noir,J2)]),appl(I2,J2)))),lambda(H2,drs([],[appl(chat,H2)]))))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(P1,lambda(R1,appl(Q1,R1))),appl(O1,lambda(S1,appl(Q1,S1))))))),appl(lambda(T1,lambda(U1,merge(merge(drs([variable(V1)],[bool(num(V1),=,3)]),appl(T1,V1)),appl(U1,V1)))),appl(lambda(X1,lambda(Y1,merge(drs([],[appl(violet,Y1)]),appl(X1,Y1)))),lambda(W1,drs([],[appl(chat,W1)]))))),appl(lambda(K1,lambda(L1,merge(merge(drs([variable(M1)],[bool(num(M1),=,6)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(chat,N1)]))))))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,?)]),appl(D1,E1)))),lambda(B1,merge(drs([variable(C1)],[bool(C1,=,'masculin?')]),appl(B1,C1)))))))).

% = Reduced Semantics

semantics(217, reduced, presup(drs([variable(C)],[appl(herbe,C)]),drs([event(A),variable(B),variable(D),event(E),variable(F),variable(G),variable(H),event(I)],[bool(A,subseteq,B),appl(gris,B),appl(long,B),appl(appl(de,C),B),bool(num(D),=,6),appl(chat,D),appl(appl(existe,D),A),bool(num(F),=,3),appl(violet,F),appl(chat,F),appl(appl(existe,F),A),appl(noir,G),appl(chat,G),appl(appl(existe,G),A),appl(blanc,H),appl(chat,H),appl(appl(courir,H),I),bool(appl(temps,I),overlaps,maintenant),appl(appl(existe,H),A)]))).


% = Semantics

semantics(218, unreduced, appl(lambda(G,G),appl(lambda(S,merge(drs([event(T)],[]),appl(S,T))),appl(lambda(P,lambda(Q,appl(P,lambda(R,drs([],[appl(appl(courir,R),Q),bool(appl(temps,Q),overlaps,maintenant)]))))),appl(lambda(H,lambda(I,appl(H,lambda(J,merge(appl(I,J),drs([],[appl(moins_de,J)])))))),appl(lambda(K,K),appl(lambda(L,lambda(M,merge(merge(drs([variable(N)],[bool(num(N),=,6)]),appl(L,N)),appl(M,N)))),lambda(O,drs([],[appl(chat,O)]))))))))).

% = Reduced Semantics

semantics(218, reduced, drs([event(A),variable(B)],[bool(num(B),=,6),appl(chat,B),appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant),appl(moins_de,B)])).


% = Semantics

semantics(219, unreduced, appl(lambda(A1,A1),appl(lambda(S3,merge(drs([event(T3)],[]),appl(S3,T3))),appl(appl(lambda(D3,lambda(E3,lambda(F3,merge(merge(drs([variable(G3)],[bool(F3,subseteq,G3)]),appl(D3,G3)),appl(E3,F3))))),appl(lambda(Q3,lambda(R3,merge(drs([],[appl(gris,R3)]),appl(Q3,R3)))),appl(appl(lambda(I3,lambda(J3,lambda(K3,merge(appl(J3,K3),appl(I3,lambda(L3,drs([],[appl(appl(de,L3),K3)]))))))),appl(lambda(M3,lambda(N3,presup(merge(drs([variable(O3)],[]),appl(M3,O3)),appl(N3,O3)))),lambda(P3,drs([],[appl(herbe,P3)])))),lambda(H3,drs([],[appl(long,H3)]))))),appl(appl(appl(lambda(F1,lambda(G1,lambda(H1,lambda(I1,appl(F1,lambda(J1,drs([event(I1)],[appl(appl(existe,J1),I1)]))))))),appl(appl(lambda(K2,lambda(L2,lambda(M2,merge(appl(L2,lambda(N2,appl(M2,N2))),appl(K2,lambda(O2,appl(M2,O2))))))),appl(lambda(P2,lambda(Q2,merge(merge(drs([variable(R2)],[]),appl(P2,R2)),appl(Q2,R2)))),appl(appl(lambda(V2,lambda(W2,lambda(X2,merge(appl(W2,X2),merge(drs([event(Y2)],[]),appl(appl(V2,lambda(Z2,appl(Z2,X2))),Y2)))))),lambda(A3,lambda(B3,appl(A3,lambda(C3,drs([],[appl(appl(courir,C3),B3),bool(appl(temps,B3),overlaps,maintenant)])))))),appl(lambda(T2,lambda(U2,merge(drs([],[appl(blanc,U2)]),appl(T2,U2)))),lambda(S2,drs([],[appl(chat,S2)])))))),appl(appl(lambda(Z1,lambda(A2,lambda(B2,merge(appl(A2,lambda(C2,appl(B2,C2))),appl(Z1,lambda(D2,appl(B2,D2))))))),appl(lambda(E2,lambda(F2,merge(merge(drs([variable(G2)],[]),appl(E2,G2)),appl(F2,G2)))),appl(lambda(I2,lambda(J2,merge(drs([],[appl(noir,J2)]),appl(I2,J2)))),lambda(H2,drs([],[appl(chat,H2)]))))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(P1,lambda(R1,appl(Q1,R1))),appl(O1,lambda(S1,appl(Q1,S1))))))),appl(lambda(T1,lambda(U1,merge(merge(drs([variable(V1)],[bool(num(V1),=,3)]),appl(T1,V1)),appl(U1,V1)))),appl(lambda(X1,lambda(Y1,merge(drs([],[appl(violet,Y1)]),appl(X1,Y1)))),lambda(W1,drs([],[appl(chat,W1)]))))),appl(lambda(K1,lambda(L1,merge(merge(drs([variable(M1)],[bool(num(M1),=,6)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(chat,N1)]))))))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,?)]),appl(D1,E1)))),lambda(B1,merge(drs([variable(C1)],[bool(C1,=,'masculin?')]),appl(B1,C1)))))))).

% = Reduced Semantics

semantics(219, reduced, presup(drs([variable(C)],[appl(herbe,C)]),drs([event(A),variable(B),variable(D),event(E),variable(F),variable(G),variable(H),event(I)],[bool(A,subseteq,B),appl(gris,B),appl(long,B),appl(appl(de,C),B),bool(num(D),=,6),appl(chat,D),appl(appl(existe,D),A),bool(num(F),=,3),appl(violet,F),appl(chat,F),appl(appl(existe,F),A),appl(noir,G),appl(chat,G),appl(appl(existe,G),A),appl(blanc,H),appl(chat,H),appl(appl(courir,H),I),bool(appl(temps,I),overlaps,maintenant),appl(appl(existe,H),A)]))).


% = Semantics

semantics(220, unreduced, appl(lambda(F,F),appl(lambda(R,merge(drs([event(S)],[]),appl(R,S))),appl(appl(lambda(K,lambda(L,lambda(M,presup(drs([],[bool(appl(temps,M),overlaps,maintenant)]),appl(appl(K,L),M))))),lambda(N,lambda(O,appl(N,lambda(P,drs([variable(Q)],[bool(Q,=,'context?'),appl(appl(appl(asseoir,P),Q),O)])))))),appl(lambda(G,lambda(H,merge(merge(drs([variable(I)],[]),appl(G,I)),appl(H,I)))),lambda(J,drs([],[appl(chat,J)]))))))).

% = Reduced Semantics

semantics(220, reduced, presup(drs([],[bool(appl(temps,A),overlaps,maintenant)]),drs([event(A),variable(B),variable(C)],[appl(chat,B),bool(C,=,'context?'),appl(appl(appl(asseoir,B),C),A)]))).


% = Semantics

semantics(221, unreduced, appl(lambda(A1,A1),appl(lambda(S3,merge(drs([event(T3)],[]),appl(S3,T3))),appl(appl(lambda(D3,lambda(E3,lambda(F3,merge(merge(drs([variable(G3)],[bool(F3,subseteq,G3)]),appl(D3,G3)),appl(E3,F3))))),appl(lambda(Q3,lambda(R3,merge(drs([],[appl(gris,R3)]),appl(Q3,R3)))),appl(appl(lambda(I3,lambda(J3,lambda(K3,merge(appl(J3,K3),appl(I3,lambda(L3,drs([],[appl(appl(de,L3),K3)]))))))),appl(lambda(M3,lambda(N3,presup(merge(drs([variable(O3)],[]),appl(M3,O3)),appl(N3,O3)))),lambda(P3,drs([],[appl(herbe,P3)])))),lambda(H3,drs([],[appl(long,H3)]))))),appl(appl(appl(lambda(F1,lambda(G1,lambda(H1,lambda(I1,appl(F1,lambda(J1,drs([event(I1)],[appl(appl(existe,J1),I1)]))))))),appl(appl(lambda(K2,lambda(L2,lambda(M2,merge(appl(L2,lambda(N2,appl(M2,N2))),appl(K2,lambda(O2,appl(M2,O2))))))),appl(lambda(P2,lambda(Q2,merge(merge(drs([variable(R2)],[]),appl(P2,R2)),appl(Q2,R2)))),appl(appl(lambda(V2,lambda(W2,lambda(X2,merge(appl(W2,X2),merge(drs([event(Y2)],[]),appl(appl(V2,lambda(Z2,appl(Z2,X2))),Y2)))))),lambda(A3,lambda(B3,appl(A3,lambda(C3,drs([],[appl(appl(courir,C3),B3),bool(appl(temps,B3),overlaps,maintenant)])))))),appl(lambda(T2,lambda(U2,merge(drs([],[appl(blanc,U2)]),appl(T2,U2)))),lambda(S2,drs([],[appl(chat,S2)])))))),appl(appl(lambda(Z1,lambda(A2,lambda(B2,merge(appl(A2,lambda(C2,appl(B2,C2))),appl(Z1,lambda(D2,appl(B2,D2))))))),appl(lambda(E2,lambda(F2,merge(merge(drs([variable(G2)],[]),appl(E2,G2)),appl(F2,G2)))),appl(lambda(I2,lambda(J2,merge(drs([],[appl(noir,J2)]),appl(I2,J2)))),lambda(H2,drs([],[appl(chat,H2)]))))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(P1,lambda(R1,appl(Q1,R1))),appl(O1,lambda(S1,appl(Q1,S1))))))),appl(lambda(T1,lambda(U1,merge(merge(drs([variable(V1)],[bool(num(V1),=,3)]),appl(T1,V1)),appl(U1,V1)))),appl(lambda(X1,lambda(Y1,merge(drs([],[appl(violet,Y1)]),appl(X1,Y1)))),lambda(W1,drs([],[appl(chat,W1)]))))),appl(lambda(K1,lambda(L1,merge(merge(drs([variable(M1)],[bool(num(M1),=,6)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(chat,N1)]))))))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,?)]),appl(D1,E1)))),lambda(B1,merge(drs([variable(C1)],[bool(C1,=,'masculin?')]),appl(B1,C1)))))))).

% = Reduced Semantics

semantics(221, reduced, presup(drs([variable(C)],[appl(herbe,C)]),drs([event(A),variable(B),variable(D),event(E),variable(F),variable(G),variable(H),event(I)],[bool(A,subseteq,B),appl(gris,B),appl(long,B),appl(appl(de,C),B),bool(num(D),=,6),appl(chat,D),appl(appl(existe,D),A),bool(num(F),=,3),appl(violet,F),appl(chat,F),appl(appl(existe,F),A),appl(noir,G),appl(chat,G),appl(appl(existe,G),A),appl(blanc,H),appl(chat,H),appl(appl(courir,H),I),bool(appl(temps,I),overlaps,maintenant),appl(appl(existe,H),A)]))).


% = Semantics

semantics(222, unreduced, appl(lambda(E,E),appl(lambda(M,merge(drs([event(N)],[]),appl(M,N))),appl(lambda(J,lambda(K,appl(J,lambda(L,drs([],[appl(appl(courir,L),K),bool(appl(temps,K),overlaps,maintenant)]))))),appl(lambda(F,lambda(G,merge(merge(drs([variable(H)],[bool(num(H),=,3)]),appl(F,H)),appl(G,H)))),lambda(I,drs([],[appl(chat,I)]))))))).

% = Reduced Semantics

semantics(222, reduced, drs([event(A),variable(B)],[bool(num(B),=,3),appl(chat,B),appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant)])).


% = Semantics

semantics(223, unreduced, appl(lambda(A1,A1),appl(lambda(S3,merge(drs([event(T3)],[]),appl(S3,T3))),appl(appl(lambda(D3,lambda(E3,lambda(F3,merge(merge(drs([variable(G3)],[bool(F3,subseteq,G3)]),appl(D3,G3)),appl(E3,F3))))),appl(lambda(Q3,lambda(R3,merge(drs([],[appl(gris,R3)]),appl(Q3,R3)))),appl(appl(lambda(I3,lambda(J3,lambda(K3,merge(appl(J3,K3),appl(I3,lambda(L3,drs([],[appl(appl(de,L3),K3)]))))))),appl(lambda(M3,lambda(N3,presup(merge(drs([variable(O3)],[]),appl(M3,O3)),appl(N3,O3)))),lambda(P3,drs([],[appl(herbe,P3)])))),lambda(H3,drs([],[appl(long,H3)]))))),appl(appl(appl(lambda(F1,lambda(G1,lambda(H1,lambda(I1,appl(F1,lambda(J1,drs([event(I1)],[appl(appl(existe,J1),I1)]))))))),appl(appl(lambda(K2,lambda(L2,lambda(M2,merge(appl(L2,lambda(N2,appl(M2,N2))),appl(K2,lambda(O2,appl(M2,O2))))))),appl(lambda(P2,lambda(Q2,merge(merge(drs([variable(R2)],[]),appl(P2,R2)),appl(Q2,R2)))),appl(appl(lambda(V2,lambda(W2,lambda(X2,merge(appl(W2,X2),merge(drs([event(Y2)],[]),appl(appl(V2,lambda(Z2,appl(Z2,X2))),Y2)))))),lambda(A3,lambda(B3,appl(A3,lambda(C3,drs([],[appl(appl(courir,C3),B3),bool(appl(temps,B3),overlaps,maintenant)])))))),appl(lambda(T2,lambda(U2,merge(drs([],[appl(blanc,U2)]),appl(T2,U2)))),lambda(S2,drs([],[appl(chat,S2)])))))),appl(appl(lambda(Z1,lambda(A2,lambda(B2,merge(appl(A2,lambda(C2,appl(B2,C2))),appl(Z1,lambda(D2,appl(B2,D2))))))),appl(lambda(E2,lambda(F2,merge(merge(drs([variable(G2)],[]),appl(E2,G2)),appl(F2,G2)))),appl(lambda(I2,lambda(J2,merge(drs([],[appl(noir,J2)]),appl(I2,J2)))),lambda(H2,drs([],[appl(chat,H2)]))))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(P1,lambda(R1,appl(Q1,R1))),appl(O1,lambda(S1,appl(Q1,S1))))))),appl(lambda(T1,lambda(U1,merge(merge(drs([variable(V1)],[bool(num(V1),=,3)]),appl(T1,V1)),appl(U1,V1)))),appl(lambda(X1,lambda(Y1,merge(drs([],[appl(violet,Y1)]),appl(X1,Y1)))),lambda(W1,drs([],[appl(chat,W1)]))))),appl(lambda(K1,lambda(L1,merge(merge(drs([variable(M1)],[bool(num(M1),=,6)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(chat,N1)]))))))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,?)]),appl(D1,E1)))),lambda(B1,merge(drs([variable(C1)],[bool(C1,=,'masculin?')]),appl(B1,C1)))))))).

% = Reduced Semantics

semantics(223, reduced, presup(drs([variable(C)],[appl(herbe,C)]),drs([event(A),variable(B),variable(D),event(E),variable(F),variable(G),variable(H),event(I)],[bool(A,subseteq,B),appl(gris,B),appl(long,B),appl(appl(de,C),B),bool(num(D),=,6),appl(chat,D),appl(appl(existe,D),A),bool(num(F),=,3),appl(violet,F),appl(chat,F),appl(appl(existe,F),A),appl(noir,G),appl(chat,G),appl(appl(existe,G),A),appl(blanc,H),appl(chat,H),appl(appl(courir,H),I),bool(appl(temps,I),overlaps,maintenant),appl(appl(existe,H),A)]))).


% = Semantics

semantics(224, unreduced, appl(lambda(H,H),appl(lambda(Z,merge(drs([event(A1)],[]),appl(Z,A1))),appl(lambda(W,lambda(X,appl(W,lambda(Y,drs([],[appl(appl(courir,Y),X),bool(appl(temps,X),overlaps,maintenant)]))))),appl(lambda(I,lambda(J,appl(I,lambda(K,merge(appl(J,K),drs([],[appl(entre,K)])))))),appl(appl(appl(lambda(O,lambda(P,lambda(Q,lambda(R,merge(appl(appl(O,Q),R),appl(appl(P,Q),R)))))),lambda(S,lambda(T,merge(merge(drs([variable(U)],[bool(num(U),=,7)]),appl(S,U)),appl(T,U))))),lambda(L,lambda(M,merge(merge(drs([variable(N)],[bool(num(N),=,6)]),appl(L,N)),appl(M,N))))),lambda(V,drs([],[appl(chat,V)])))))))).

% = Reduced Semantics

semantics(224, reduced, drs([event(A),variable(B),variable(C)],[bool(num(B),=,7),appl(chat,B),appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant),appl(entre,B),bool(num(C),=,6),appl(chat,C),appl(appl(courir,C),A),appl(entre,C)])).


% = Semantics

semantics(225, unreduced, appl(lambda(A1,A1),appl(lambda(S3,merge(drs([event(T3)],[]),appl(S3,T3))),appl(appl(lambda(D3,lambda(E3,lambda(F3,merge(merge(drs([variable(G3)],[bool(F3,subseteq,G3)]),appl(D3,G3)),appl(E3,F3))))),appl(lambda(Q3,lambda(R3,merge(drs([],[appl(gris,R3)]),appl(Q3,R3)))),appl(appl(lambda(I3,lambda(J3,lambda(K3,merge(appl(J3,K3),appl(I3,lambda(L3,drs([],[appl(appl(de,L3),K3)]))))))),appl(lambda(M3,lambda(N3,presup(merge(drs([variable(O3)],[]),appl(M3,O3)),appl(N3,O3)))),lambda(P3,drs([],[appl(herbe,P3)])))),lambda(H3,drs([],[appl(long,H3)]))))),appl(appl(appl(lambda(F1,lambda(G1,lambda(H1,lambda(I1,appl(F1,lambda(J1,drs([event(I1)],[appl(appl(existe,J1),I1)]))))))),appl(appl(lambda(K2,lambda(L2,lambda(M2,merge(appl(L2,lambda(N2,appl(M2,N2))),appl(K2,lambda(O2,appl(M2,O2))))))),appl(lambda(P2,lambda(Q2,merge(merge(drs([variable(R2)],[]),appl(P2,R2)),appl(Q2,R2)))),appl(appl(lambda(V2,lambda(W2,lambda(X2,merge(appl(W2,X2),merge(drs([event(Y2)],[]),appl(appl(V2,lambda(Z2,appl(Z2,X2))),Y2)))))),lambda(A3,lambda(B3,appl(A3,lambda(C3,drs([],[appl(appl(courir,C3),B3),bool(appl(temps,B3),overlaps,maintenant)])))))),appl(lambda(T2,lambda(U2,merge(drs([],[appl(blanc,U2)]),appl(T2,U2)))),lambda(S2,drs([],[appl(chat,S2)])))))),appl(appl(lambda(Z1,lambda(A2,lambda(B2,merge(appl(A2,lambda(C2,appl(B2,C2))),appl(Z1,lambda(D2,appl(B2,D2))))))),appl(lambda(E2,lambda(F2,merge(merge(drs([variable(G2)],[]),appl(E2,G2)),appl(F2,G2)))),appl(lambda(I2,lambda(J2,merge(drs([],[appl(noir,J2)]),appl(I2,J2)))),lambda(H2,drs([],[appl(chat,H2)]))))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(P1,lambda(R1,appl(Q1,R1))),appl(O1,lambda(S1,appl(Q1,S1))))))),appl(lambda(T1,lambda(U1,merge(merge(drs([variable(V1)],[bool(num(V1),=,3)]),appl(T1,V1)),appl(U1,V1)))),appl(lambda(X1,lambda(Y1,merge(drs([],[appl(violet,Y1)]),appl(X1,Y1)))),lambda(W1,drs([],[appl(chat,W1)]))))),appl(lambda(K1,lambda(L1,merge(merge(drs([variable(M1)],[bool(num(M1),=,6)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(chat,N1)]))))))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,?)]),appl(D1,E1)))),lambda(B1,merge(drs([variable(C1)],[bool(C1,=,'masculin?')]),appl(B1,C1)))))))).

% = Reduced Semantics

semantics(225, reduced, presup(drs([variable(C)],[appl(herbe,C)]),drs([event(A),variable(B),variable(D),event(E),variable(F),variable(G),variable(H),event(I)],[bool(A,subseteq,B),appl(gris,B),appl(long,B),appl(appl(de,C),B),bool(num(D),=,6),appl(chat,D),appl(appl(existe,D),A),bool(num(F),=,3),appl(violet,F),appl(chat,F),appl(appl(existe,F),A),appl(noir,G),appl(chat,G),appl(appl(existe,G),A),appl(blanc,H),appl(chat,H),appl(appl(courir,H),I),bool(appl(temps,I),overlaps,maintenant),appl(appl(existe,H),A)]))).


% = Semantics

semantics(227, unreduced, appl(lambda(A1,A1),appl(lambda(S3,merge(drs([event(T3)],[]),appl(S3,T3))),appl(appl(lambda(D3,lambda(E3,lambda(F3,merge(merge(drs([variable(G3)],[bool(F3,subseteq,G3)]),appl(D3,G3)),appl(E3,F3))))),appl(lambda(Q3,lambda(R3,merge(drs([],[appl(gris,R3)]),appl(Q3,R3)))),appl(appl(lambda(I3,lambda(J3,lambda(K3,merge(appl(J3,K3),appl(I3,lambda(L3,drs([],[appl(appl(de,L3),K3)]))))))),appl(lambda(M3,lambda(N3,presup(merge(drs([variable(O3)],[]),appl(M3,O3)),appl(N3,O3)))),lambda(P3,drs([],[appl(herbe,P3)])))),lambda(H3,drs([],[appl(long,H3)]))))),appl(appl(appl(lambda(F1,lambda(G1,lambda(H1,lambda(I1,appl(F1,lambda(J1,drs([event(I1)],[appl(appl(existe,J1),I1)]))))))),appl(appl(lambda(K2,lambda(L2,lambda(M2,merge(appl(L2,lambda(N2,appl(M2,N2))),appl(K2,lambda(O2,appl(M2,O2))))))),appl(lambda(P2,lambda(Q2,merge(merge(drs([variable(R2)],[]),appl(P2,R2)),appl(Q2,R2)))),appl(appl(lambda(V2,lambda(W2,lambda(X2,merge(appl(W2,X2),merge(drs([event(Y2)],[]),appl(appl(V2,lambda(Z2,appl(Z2,X2))),Y2)))))),lambda(A3,lambda(B3,appl(A3,lambda(C3,drs([],[appl(appl(courir,C3),B3),bool(appl(temps,B3),overlaps,maintenant)])))))),appl(lambda(T2,lambda(U2,merge(drs([],[appl(blanc,U2)]),appl(T2,U2)))),lambda(S2,drs([],[appl(chat,S2)])))))),appl(appl(lambda(Z1,lambda(A2,lambda(B2,merge(appl(A2,lambda(C2,appl(B2,C2))),appl(Z1,lambda(D2,appl(B2,D2))))))),appl(lambda(E2,lambda(F2,merge(merge(drs([variable(G2)],[]),appl(E2,G2)),appl(F2,G2)))),appl(lambda(I2,lambda(J2,merge(drs([],[appl(noir,J2)]),appl(I2,J2)))),lambda(H2,drs([],[appl(chat,H2)]))))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(P1,lambda(R1,appl(Q1,R1))),appl(O1,lambda(S1,appl(Q1,S1))))))),appl(lambda(T1,lambda(U1,merge(merge(drs([variable(V1)],[bool(num(V1),=,3)]),appl(T1,V1)),appl(U1,V1)))),appl(lambda(X1,lambda(Y1,merge(drs([],[appl(violet,Y1)]),appl(X1,Y1)))),lambda(W1,drs([],[appl(chat,W1)]))))),appl(lambda(K1,lambda(L1,merge(merge(drs([variable(M1)],[bool(num(M1),=,6)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(chat,N1)]))))))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,?)]),appl(D1,E1)))),lambda(B1,merge(drs([variable(C1)],[bool(C1,=,'masculin?')]),appl(B1,C1)))))))).

% = Reduced Semantics

semantics(227, reduced, presup(drs([variable(C)],[appl(herbe,C)]),drs([event(A),variable(B),variable(D),event(E),variable(F),variable(G),variable(H),event(I)],[bool(A,subseteq,B),appl(gris,B),appl(long,B),appl(appl(de,C),B),bool(num(D),=,6),appl(chat,D),appl(appl(existe,D),A),bool(num(F),=,3),appl(violet,F),appl(chat,F),appl(appl(existe,F),A),appl(noir,G),appl(chat,G),appl(appl(existe,G),A),appl(blanc,H),appl(chat,H),appl(appl(courir,H),I),bool(appl(temps,I),overlaps,maintenant),appl(appl(existe,H),A)]))).


% = Semantics

semantics(229, unreduced, appl(lambda(A1,A1),appl(lambda(S3,merge(drs([event(T3)],[]),appl(S3,T3))),appl(appl(lambda(D3,lambda(E3,lambda(F3,merge(merge(drs([variable(G3)],[bool(F3,subseteq,G3)]),appl(D3,G3)),appl(E3,F3))))),appl(lambda(Q3,lambda(R3,merge(drs([],[appl(gris,R3)]),appl(Q3,R3)))),appl(appl(lambda(I3,lambda(J3,lambda(K3,merge(appl(J3,K3),appl(I3,lambda(L3,drs([],[appl(appl(de,L3),K3)]))))))),appl(lambda(M3,lambda(N3,presup(merge(drs([variable(O3)],[]),appl(M3,O3)),appl(N3,O3)))),lambda(P3,drs([],[appl(herbe,P3)])))),lambda(H3,drs([],[appl(long,H3)]))))),appl(appl(appl(lambda(F1,lambda(G1,lambda(H1,lambda(I1,appl(F1,lambda(J1,drs([event(I1)],[appl(appl(existe,J1),I1)]))))))),appl(appl(lambda(K2,lambda(L2,lambda(M2,merge(appl(L2,lambda(N2,appl(M2,N2))),appl(K2,lambda(O2,appl(M2,O2))))))),appl(lambda(P2,lambda(Q2,merge(merge(drs([variable(R2)],[]),appl(P2,R2)),appl(Q2,R2)))),appl(appl(lambda(V2,lambda(W2,lambda(X2,merge(appl(W2,X2),merge(drs([event(Y2)],[]),appl(appl(V2,lambda(Z2,appl(Z2,X2))),Y2)))))),lambda(A3,lambda(B3,appl(A3,lambda(C3,drs([],[appl(appl(courir,C3),B3),bool(appl(temps,B3),overlaps,maintenant)])))))),appl(lambda(T2,lambda(U2,merge(drs([],[appl(blanc,U2)]),appl(T2,U2)))),lambda(S2,drs([],[appl(chat,S2)])))))),appl(appl(lambda(Z1,lambda(A2,lambda(B2,merge(appl(A2,lambda(C2,appl(B2,C2))),appl(Z1,lambda(D2,appl(B2,D2))))))),appl(lambda(E2,lambda(F2,merge(merge(drs([variable(G2)],[]),appl(E2,G2)),appl(F2,G2)))),appl(lambda(I2,lambda(J2,merge(drs([],[appl(noir,J2)]),appl(I2,J2)))),lambda(H2,drs([],[appl(chat,H2)]))))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(P1,lambda(R1,appl(Q1,R1))),appl(O1,lambda(S1,appl(Q1,S1))))))),appl(lambda(T1,lambda(U1,merge(merge(drs([variable(V1)],[bool(num(V1),=,3)]),appl(T1,V1)),appl(U1,V1)))),appl(lambda(X1,lambda(Y1,merge(drs([],[appl(violet,Y1)]),appl(X1,Y1)))),lambda(W1,drs([],[appl(chat,W1)]))))),appl(lambda(K1,lambda(L1,merge(merge(drs([variable(M1)],[bool(num(M1),=,6)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(chat,N1)]))))))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,?)]),appl(D1,E1)))),lambda(B1,merge(drs([variable(C1)],[bool(C1,=,'masculin?')]),appl(B1,C1)))))))).

% = Reduced Semantics

semantics(229, reduced, presup(drs([variable(C)],[appl(herbe,C)]),drs([event(A),variable(B),variable(D),event(E),variable(F),variable(G),variable(H),event(I)],[bool(A,subseteq,B),appl(gris,B),appl(long,B),appl(appl(de,C),B),bool(num(D),=,6),appl(chat,D),appl(appl(existe,D),A),bool(num(F),=,3),appl(violet,F),appl(chat,F),appl(appl(existe,F),A),appl(noir,G),appl(chat,G),appl(appl(existe,G),A),appl(blanc,H),appl(chat,H),appl(appl(courir,H),I),bool(appl(temps,I),overlaps,maintenant),appl(appl(existe,H),A)]))).


% = Semantics

semantics(230, unreduced, appl(lambda(F,F),appl(lambda(O,appl(O,lambda(P,drs([],[])))),appl(lambda(G,lambda(H,merge(merge(drs([variable(I)],[]),appl(G,I)),appl(H,I)))),appl(lambda(M,lambda(N,merge(drs([],[appl(court,N)]),appl(M,N)))),appl(lambda(K,lambda(L,merge(drs([],[appl(orange,L)]),appl(K,L)))),lambda(J,drs([],[appl(chat,J)])))))))).

% = Reduced Semantics

semantics(230, reduced, drs([variable(A)],[appl(court,A),appl(orange,A),appl(chat,A)])).


% = Semantics

semantics(231, unreduced, appl(lambda(A1,A1),appl(lambda(S3,merge(drs([event(T3)],[]),appl(S3,T3))),appl(appl(lambda(D3,lambda(E3,lambda(F3,merge(merge(drs([variable(G3)],[bool(F3,subseteq,G3)]),appl(D3,G3)),appl(E3,F3))))),appl(lambda(Q3,lambda(R3,merge(drs([],[appl(gris,R3)]),appl(Q3,R3)))),appl(appl(lambda(I3,lambda(J3,lambda(K3,merge(appl(J3,K3),appl(I3,lambda(L3,drs([],[appl(appl(de,L3),K3)]))))))),appl(lambda(M3,lambda(N3,presup(merge(drs([variable(O3)],[]),appl(M3,O3)),appl(N3,O3)))),lambda(P3,drs([],[appl(herbe,P3)])))),lambda(H3,drs([],[appl(long,H3)]))))),appl(appl(appl(lambda(F1,lambda(G1,lambda(H1,lambda(I1,appl(F1,lambda(J1,drs([event(I1)],[appl(appl(existe,J1),I1)]))))))),appl(appl(lambda(K2,lambda(L2,lambda(M2,merge(appl(L2,lambda(N2,appl(M2,N2))),appl(K2,lambda(O2,appl(M2,O2))))))),appl(lambda(P2,lambda(Q2,merge(merge(drs([variable(R2)],[]),appl(P2,R2)),appl(Q2,R2)))),appl(appl(lambda(V2,lambda(W2,lambda(X2,merge(appl(W2,X2),merge(drs([event(Y2)],[]),appl(appl(V2,lambda(Z2,appl(Z2,X2))),Y2)))))),lambda(A3,lambda(B3,appl(A3,lambda(C3,drs([],[appl(appl(courir,C3),B3),bool(appl(temps,B3),overlaps,maintenant)])))))),appl(lambda(T2,lambda(U2,merge(drs([],[appl(blanc,U2)]),appl(T2,U2)))),lambda(S2,drs([],[appl(chat,S2)])))))),appl(appl(lambda(Z1,lambda(A2,lambda(B2,merge(appl(A2,lambda(C2,appl(B2,C2))),appl(Z1,lambda(D2,appl(B2,D2))))))),appl(lambda(E2,lambda(F2,merge(merge(drs([variable(G2)],[]),appl(E2,G2)),appl(F2,G2)))),appl(lambda(I2,lambda(J2,merge(drs([],[appl(noir,J2)]),appl(I2,J2)))),lambda(H2,drs([],[appl(chat,H2)]))))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(P1,lambda(R1,appl(Q1,R1))),appl(O1,lambda(S1,appl(Q1,S1))))))),appl(lambda(T1,lambda(U1,merge(merge(drs([variable(V1)],[bool(num(V1),=,3)]),appl(T1,V1)),appl(U1,V1)))),appl(lambda(X1,lambda(Y1,merge(drs([],[appl(violet,Y1)]),appl(X1,Y1)))),lambda(W1,drs([],[appl(chat,W1)]))))),appl(lambda(K1,lambda(L1,merge(merge(drs([variable(M1)],[bool(num(M1),=,6)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(chat,N1)]))))))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,?)]),appl(D1,E1)))),lambda(B1,merge(drs([variable(C1)],[bool(C1,=,'masculin?')]),appl(B1,C1)))))))).

% = Reduced Semantics

semantics(231, reduced, presup(drs([variable(C)],[appl(herbe,C)]),drs([event(A),variable(B),variable(D),event(E),variable(F),variable(G),variable(H),event(I)],[bool(A,subseteq,B),appl(gris,B),appl(long,B),appl(appl(de,C),B),bool(num(D),=,6),appl(chat,D),appl(appl(existe,D),A),bool(num(F),=,3),appl(violet,F),appl(chat,F),appl(appl(existe,F),A),appl(noir,G),appl(chat,G),appl(appl(existe,G),A),appl(blanc,H),appl(chat,H),appl(appl(courir,H),I),bool(appl(temps,I),overlaps,maintenant),appl(appl(existe,H),A)]))).


% = Semantics

semantics(232, unreduced, appl(lambda(G,G),appl(lambda(T,merge(drs([event(U)],[]),appl(T,U))),appl(lambda(Q,lambda(R,appl(Q,lambda(S,drs([],[appl(appl(courir,S),R),bool(appl(temps,R),overlaps,maintenant)]))))),appl(lambda(H,lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,60)]),appl(H,J)),appl(I,J)))),appl(appl(lambda(L,lambda(M,lambda(N,presup(merge(drs([variable(O)],[bool(num(O),>,1)]),appl(L,O)),merge(appl(M,N),drs([],[appl(appl(de,O),N)])))))),lambda(P,drs([],[appl(chat,P)]))),lambda(K,drs([],[appl('%',K)])))))))).

% = Reduced Semantics

semantics(232, reduced, presup(drs([variable(C)],[bool(num(C),>,1),appl(chat,C)]),drs([event(A),variable(B)],[bool(num(B),=,60),appl('%',B),appl(appl(de,C),B),appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant)]))).


% = Semantics

semantics(233, unreduced, appl(lambda(A1,A1),appl(lambda(S3,merge(drs([event(T3)],[]),appl(S3,T3))),appl(appl(lambda(D3,lambda(E3,lambda(F3,merge(merge(drs([variable(G3)],[bool(F3,subseteq,G3)]),appl(D3,G3)),appl(E3,F3))))),appl(lambda(Q3,lambda(R3,merge(drs([],[appl(gris,R3)]),appl(Q3,R3)))),appl(appl(lambda(I3,lambda(J3,lambda(K3,merge(appl(J3,K3),appl(I3,lambda(L3,drs([],[appl(appl(de,L3),K3)]))))))),appl(lambda(M3,lambda(N3,presup(merge(drs([variable(O3)],[]),appl(M3,O3)),appl(N3,O3)))),lambda(P3,drs([],[appl(herbe,P3)])))),lambda(H3,drs([],[appl(long,H3)]))))),appl(appl(appl(lambda(F1,lambda(G1,lambda(H1,lambda(I1,appl(F1,lambda(J1,drs([event(I1)],[appl(appl(existe,J1),I1)]))))))),appl(appl(lambda(K2,lambda(L2,lambda(M2,merge(appl(L2,lambda(N2,appl(M2,N2))),appl(K2,lambda(O2,appl(M2,O2))))))),appl(lambda(P2,lambda(Q2,merge(merge(drs([variable(R2)],[]),appl(P2,R2)),appl(Q2,R2)))),appl(appl(lambda(V2,lambda(W2,lambda(X2,merge(appl(W2,X2),merge(drs([event(Y2)],[]),appl(appl(V2,lambda(Z2,appl(Z2,X2))),Y2)))))),lambda(A3,lambda(B3,appl(A3,lambda(C3,drs([],[appl(appl(courir,C3),B3),bool(appl(temps,B3),overlaps,maintenant)])))))),appl(lambda(T2,lambda(U2,merge(drs([],[appl(blanc,U2)]),appl(T2,U2)))),lambda(S2,drs([],[appl(chat,S2)])))))),appl(appl(lambda(Z1,lambda(A2,lambda(B2,merge(appl(A2,lambda(C2,appl(B2,C2))),appl(Z1,lambda(D2,appl(B2,D2))))))),appl(lambda(E2,lambda(F2,merge(merge(drs([variable(G2)],[]),appl(E2,G2)),appl(F2,G2)))),appl(lambda(I2,lambda(J2,merge(drs([],[appl(noir,J2)]),appl(I2,J2)))),lambda(H2,drs([],[appl(chat,H2)]))))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(P1,lambda(R1,appl(Q1,R1))),appl(O1,lambda(S1,appl(Q1,S1))))))),appl(lambda(T1,lambda(U1,merge(merge(drs([variable(V1)],[bool(num(V1),=,3)]),appl(T1,V1)),appl(U1,V1)))),appl(lambda(X1,lambda(Y1,merge(drs([],[appl(violet,Y1)]),appl(X1,Y1)))),lambda(W1,drs([],[appl(chat,W1)]))))),appl(lambda(K1,lambda(L1,merge(merge(drs([variable(M1)],[bool(num(M1),=,6)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(chat,N1)]))))))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,?)]),appl(D1,E1)))),lambda(B1,merge(drs([variable(C1)],[bool(C1,=,'masculin?')]),appl(B1,C1)))))))).

% = Reduced Semantics

semantics(233, reduced, presup(drs([variable(C)],[appl(herbe,C)]),drs([event(A),variable(B),variable(D),event(E),variable(F),variable(G),variable(H),event(I)],[bool(A,subseteq,B),appl(gris,B),appl(long,B),appl(appl(de,C),B),bool(num(D),=,6),appl(chat,D),appl(appl(existe,D),A),bool(num(F),=,3),appl(violet,F),appl(chat,F),appl(appl(existe,F),A),appl(noir,G),appl(chat,G),appl(appl(existe,G),A),appl(blanc,H),appl(chat,H),appl(appl(courir,H),I),bool(appl(temps,I),overlaps,maintenant),appl(appl(existe,H),A)]))).


% = Semantics

semantics(234, unreduced, appl(lambda(H,H),appl(lambda(Y,merge(drs([event(Z)],[]),appl(Y,Z))),appl(appl(lambda(R,lambda(S,lambda(T,presup(drs([],[bool(appl(temps,T),overlaps,maintenant)]),appl(appl(R,S),T))))),lambda(U,lambda(V,appl(U,lambda(W,drs([variable(X)],[bool(X,=,'context?'),appl(appl(appl(asseoir,W),X),V)])))))),appl(lambda(I,lambda(J,merge(merge(drs([variable(K)],[bool(num(K),=,40)]),appl(I,K)),appl(J,K)))),appl(appl(lambda(M,lambda(N,lambda(O,presup(merge(drs([variable(P)],[bool(num(P),>,1)]),appl(M,P)),merge(appl(N,O),drs([],[appl(appl(de,P),O)])))))),lambda(Q,drs([],[appl(chat,Q)]))),lambda(L,drs([],[appl('%',L)])))))))).

% = Reduced Semantics

semantics(234, reduced, presup(drs([variable(C)],[bool(appl(temps,A),overlaps,maintenant),bool(num(C),>,1),appl(chat,C)]),drs([event(A),variable(B),variable(D)],[bool(num(B),=,40),appl('%',B),appl(appl(de,C),B),bool(D,=,'context?'),appl(appl(appl(asseoir,B),D),A)]))).


% = Semantics

semantics(235, unreduced, appl(lambda(A1,A1),appl(lambda(S3,merge(drs([event(T3)],[]),appl(S3,T3))),appl(appl(lambda(D3,lambda(E3,lambda(F3,merge(merge(drs([variable(G3)],[bool(F3,subseteq,G3)]),appl(D3,G3)),appl(E3,F3))))),appl(lambda(Q3,lambda(R3,merge(drs([],[appl(gris,R3)]),appl(Q3,R3)))),appl(appl(lambda(I3,lambda(J3,lambda(K3,merge(appl(J3,K3),appl(I3,lambda(L3,drs([],[appl(appl(de,L3),K3)]))))))),appl(lambda(M3,lambda(N3,presup(merge(drs([variable(O3)],[]),appl(M3,O3)),appl(N3,O3)))),lambda(P3,drs([],[appl(herbe,P3)])))),lambda(H3,drs([],[appl(long,H3)]))))),appl(appl(appl(lambda(F1,lambda(G1,lambda(H1,lambda(I1,appl(F1,lambda(J1,drs([event(I1)],[appl(appl(existe,J1),I1)]))))))),appl(appl(lambda(K2,lambda(L2,lambda(M2,merge(appl(L2,lambda(N2,appl(M2,N2))),appl(K2,lambda(O2,appl(M2,O2))))))),appl(lambda(P2,lambda(Q2,merge(merge(drs([variable(R2)],[]),appl(P2,R2)),appl(Q2,R2)))),appl(appl(lambda(V2,lambda(W2,lambda(X2,merge(appl(W2,X2),merge(drs([event(Y2)],[]),appl(appl(V2,lambda(Z2,appl(Z2,X2))),Y2)))))),lambda(A3,lambda(B3,appl(A3,lambda(C3,drs([],[appl(appl(courir,C3),B3),bool(appl(temps,B3),overlaps,maintenant)])))))),appl(lambda(T2,lambda(U2,merge(drs([],[appl(blanc,U2)]),appl(T2,U2)))),lambda(S2,drs([],[appl(chat,S2)])))))),appl(appl(lambda(Z1,lambda(A2,lambda(B2,merge(appl(A2,lambda(C2,appl(B2,C2))),appl(Z1,lambda(D2,appl(B2,D2))))))),appl(lambda(E2,lambda(F2,merge(merge(drs([variable(G2)],[]),appl(E2,G2)),appl(F2,G2)))),appl(lambda(I2,lambda(J2,merge(drs([],[appl(noir,J2)]),appl(I2,J2)))),lambda(H2,drs([],[appl(chat,H2)]))))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(P1,lambda(R1,appl(Q1,R1))),appl(O1,lambda(S1,appl(Q1,S1))))))),appl(lambda(T1,lambda(U1,merge(merge(drs([variable(V1)],[bool(num(V1),=,3)]),appl(T1,V1)),appl(U1,V1)))),appl(lambda(X1,lambda(Y1,merge(drs([],[appl(violet,Y1)]),appl(X1,Y1)))),lambda(W1,drs([],[appl(chat,W1)]))))),appl(lambda(K1,lambda(L1,merge(merge(drs([variable(M1)],[bool(num(M1),=,6)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(chat,N1)]))))))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,?)]),appl(D1,E1)))),lambda(B1,merge(drs([variable(C1)],[bool(C1,=,'masculin?')]),appl(B1,C1)))))))).

% = Reduced Semantics

semantics(235, reduced, presup(drs([variable(C)],[appl(herbe,C)]),drs([event(A),variable(B),variable(D),event(E),variable(F),variable(G),variable(H),event(I)],[bool(A,subseteq,B),appl(gris,B),appl(long,B),appl(appl(de,C),B),bool(num(D),=,6),appl(chat,D),appl(appl(existe,D),A),bool(num(F),=,3),appl(violet,F),appl(chat,F),appl(appl(existe,F),A),appl(noir,G),appl(chat,G),appl(appl(existe,G),A),appl(blanc,H),appl(chat,H),appl(appl(courir,H),I),bool(appl(temps,I),overlaps,maintenant),appl(appl(existe,H),A)]))).


% = Semantics

semantics(236, unreduced, appl(lambda(I,I),appl(lambda(Z,merge(drs([event(A1)],[]),appl(Z,A1))),appl(lambda(W,lambda(X,appl(W,lambda(Y,drs([],[appl(appl(courir,Y),X),bool(appl(temps,X),overlaps,maintenant)]))))),appl(lambda(J,lambda(K,appl(J,lambda(L,merge(appl(K,L),drs([],[appl(plus_de,L)])))))),appl(lambda(M,M),appl(lambda(N,lambda(O,merge(merge(drs([variable(P)],[bool(num(P),=,40)]),appl(N,P)),appl(O,P)))),appl(appl(lambda(R,lambda(S,lambda(T,presup(merge(drs([variable(U)],[bool(num(U),>,1)]),appl(R,U)),merge(appl(S,T),drs([],[appl(appl(de,U),T)])))))),lambda(V,drs([],[appl(chat,V)]))),lambda(Q,drs([],[appl('%',Q)])))))))))).

% = Reduced Semantics

semantics(236, reduced, presup(drs([variable(C)],[bool(num(C),>,1),appl(chat,C)]),drs([event(A),variable(B)],[bool(num(B),=,40),appl('%',B),appl(appl(de,C),B),appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant),appl(plus_de,B)]))).


% = Semantics

semantics(237, unreduced, appl(lambda(A1,A1),appl(lambda(S3,merge(drs([event(T3)],[]),appl(S3,T3))),appl(appl(lambda(D3,lambda(E3,lambda(F3,merge(merge(drs([variable(G3)],[bool(F3,subseteq,G3)]),appl(D3,G3)),appl(E3,F3))))),appl(lambda(Q3,lambda(R3,merge(drs([],[appl(gris,R3)]),appl(Q3,R3)))),appl(appl(lambda(I3,lambda(J3,lambda(K3,merge(appl(J3,K3),appl(I3,lambda(L3,drs([],[appl(appl(de,L3),K3)]))))))),appl(lambda(M3,lambda(N3,presup(merge(drs([variable(O3)],[]),appl(M3,O3)),appl(N3,O3)))),lambda(P3,drs([],[appl(herbe,P3)])))),lambda(H3,drs([],[appl(long,H3)]))))),appl(appl(appl(lambda(F1,lambda(G1,lambda(H1,lambda(I1,appl(F1,lambda(J1,drs([event(I1)],[appl(appl(existe,J1),I1)]))))))),appl(appl(lambda(K2,lambda(L2,lambda(M2,merge(appl(L2,lambda(N2,appl(M2,N2))),appl(K2,lambda(O2,appl(M2,O2))))))),appl(lambda(P2,lambda(Q2,merge(merge(drs([variable(R2)],[]),appl(P2,R2)),appl(Q2,R2)))),appl(appl(lambda(V2,lambda(W2,lambda(X2,merge(appl(W2,X2),merge(drs([event(Y2)],[]),appl(appl(V2,lambda(Z2,appl(Z2,X2))),Y2)))))),lambda(A3,lambda(B3,appl(A3,lambda(C3,drs([],[appl(appl(courir,C3),B3),bool(appl(temps,B3),overlaps,maintenant)])))))),appl(lambda(T2,lambda(U2,merge(drs([],[appl(blanc,U2)]),appl(T2,U2)))),lambda(S2,drs([],[appl(chat,S2)])))))),appl(appl(lambda(Z1,lambda(A2,lambda(B2,merge(appl(A2,lambda(C2,appl(B2,C2))),appl(Z1,lambda(D2,appl(B2,D2))))))),appl(lambda(E2,lambda(F2,merge(merge(drs([variable(G2)],[]),appl(E2,G2)),appl(F2,G2)))),appl(lambda(I2,lambda(J2,merge(drs([],[appl(noir,J2)]),appl(I2,J2)))),lambda(H2,drs([],[appl(chat,H2)]))))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(P1,lambda(R1,appl(Q1,R1))),appl(O1,lambda(S1,appl(Q1,S1))))))),appl(lambda(T1,lambda(U1,merge(merge(drs([variable(V1)],[bool(num(V1),=,3)]),appl(T1,V1)),appl(U1,V1)))),appl(lambda(X1,lambda(Y1,merge(drs([],[appl(violet,Y1)]),appl(X1,Y1)))),lambda(W1,drs([],[appl(chat,W1)]))))),appl(lambda(K1,lambda(L1,merge(merge(drs([variable(M1)],[bool(num(M1),=,6)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(chat,N1)]))))))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,?)]),appl(D1,E1)))),lambda(B1,merge(drs([variable(C1)],[bool(C1,=,'masculin?')]),appl(B1,C1)))))))).

% = Reduced Semantics

semantics(237, reduced, presup(drs([variable(C)],[appl(herbe,C)]),drs([event(A),variable(B),variable(D),event(E),variable(F),variable(G),variable(H),event(I)],[bool(A,subseteq,B),appl(gris,B),appl(long,B),appl(appl(de,C),B),bool(num(D),=,6),appl(chat,D),appl(appl(existe,D),A),bool(num(F),=,3),appl(violet,F),appl(chat,F),appl(appl(existe,F),A),appl(noir,G),appl(chat,G),appl(appl(existe,G),A),appl(blanc,H),appl(chat,H),appl(appl(courir,H),I),bool(appl(temps,I),overlaps,maintenant),appl(appl(existe,H),A)]))).


% = Semantics

semantics(238, unreduced, appl(lambda(K,K),appl(lambda(I1,merge(drs([event(J1)],[]),appl(I1,J1))),appl(appl(lambda(E1,lambda(F1,lambda(G1,appl(F1,lambda(H1,drs([],[appl(appl(appl(poursuivre,H1),H1),G1),bool(appl(temps,G1),overlaps,maintenant)])))))),lambda(C1,appl(C1,D1))),appl(appl(lambda(R,lambda(S,lambda(T,merge(appl(S,lambda(U,appl(T,U))),appl(R,lambda(V,appl(T,V))))))),appl(lambda(W,lambda(X,merge(merge(drs([variable(Y)],[]),appl(W,Y)),appl(X,Y)))),appl(lambda(A1,lambda(B1,merge(drs([],[appl(orange,B1)]),appl(A1,B1)))),lambda(Z,drs([],[appl(chat,Z)]))))),appl(lambda(L,lambda(M,merge(merge(drs([variable(N)],[]),appl(L,N)),appl(M,N)))),appl(lambda(P,lambda(Q,merge(drs([],[appl(violet,Q)]),appl(P,Q)))),lambda(O,drs([],[appl(chat,O)]))))))))).

% = Reduced Semantics

semantics(238, reduced, drs([event(A),variable(B),variable(C)],[appl(violet,B),appl(chat,B),appl(appl(appl(poursuivre,B),B),A),bool(appl(temps,A),overlaps,maintenant),appl(orange,C),appl(chat,C),appl(appl(appl(poursuivre,C),C),A)])).


% = Semantics

semantics(239, unreduced, appl(lambda(A1,A1),appl(lambda(S3,merge(drs([event(T3)],[]),appl(S3,T3))),appl(appl(lambda(D3,lambda(E3,lambda(F3,merge(merge(drs([variable(G3)],[bool(F3,subseteq,G3)]),appl(D3,G3)),appl(E3,F3))))),appl(lambda(Q3,lambda(R3,merge(drs([],[appl(gris,R3)]),appl(Q3,R3)))),appl(appl(lambda(I3,lambda(J3,lambda(K3,merge(appl(J3,K3),appl(I3,lambda(L3,drs([],[appl(appl(de,L3),K3)]))))))),appl(lambda(M3,lambda(N3,presup(merge(drs([variable(O3)],[]),appl(M3,O3)),appl(N3,O3)))),lambda(P3,drs([],[appl(herbe,P3)])))),lambda(H3,drs([],[appl(long,H3)]))))),appl(appl(appl(lambda(F1,lambda(G1,lambda(H1,lambda(I1,appl(F1,lambda(J1,drs([event(I1)],[appl(appl(existe,J1),I1)]))))))),appl(appl(lambda(K2,lambda(L2,lambda(M2,merge(appl(L2,lambda(N2,appl(M2,N2))),appl(K2,lambda(O2,appl(M2,O2))))))),appl(lambda(P2,lambda(Q2,merge(merge(drs([variable(R2)],[]),appl(P2,R2)),appl(Q2,R2)))),appl(appl(lambda(V2,lambda(W2,lambda(X2,merge(appl(W2,X2),merge(drs([event(Y2)],[]),appl(appl(V2,lambda(Z2,appl(Z2,X2))),Y2)))))),lambda(A3,lambda(B3,appl(A3,lambda(C3,drs([],[appl(appl(courir,C3),B3),bool(appl(temps,B3),overlaps,maintenant)])))))),appl(lambda(T2,lambda(U2,merge(drs([],[appl(blanc,U2)]),appl(T2,U2)))),lambda(S2,drs([],[appl(chat,S2)])))))),appl(appl(lambda(Z1,lambda(A2,lambda(B2,merge(appl(A2,lambda(C2,appl(B2,C2))),appl(Z1,lambda(D2,appl(B2,D2))))))),appl(lambda(E2,lambda(F2,merge(merge(drs([variable(G2)],[]),appl(E2,G2)),appl(F2,G2)))),appl(lambda(I2,lambda(J2,merge(drs([],[appl(noir,J2)]),appl(I2,J2)))),lambda(H2,drs([],[appl(chat,H2)]))))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(P1,lambda(R1,appl(Q1,R1))),appl(O1,lambda(S1,appl(Q1,S1))))))),appl(lambda(T1,lambda(U1,merge(merge(drs([variable(V1)],[bool(num(V1),=,3)]),appl(T1,V1)),appl(U1,V1)))),appl(lambda(X1,lambda(Y1,merge(drs([],[appl(violet,Y1)]),appl(X1,Y1)))),lambda(W1,drs([],[appl(chat,W1)]))))),appl(lambda(K1,lambda(L1,merge(merge(drs([variable(M1)],[bool(num(M1),=,6)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(chat,N1)]))))))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,?)]),appl(D1,E1)))),lambda(B1,merge(drs([variable(C1)],[bool(C1,=,'masculin?')]),appl(B1,C1)))))))).

% = Reduced Semantics

semantics(239, reduced, presup(drs([variable(C)],[appl(herbe,C)]),drs([event(A),variable(B),variable(D),event(E),variable(F),variable(G),variable(H),event(I)],[bool(A,subseteq,B),appl(gris,B),appl(long,B),appl(appl(de,C),B),bool(num(D),=,6),appl(chat,D),appl(appl(existe,D),A),bool(num(F),=,3),appl(violet,F),appl(chat,F),appl(appl(existe,F),A),appl(noir,G),appl(chat,G),appl(appl(existe,G),A),appl(blanc,H),appl(chat,H),appl(appl(courir,H),I),bool(appl(temps,I),overlaps,maintenant),appl(appl(existe,H),A)]))).


% = Semantics

semantics(240, unreduced, appl(lambda(G,G),appl(lambda(T,merge(drs([event(U)],[]),appl(T,U))),appl(appl(lambda(P,lambda(Q,lambda(R,appl(Q,lambda(S,drs([],[appl(appl(appl(poursuivre,S),S),R),bool(appl(temps,R),overlaps,maintenant)])))))),lambda(N,appl(N,O))),appl(lambda(H,lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,2)]),appl(H,J)),appl(I,J)))),appl(lambda(L,lambda(M,merge(drs([],[appl(orange,M)]),appl(L,M)))),lambda(K,drs([],[appl(chat,K)])))))))).

% = Reduced Semantics

semantics(240, reduced, drs([event(A),variable(B)],[bool(num(B),=,2),appl(orange,B),appl(chat,B),appl(appl(appl(poursuivre,B),B),A),bool(appl(temps,A),overlaps,maintenant)])).


% = Semantics

semantics(259, unreduced, appl(lambda(O,O),appl(lambda(X1,merge(drs([event(Y1)],[]),appl(X1,Y1))),appl(appl(lambda(K1,lambda(L1,lambda(M1,merge(appl(K1,lambda(N1,drs([],[appl(appl(dans,N1),M1)]))),appl(L1,M1))))),appl(lambda(O1,lambda(P1,presup(merge(drs([variable(Q1)],[]),appl(O1,Q1)),appl(P1,Q1)))),appl(appl(lambda(S1,lambda(T1,lambda(U1,merge(appl(T1,U1),merge(drs([variable(V1)],[appl(appl(de,V1),U1)]),appl(S1,V1)))))),lambda(W1,drs([],[appl(classe,W1)]))),lambda(R1,drs([],[appl(salle,R1)]))))),appl(appl(lambda(X,lambda(Y,lambda(Z,merge(appl(appl(X,Y),Z),drs([],[drs([event(A1)],[bool(appl(temps,Z),<,appl(temps,A1)),bool(appl(temps,A1),overlaps,maintenant)])]))))),appl(lambda(B1,lambda(C1,lambda(D1,appl(C1,lambda(E1,appl(B1,lambda(F1,drs([],[appl(appl(appl(poursuivre,F1),E1),D1)])))))))),appl(lambda(G1,lambda(H1,merge(merge(drs([variable(I1)],[bool(num(I1),=,2)]),appl(G1,I1)),appl(H1,I1)))),lambda(J1,drs([],[appl(dame,J1)]))))),appl(lambda(P,lambda(Q,appl(P,lambda(R,merge(appl(Q,R),drs([],[appl(plus_de,R)])))))),appl(lambda(S,S),appl(lambda(T,lambda(U,merge(merge(drs([variable(V)],[bool(num(V),=,5)]),appl(T,V)),appl(U,V)))),lambda(W,drs([],[appl(mec,W)])))))))))).

% = Reduced Semantics

semantics(259, reduced, presup(drs([variable(B),variable(C)],[appl(salle,B),appl(appl(de,C),B),appl(classe,C)]),drs([event(A),variable(D),variable(E)],[appl(appl(dans,B),A),bool(num(D),=,5),appl(mec,D),bool(num(E),=,2),appl(dame,E),appl(appl(appl(poursuivre,E),D),A),appl(plus_de,D),drs([event(F)],[bool(appl(temps,A),<,appl(temps,F)),bool(appl(temps,F),overlaps,maintenant)])]))).


% = Semantics

semantics(260, unreduced, appl(lambda(O,O),appl(lambda(Z1,merge(drs([event(A2)],[]),appl(Z1,A2))),appl(appl(lambda(M1,lambda(N1,lambda(O1,merge(appl(M1,lambda(P1,drs([],[appl(appl(dans,P1),O1)]))),appl(N1,O1))))),appl(lambda(Q1,lambda(R1,presup(merge(drs([variable(S1)],[]),appl(Q1,S1)),appl(R1,S1)))),appl(appl(lambda(U1,lambda(V1,lambda(W1,merge(appl(V1,W1),merge(drs([variable(X1)],[appl(appl(de,X1),W1)]),appl(U1,X1)))))),lambda(Y1,drs([],[appl(classe,Y1)]))),lambda(T1,drs([],[appl(salle,T1)]))))),appl(appl(lambda(Z,lambda(A1,lambda(B1,merge(appl(appl(Z,A1),B1),drs([],[drs([event(C1)],[bool(appl(temps,B1),<,appl(temps,C1)),bool(appl(temps,C1),overlaps,maintenant)])]))))),appl(lambda(D1,lambda(E1,lambda(F1,appl(E1,lambda(G1,appl(D1,lambda(H1,drs([],[appl(appl(appl(poursuivre,H1),G1),F1)])))))))),appl(lambda(I1,lambda(J1,merge(merge(drs([variable(K1)],[bool(num(K1),=,2)]),appl(I1,K1)),appl(J1,K1)))),lambda(L1,drs([],[appl(dame,L1)]))))),appl(lambda(P,lambda(Q,presup(merge(drs([variable(R)],[]),appl(P,R)),appl(Q,R)))),appl(lambda(S,lambda(T,appl(S,lambda(U,drs([],[appl(plupart_de,U)]))))),appl(lambda(V,lambda(W,presup(merge(drs([variable(X)],[bool(num(X),>,1)]),appl(V,X)),appl(W,X)))),lambda(Y,drs([],[appl(mec,Y)])))))))))).

% = Reduced Semantics

semantics(260, reduced, presup(drs([variable(E),variable(B),variable(C),variable(D)],[bool(num(E),>,1),appl(mec,E),appl(salle,B),appl(appl(de,C),B),appl(classe,C),appl(plupart_de,E)]),drs([event(A),variable(F)],[appl(appl(dans,B),A),bool(num(F),=,2),appl(dame,F),appl(appl(appl(poursuivre,F),D),A),drs([event(G)],[bool(appl(temps,A),<,appl(temps,G)),bool(appl(temps,G),overlaps,maintenant)])]))).


% = Semantics

semantics(261, unreduced, appl(lambda(O,O),appl(lambda(X1,merge(drs([event(Y1)],[]),appl(X1,Y1))),appl(appl(lambda(K1,lambda(L1,lambda(M1,merge(appl(K1,lambda(N1,drs([],[appl(appl(dans,N1),M1)]))),appl(L1,M1))))),appl(lambda(O1,lambda(P1,presup(merge(drs([variable(Q1)],[]),appl(O1,Q1)),appl(P1,Q1)))),appl(appl(lambda(S1,lambda(T1,lambda(U1,merge(appl(T1,U1),merge(drs([variable(V1)],[appl(appl(de,V1),U1)]),appl(S1,V1)))))),lambda(W1,drs([],[appl(classe,W1)]))),lambda(R1,drs([],[appl(salle,R1)]))))),appl(appl(lambda(X,lambda(Y,lambda(Z,merge(appl(appl(X,Y),Z),drs([],[drs([event(A1)],[bool(appl(temps,Z),<,appl(temps,A1)),bool(appl(temps,A1),overlaps,maintenant)])]))))),appl(lambda(B1,lambda(C1,lambda(D1,appl(C1,lambda(E1,appl(B1,lambda(F1,drs([],[appl(appl(appl(poursuivre,F1),E1),D1)])))))))),appl(lambda(G1,lambda(H1,merge(merge(drs([variable(I1)],[bool(num(I1),=,2)]),appl(G1,I1)),appl(H1,I1)))),lambda(J1,drs([],[appl(dame,J1)]))))),appl(lambda(P,lambda(Q,appl(P,lambda(R,merge(appl(Q,R),drs([],[appl(plus_de,R)])))))),appl(lambda(S,S),appl(lambda(T,lambda(U,merge(merge(drs([variable(V)],[bool(num(V),=,5)]),appl(T,V)),appl(U,V)))),lambda(W,drs([],[appl(mec,W)])))))))))).

% = Reduced Semantics

semantics(261, reduced, presup(drs([variable(B),variable(C)],[appl(salle,B),appl(appl(de,C),B),appl(classe,C)]),drs([event(A),variable(D),variable(E)],[appl(appl(dans,B),A),bool(num(D),=,5),appl(mec,D),bool(num(E),=,2),appl(dame,E),appl(appl(appl(poursuivre,E),D),A),appl(plus_de,D),drs([event(F)],[bool(appl(temps,A),<,appl(temps,F)),bool(appl(temps,F),overlaps,maintenant)])]))).


% = Semantics

semantics(262, unreduced, appl(lambda(O,O),appl(lambda(Z1,merge(drs([event(A2)],[]),appl(Z1,A2))),appl(appl(lambda(M1,lambda(N1,lambda(O1,merge(appl(M1,lambda(P1,drs([],[appl(appl(dans,P1),O1)]))),appl(N1,O1))))),appl(lambda(Q1,lambda(R1,presup(merge(drs([variable(S1)],[]),appl(Q1,S1)),appl(R1,S1)))),appl(appl(lambda(U1,lambda(V1,lambda(W1,merge(appl(V1,W1),merge(drs([variable(X1)],[appl(appl(de,X1),W1)]),appl(U1,X1)))))),lambda(Y1,drs([],[appl(classe,Y1)]))),lambda(T1,drs([],[appl(salle,T1)]))))),appl(appl(lambda(T,lambda(U,lambda(V,merge(appl(appl(T,U),V),drs([],[drs([event(W)],[bool(appl(temps,V),<,appl(temps,W)),bool(appl(temps,W),overlaps,maintenant)])]))))),appl(lambda(X,lambda(Y,lambda(Z,appl(Y,lambda(A1,appl(X,lambda(B1,drs([],[appl(appl(appl(poursuivre,B1),A1),Z)])))))))),appl(lambda(C1,lambda(D1,presup(merge(drs([variable(E1)],[]),appl(C1,E1)),appl(D1,E1)))),appl(lambda(F1,lambda(G1,appl(F1,lambda(H1,drs([],[appl(plupart_de,H1)]))))),appl(lambda(I1,lambda(J1,presup(merge(drs([variable(K1)],[bool(num(K1),>,1)]),appl(I1,K1)),appl(J1,K1)))),lambda(L1,drs([],[appl(dame,L1)]))))))),appl(lambda(P,lambda(Q,merge(merge(drs([variable(R)],[bool(num(R),>,1)]),appl(P,R)),appl(Q,R)))),lambda(S,drs([],[appl(mec,S)])))))))).

% = Reduced Semantics

semantics(262, reduced, presup(drs([variable(F),variable(B),variable(C),variable(E)],[bool(num(F),>,1),appl(dame,F),appl(salle,B),appl(appl(de,C),B),appl(classe,C),appl(plupart_de,F)]),drs([event(A),variable(D)],[appl(appl(dans,B),A),bool(num(D),>,1),appl(mec,D),appl(appl(appl(poursuivre,E),D),A),drs([event(G)],[bool(appl(temps,A),<,appl(temps,G)),bool(appl(temps,G),overlaps,maintenant)])]))).


% = Semantics

semantics(263, unreduced, appl(lambda(O,O),appl(lambda(X1,merge(drs([event(Y1)],[]),appl(X1,Y1))),appl(appl(lambda(K1,lambda(L1,lambda(M1,merge(appl(K1,lambda(N1,drs([],[appl(appl(dans,N1),M1)]))),appl(L1,M1))))),appl(lambda(O1,lambda(P1,presup(merge(drs([variable(Q1)],[]),appl(O1,Q1)),appl(P1,Q1)))),appl(appl(lambda(S1,lambda(T1,lambda(U1,merge(appl(T1,U1),merge(drs([variable(V1)],[appl(appl(de,V1),U1)]),appl(S1,V1)))))),lambda(W1,drs([],[appl(classe,W1)]))),lambda(R1,drs([],[appl(salle,R1)]))))),appl(appl(lambda(X,lambda(Y,lambda(Z,merge(appl(appl(X,Y),Z),drs([],[drs([event(A1)],[bool(appl(temps,Z),<,appl(temps,A1)),bool(appl(temps,A1),overlaps,maintenant)])]))))),appl(lambda(B1,lambda(C1,lambda(D1,appl(C1,lambda(E1,appl(B1,lambda(F1,drs([],[appl(appl(appl(poursuivre,F1),E1),D1)])))))))),appl(lambda(G1,lambda(H1,merge(merge(drs([variable(I1)],[bool(num(I1),=,2)]),appl(G1,I1)),appl(H1,I1)))),lambda(J1,drs([],[appl(dame,J1)]))))),appl(lambda(P,lambda(Q,appl(P,lambda(R,merge(appl(Q,R),drs([],[appl(plus_de,R)])))))),appl(lambda(S,S),appl(lambda(T,lambda(U,merge(merge(drs([variable(V)],[bool(num(V),=,5)]),appl(T,V)),appl(U,V)))),lambda(W,drs([],[appl(mec,W)])))))))))).

% = Reduced Semantics

semantics(263, reduced, presup(drs([variable(B),variable(C)],[appl(salle,B),appl(appl(de,C),B),appl(classe,C)]),drs([event(A),variable(D),variable(E)],[appl(appl(dans,B),A),bool(num(D),=,5),appl(mec,D),bool(num(E),=,2),appl(dame,E),appl(appl(appl(poursuivre,E),D),A),appl(plus_de,D),drs([event(F)],[bool(appl(temps,A),<,appl(temps,F)),bool(appl(temps,F),overlaps,maintenant)])]))).


% = Semantics

semantics(264, unreduced, appl(lambda(P,P),appl(lambda(B2,merge(drs([event(C2)],[]),appl(B2,C2))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(O1,lambda(R1,drs([],[appl(appl(dans,R1),Q1)]))),appl(P1,Q1))))),appl(lambda(S1,lambda(T1,presup(merge(drs([variable(U1)],[]),appl(S1,U1)),appl(T1,U1)))),appl(appl(lambda(W1,lambda(X1,lambda(Y1,merge(appl(X1,Y1),merge(drs([variable(Z1)],[appl(appl(de,Z1),Y1)]),appl(W1,Z1)))))),lambda(A2,drs([],[appl(classe,A2)]))),lambda(V1,drs([],[appl(salle,V1)]))))),appl(appl(lambda(U,U),appl(lambda(V,lambda(W,lambda(X,merge(appl(appl(V,W),X),drs([],[drs([event(Y)],[bool(appl(temps,X),<,appl(temps,Y)),bool(appl(temps,Y),overlaps,maintenant)])]))))),appl(lambda(Z,lambda(A1,lambda(B1,appl(A1,lambda(C1,appl(Z,lambda(D1,drs([],[appl(appl(appl(poursuivre,D1),C1),B1)])))))))),appl(lambda(E1,lambda(F1,presup(merge(drs([variable(G1)],[]),appl(E1,G1)),appl(F1,G1)))),appl(lambda(H1,lambda(I1,appl(H1,lambda(J1,drs([],[appl(plupart_de,J1)]))))),appl(lambda(K1,lambda(L1,presup(merge(drs([variable(M1)],[bool(num(M1),>,1)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(dame,N1)])))))))),appl(lambda(Q,lambda(R,drs([],[bool(merge(drs([variable(S)],[]),appl(Q,S)),->,drs([],[not(appl(R,S))]))]))),lambda(T,drs([],[appl(mec,T)])))))))).

% = Reduced Semantics

semantics(264, reduced, presup(drs([variable(F),variable(B),variable(C),variable(E)],[bool(num(F),>,1),appl(dame,F),appl(salle,B),appl(appl(de,C),B),appl(classe,C),appl(plupart_de,F)]),drs([event(A)],[bool(drs([variable(D)],[appl(mec,D)]),->,drs([],[not(drs([],[appl(appl(appl(poursuivre,E),D),A)]))])),appl(appl(dans,B),A),drs([event(G)],[bool(appl(temps,A),<,appl(temps,G)),bool(appl(temps,G),overlaps,maintenant)])]))).


% = Semantics

semantics(265, unreduced, appl(lambda(O,O),appl(lambda(X1,merge(drs([event(Y1)],[]),appl(X1,Y1))),appl(appl(lambda(K1,lambda(L1,lambda(M1,merge(appl(K1,lambda(N1,drs([],[appl(appl(dans,N1),M1)]))),appl(L1,M1))))),appl(lambda(O1,lambda(P1,presup(merge(drs([variable(Q1)],[]),appl(O1,Q1)),appl(P1,Q1)))),appl(appl(lambda(S1,lambda(T1,lambda(U1,merge(appl(T1,U1),merge(drs([variable(V1)],[appl(appl(de,V1),U1)]),appl(S1,V1)))))),lambda(W1,drs([],[appl(classe,W1)]))),lambda(R1,drs([],[appl(salle,R1)]))))),appl(appl(lambda(X,lambda(Y,lambda(Z,merge(appl(appl(X,Y),Z),drs([],[drs([event(A1)],[bool(appl(temps,Z),<,appl(temps,A1)),bool(appl(temps,A1),overlaps,maintenant)])]))))),appl(lambda(B1,lambda(C1,lambda(D1,appl(C1,lambda(E1,appl(B1,lambda(F1,drs([],[appl(appl(appl(poursuivre,F1),E1),D1)])))))))),appl(lambda(G1,lambda(H1,merge(merge(drs([variable(I1)],[bool(num(I1),=,2)]),appl(G1,I1)),appl(H1,I1)))),lambda(J1,drs([],[appl(dame,J1)]))))),appl(lambda(P,lambda(Q,appl(P,lambda(R,merge(appl(Q,R),drs([],[appl(plus_de,R)])))))),appl(lambda(S,S),appl(lambda(T,lambda(U,merge(merge(drs([variable(V)],[bool(num(V),=,5)]),appl(T,V)),appl(U,V)))),lambda(W,drs([],[appl(mec,W)])))))))))).

% = Reduced Semantics

semantics(265, reduced, presup(drs([variable(B),variable(C)],[appl(salle,B),appl(appl(de,C),B),appl(classe,C)]),drs([event(A),variable(D),variable(E)],[appl(appl(dans,B),A),bool(num(D),=,5),appl(mec,D),bool(num(E),=,2),appl(dame,E),appl(appl(appl(poursuivre,E),D),A),appl(plus_de,D),drs([event(F)],[bool(appl(temps,A),<,appl(temps,F)),bool(appl(temps,F),overlaps,maintenant)])]))).


% = Semantics

semantics(266, unreduced, appl(lambda(P,P),appl(lambda(B2,merge(drs([event(C2)],[]),appl(B2,C2))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(O1,lambda(R1,drs([],[appl(appl(dans,R1),Q1)]))),appl(P1,Q1))))),appl(lambda(S1,lambda(T1,presup(merge(drs([variable(U1)],[]),appl(S1,U1)),appl(T1,U1)))),appl(appl(lambda(W1,lambda(X1,lambda(Y1,merge(appl(X1,Y1),merge(drs([variable(Z1)],[appl(appl(de,Z1),Y1)]),appl(W1,Z1)))))),lambda(A2,drs([],[appl(classe,A2)]))),lambda(V1,drs([],[appl(salle,V1)]))))),appl(appl(lambda(B1,lambda(C1,lambda(D1,merge(appl(appl(B1,C1),D1),drs([],[drs([event(E1)],[bool(appl(temps,D1),<,appl(temps,E1)),bool(appl(temps,E1),overlaps,maintenant)])]))))),appl(lambda(F1,lambda(G1,lambda(H1,appl(G1,lambda(I1,appl(F1,lambda(J1,drs([],[appl(appl(appl(poursuivre,J1),I1),H1)])))))))),appl(lambda(K1,lambda(L1,merge(merge(drs([variable(M1)],[bool(num(M1),=,2)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(dame,N1)]))))),appl(lambda(Q,lambda(R,appl(Q,lambda(S,merge(appl(R,S),drs([],[appl(pas,S)])))))),appl(lambda(T,lambda(U,appl(T,lambda(V,merge(appl(U,V),drs([],[appl(moins_de,V)])))))),appl(lambda(W,W),appl(lambda(X,lambda(Y,merge(merge(drs([variable(Z)],[bool(num(Z),=,4)]),appl(X,Z)),appl(Y,Z)))),lambda(A1,drs([],[appl(mec,A1)]))))))))))).

% = Reduced Semantics

semantics(266, reduced, presup(drs([variable(B),variable(C)],[appl(salle,B),appl(appl(de,C),B),appl(classe,C)]),drs([event(A),variable(D),variable(E)],[appl(appl(dans,B),A),bool(num(D),=,4),appl(mec,D),bool(num(E),=,2),appl(dame,E),appl(appl(appl(poursuivre,E),D),A),appl(pas,D),appl(moins_de,D),drs([event(F)],[bool(appl(temps,A),<,appl(temps,F)),bool(appl(temps,F),overlaps,maintenant)])]))).


% = Semantics

semantics(267, unreduced, appl(lambda(O,O),appl(lambda(X1,merge(drs([event(Y1)],[]),appl(X1,Y1))),appl(appl(lambda(K1,lambda(L1,lambda(M1,merge(appl(K1,lambda(N1,drs([],[appl(appl(dans,N1),M1)]))),appl(L1,M1))))),appl(lambda(O1,lambda(P1,presup(merge(drs([variable(Q1)],[]),appl(O1,Q1)),appl(P1,Q1)))),appl(appl(lambda(S1,lambda(T1,lambda(U1,merge(appl(T1,U1),merge(drs([variable(V1)],[appl(appl(de,V1),U1)]),appl(S1,V1)))))),lambda(W1,drs([],[appl(classe,W1)]))),lambda(R1,drs([],[appl(salle,R1)]))))),appl(appl(lambda(X,lambda(Y,lambda(Z,merge(appl(appl(X,Y),Z),drs([],[drs([event(A1)],[bool(appl(temps,Z),<,appl(temps,A1)),bool(appl(temps,A1),overlaps,maintenant)])]))))),appl(lambda(B1,lambda(C1,lambda(D1,appl(C1,lambda(E1,appl(B1,lambda(F1,drs([],[appl(appl(appl(poursuivre,F1),E1),D1)])))))))),appl(lambda(G1,lambda(H1,merge(merge(drs([variable(I1)],[bool(num(I1),=,2)]),appl(G1,I1)),appl(H1,I1)))),lambda(J1,drs([],[appl(dame,J1)]))))),appl(lambda(P,lambda(Q,appl(P,lambda(R,merge(appl(Q,R),drs([],[appl(plus_de,R)])))))),appl(lambda(S,S),appl(lambda(T,lambda(U,merge(merge(drs([variable(V)],[bool(num(V),=,5)]),appl(T,V)),appl(U,V)))),lambda(W,drs([],[appl(mec,W)])))))))))).

% = Reduced Semantics

semantics(267, reduced, presup(drs([variable(B),variable(C)],[appl(salle,B),appl(appl(de,C),B),appl(classe,C)]),drs([event(A),variable(D),variable(E)],[appl(appl(dans,B),A),bool(num(D),=,5),appl(mec,D),bool(num(E),=,2),appl(dame,E),appl(appl(appl(poursuivre,E),D),A),appl(plus_de,D),drs([event(F)],[bool(appl(temps,A),<,appl(temps,F)),bool(appl(temps,F),overlaps,maintenant)])]))).


% = Semantics

semantics(268, unreduced, appl(lambda(M,M),appl(lambda(R1,merge(drs([event(S1)],[]),appl(R1,S1))),appl(appl(lambda(E1,lambda(F1,lambda(G1,merge(appl(E1,lambda(H1,drs([],[appl(appl(dans,H1),G1)]))),appl(F1,G1))))),appl(lambda(I1,lambda(J1,presup(merge(drs([variable(K1)],[]),appl(I1,K1)),appl(J1,K1)))),appl(appl(lambda(M1,lambda(N1,lambda(O1,merge(appl(N1,O1),merge(drs([variable(P1)],[appl(appl(de,P1),O1)]),appl(M1,P1)))))),lambda(Q1,drs([],[appl(classe,Q1)]))),lambda(L1,drs([],[appl(salle,L1)]))))),appl(appl(lambda(R,lambda(S,lambda(T,merge(appl(appl(R,S),T),drs([],[drs([event(U)],[bool(appl(temps,T),<,appl(temps,U)),bool(appl(temps,U),overlaps,maintenant)])]))))),appl(lambda(V,lambda(W,lambda(X,appl(W,lambda(Y,appl(V,lambda(Z,drs([],[appl(appl(appl(poursuivre,Z),Y),X)])))))))),appl(lambda(A1,lambda(B1,merge(merge(drs([variable(C1)],[bool(num(C1),=,2)]),appl(A1,C1)),appl(B1,C1)))),lambda(D1,drs([],[appl(dame,D1)]))))),appl(lambda(N,lambda(O,merge(merge(drs([variable(P)],[bool(num(P),>,1)]),appl(N,P)),appl(O,P)))),lambda(Q,drs([],[appl(mec,Q)])))))))).

% = Reduced Semantics

semantics(268, reduced, presup(drs([variable(B),variable(C)],[appl(salle,B),appl(appl(de,C),B),appl(classe,C)]),drs([event(A),variable(D),variable(E)],[appl(appl(dans,B),A),bool(num(D),>,1),appl(mec,D),bool(num(E),=,2),appl(dame,E),appl(appl(appl(poursuivre,E),D),A),drs([event(F)],[bool(appl(temps,A),<,appl(temps,F)),bool(appl(temps,F),overlaps,maintenant)])]))).


% = Semantics

semantics(269, unreduced, appl(lambda(O,O),appl(lambda(X1,merge(drs([event(Y1)],[]),appl(X1,Y1))),appl(appl(lambda(K1,lambda(L1,lambda(M1,merge(appl(K1,lambda(N1,drs([],[appl(appl(dans,N1),M1)]))),appl(L1,M1))))),appl(lambda(O1,lambda(P1,presup(merge(drs([variable(Q1)],[]),appl(O1,Q1)),appl(P1,Q1)))),appl(appl(lambda(S1,lambda(T1,lambda(U1,merge(appl(T1,U1),merge(drs([variable(V1)],[appl(appl(de,V1),U1)]),appl(S1,V1)))))),lambda(W1,drs([],[appl(classe,W1)]))),lambda(R1,drs([],[appl(salle,R1)]))))),appl(appl(lambda(X,lambda(Y,lambda(Z,merge(appl(appl(X,Y),Z),drs([],[drs([event(A1)],[bool(appl(temps,Z),<,appl(temps,A1)),bool(appl(temps,A1),overlaps,maintenant)])]))))),appl(lambda(B1,lambda(C1,lambda(D1,appl(C1,lambda(E1,appl(B1,lambda(F1,drs([],[appl(appl(appl(poursuivre,F1),E1),D1)])))))))),appl(lambda(G1,lambda(H1,merge(merge(drs([variable(I1)],[bool(num(I1),=,2)]),appl(G1,I1)),appl(H1,I1)))),lambda(J1,drs([],[appl(dame,J1)]))))),appl(lambda(P,lambda(Q,appl(P,lambda(R,merge(appl(Q,R),drs([],[appl(plus_de,R)])))))),appl(lambda(S,S),appl(lambda(T,lambda(U,merge(merge(drs([variable(V)],[bool(num(V),=,5)]),appl(T,V)),appl(U,V)))),lambda(W,drs([],[appl(mec,W)])))))))))).

% = Reduced Semantics

semantics(269, reduced, presup(drs([variable(B),variable(C)],[appl(salle,B),appl(appl(de,C),B),appl(classe,C)]),drs([event(A),variable(D),variable(E)],[appl(appl(dans,B),A),bool(num(D),=,5),appl(mec,D),bool(num(E),=,2),appl(dame,E),appl(appl(appl(poursuivre,E),D),A),appl(plus_de,D),drs([event(F)],[bool(appl(temps,A),<,appl(temps,F)),bool(appl(temps,F),overlaps,maintenant)])]))).


% = Semantics

semantics(270, unreduced, appl(lambda(O,O),appl(lambda(Y1,merge(drs([event(Z1)],[]),appl(Y1,Z1))),appl(appl(lambda(L1,lambda(M1,lambda(N1,merge(appl(L1,lambda(O1,drs([],[appl(appl(dans,O1),N1)]))),appl(M1,N1))))),appl(lambda(P1,lambda(Q1,presup(merge(drs([variable(R1)],[]),appl(P1,R1)),appl(Q1,R1)))),appl(appl(lambda(T1,lambda(U1,lambda(V1,merge(appl(U1,V1),merge(drs([variable(W1)],[appl(appl(de,W1),V1)]),appl(T1,W1)))))),lambda(X1,drs([],[appl(classe,X1)]))),lambda(S1,drs([],[appl(salle,S1)]))))),appl(appl(lambda(T,lambda(U,lambda(V,merge(appl(appl(T,U),V),drs([],[drs([event(W)],[bool(appl(temps,V),<,appl(temps,W)),bool(appl(temps,W),overlaps,maintenant)])]))))),appl(lambda(X,lambda(Y,lambda(Z,appl(Y,lambda(A1,appl(X,lambda(B1,drs([],[appl(appl(appl(poursuivre,B1),A1),Z)])))))))),appl(lambda(C1,lambda(D1,merge(appl(C1,lambda(E1,drs([variable(F1)],[bool(F1,=,appl(plus_de,E1))]))),appl(D1,F1)))),appl(lambda(G1,G1),appl(lambda(H1,lambda(I1,merge(merge(drs([variable(J1)],[bool(num(J1),=,3)]),appl(H1,J1)),appl(I1,J1)))),lambda(K1,drs([],[appl(dame,K1)]))))))),appl(lambda(P,lambda(Q,merge(merge(drs([variable(R)],[bool(num(R),>,1)]),appl(P,R)),appl(Q,R)))),lambda(S,drs([],[appl(mec,S)])))))))).

% = Reduced Semantics

semantics(270, reduced, presup(drs([variable(B),variable(C)],[appl(salle,B),appl(appl(de,C),B),appl(classe,C)]),drs([event(A),variable(D),variable(E),variable(F)],[appl(appl(dans,B),A),bool(num(D),>,1),appl(mec,D),bool(num(E),=,3),appl(dame,E),bool(F,=,appl(plus_de,E)),appl(appl(appl(poursuivre,F),D),A),drs([event(G)],[bool(appl(temps,A),<,appl(temps,G)),bool(appl(temps,G),overlaps,maintenant)])]))).


% = Semantics

semantics(271, unreduced, appl(lambda(O,O),appl(lambda(X1,merge(drs([event(Y1)],[]),appl(X1,Y1))),appl(appl(lambda(K1,lambda(L1,lambda(M1,merge(appl(K1,lambda(N1,drs([],[appl(appl(dans,N1),M1)]))),appl(L1,M1))))),appl(lambda(O1,lambda(P1,presup(merge(drs([variable(Q1)],[]),appl(O1,Q1)),appl(P1,Q1)))),appl(appl(lambda(S1,lambda(T1,lambda(U1,merge(appl(T1,U1),merge(drs([variable(V1)],[appl(appl(de,V1),U1)]),appl(S1,V1)))))),lambda(W1,drs([],[appl(classe,W1)]))),lambda(R1,drs([],[appl(salle,R1)]))))),appl(appl(lambda(X,lambda(Y,lambda(Z,merge(appl(appl(X,Y),Z),drs([],[drs([event(A1)],[bool(appl(temps,Z),<,appl(temps,A1)),bool(appl(temps,A1),overlaps,maintenant)])]))))),appl(lambda(B1,lambda(C1,lambda(D1,appl(C1,lambda(E1,appl(B1,lambda(F1,drs([],[appl(appl(appl(poursuivre,F1),E1),D1)])))))))),appl(lambda(G1,lambda(H1,merge(merge(drs([variable(I1)],[bool(num(I1),=,2)]),appl(G1,I1)),appl(H1,I1)))),lambda(J1,drs([],[appl(dame,J1)]))))),appl(lambda(P,lambda(Q,appl(P,lambda(R,merge(appl(Q,R),drs([],[appl(plus_de,R)])))))),appl(lambda(S,S),appl(lambda(T,lambda(U,merge(merge(drs([variable(V)],[bool(num(V),=,5)]),appl(T,V)),appl(U,V)))),lambda(W,drs([],[appl(mec,W)])))))))))).

% = Reduced Semantics

semantics(271, reduced, presup(drs([variable(B),variable(C)],[appl(salle,B),appl(appl(de,C),B),appl(classe,C)]),drs([event(A),variable(D),variable(E)],[appl(appl(dans,B),A),bool(num(D),=,5),appl(mec,D),bool(num(E),=,2),appl(dame,E),appl(appl(appl(poursuivre,E),D),A),appl(plus_de,D),drs([event(F)],[bool(appl(temps,A),<,appl(temps,F)),bool(appl(temps,F),overlaps,maintenant)])]))).


% = Semantics

semantics(272, unreduced, appl(lambda(O,O),appl(lambda(X1,merge(drs([event(Y1)],[]),appl(X1,Y1))),appl(appl(lambda(K1,lambda(L1,lambda(M1,merge(appl(K1,lambda(N1,drs([],[appl(appl(dans,N1),M1)]))),appl(L1,M1))))),appl(lambda(O1,lambda(P1,presup(merge(drs([variable(Q1)],[]),appl(O1,Q1)),appl(P1,Q1)))),appl(appl(lambda(S1,lambda(T1,lambda(U1,merge(appl(T1,U1),merge(drs([variable(V1)],[appl(appl(de,V1),U1)]),appl(S1,V1)))))),lambda(W1,drs([],[appl(classe,W1)]))),lambda(R1,drs([],[appl(salle,R1)]))))),appl(appl(lambda(T,lambda(U,lambda(V,merge(appl(appl(T,U),V),drs([],[drs([event(W)],[bool(appl(temps,V),<,appl(temps,W)),bool(appl(temps,W),overlaps,maintenant)])]))))),appl(lambda(X,lambda(Y,lambda(Z,appl(Y,lambda(A1,appl(X,lambda(B1,drs([],[appl(appl(appl(poursuivre,B1),A1),Z)])))))))),appl(lambda(C1,lambda(D1,appl(C1,lambda(E1,merge(appl(D1,E1),drs([],[appl(moins_de,E1)])))))),appl(lambda(F1,F1),appl(lambda(G1,lambda(H1,merge(merge(drs([variable(I1)],[bool(num(I1),=,3)]),appl(G1,I1)),appl(H1,I1)))),lambda(J1,drs([],[appl(dame,J1)]))))))),appl(lambda(P,lambda(Q,merge(merge(drs([variable(R)],[bool(num(R),>,1)]),appl(P,R)),appl(Q,R)))),lambda(S,drs([],[appl(mec,S)])))))))).

% = Reduced Semantics

semantics(272, reduced, presup(drs([variable(B),variable(C)],[appl(salle,B),appl(appl(de,C),B),appl(classe,C)]),drs([event(A),variable(D),variable(E)],[appl(appl(dans,B),A),bool(num(D),>,1),appl(mec,D),bool(num(E),=,3),appl(dame,E),appl(appl(appl(poursuivre,E),D),A),appl(moins_de,E),drs([event(F)],[bool(appl(temps,A),<,appl(temps,F)),bool(appl(temps,F),overlaps,maintenant)])]))).


% = Semantics

semantics(273, unreduced, appl(lambda(O,O),appl(lambda(X1,merge(drs([event(Y1)],[]),appl(X1,Y1))),appl(appl(lambda(K1,lambda(L1,lambda(M1,merge(appl(K1,lambda(N1,drs([],[appl(appl(dans,N1),M1)]))),appl(L1,M1))))),appl(lambda(O1,lambda(P1,presup(merge(drs([variable(Q1)],[]),appl(O1,Q1)),appl(P1,Q1)))),appl(appl(lambda(S1,lambda(T1,lambda(U1,merge(appl(T1,U1),merge(drs([variable(V1)],[appl(appl(de,V1),U1)]),appl(S1,V1)))))),lambda(W1,drs([],[appl(classe,W1)]))),lambda(R1,drs([],[appl(salle,R1)]))))),appl(appl(lambda(X,lambda(Y,lambda(Z,merge(appl(appl(X,Y),Z),drs([],[drs([event(A1)],[bool(appl(temps,Z),<,appl(temps,A1)),bool(appl(temps,A1),overlaps,maintenant)])]))))),appl(lambda(B1,lambda(C1,lambda(D1,appl(C1,lambda(E1,appl(B1,lambda(F1,drs([],[appl(appl(appl(poursuivre,F1),E1),D1)])))))))),appl(lambda(G1,lambda(H1,merge(merge(drs([variable(I1)],[bool(num(I1),=,2)]),appl(G1,I1)),appl(H1,I1)))),lambda(J1,drs([],[appl(dame,J1)]))))),appl(lambda(P,lambda(Q,appl(P,lambda(R,merge(appl(Q,R),drs([],[appl(plus_de,R)])))))),appl(lambda(S,S),appl(lambda(T,lambda(U,merge(merge(drs([variable(V)],[bool(num(V),=,5)]),appl(T,V)),appl(U,V)))),lambda(W,drs([],[appl(mec,W)])))))))))).

% = Reduced Semantics

semantics(273, reduced, presup(drs([variable(B),variable(C)],[appl(salle,B),appl(appl(de,C),B),appl(classe,C)]),drs([event(A),variable(D),variable(E)],[appl(appl(dans,B),A),bool(num(D),=,5),appl(mec,D),bool(num(E),=,2),appl(dame,E),appl(appl(appl(poursuivre,E),D),A),appl(plus_de,D),drs([event(F)],[bool(appl(temps,A),<,appl(temps,F)),bool(appl(temps,F),overlaps,maintenant)])]))).


% = Semantics

semantics(274, unreduced, appl(lambda(P,P),appl(lambda(B2,merge(drs([event(C2)],[]),appl(B2,C2))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(O1,lambda(R1,drs([],[appl(appl(dans,R1),Q1)]))),appl(P1,Q1))))),appl(lambda(S1,lambda(T1,presup(merge(drs([variable(U1)],[]),appl(S1,U1)),appl(T1,U1)))),appl(appl(lambda(W1,lambda(X1,lambda(Y1,merge(appl(X1,Y1),merge(drs([variable(Z1)],[appl(appl(de,Z1),Y1)]),appl(W1,Z1)))))),lambda(A2,drs([],[appl(classe,A2)]))),lambda(V1,drs([],[appl(salle,V1)]))))),appl(appl(lambda(Y,lambda(Z,lambda(A1,merge(appl(appl(Y,Z),A1),drs([],[drs([event(B1)],[bool(appl(temps,A1),<,appl(temps,B1)),bool(appl(temps,B1),overlaps,maintenant)])]))))),appl(lambda(C1,lambda(D1,lambda(E1,appl(D1,lambda(F1,appl(C1,lambda(G1,drs([],[appl(appl(appl(poursuivre,G1),F1),E1)])))))))),appl(lambda(H1,lambda(I1,appl(H1,lambda(J1,merge(appl(I1,J1),drs([],[appl(tout,J1)])))))),appl(lambda(K1,lambda(L1,presup(merge(drs([variable(M1)],[bool(num(M1),>,1)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(dame,N1)])))))),appl(lambda(Q,lambda(R,appl(Q,lambda(S,merge(appl(R,S),drs([],[appl(moins_de,S)])))))),appl(lambda(T,T),appl(lambda(U,lambda(V,merge(merge(drs([variable(W)],[bool(num(W),=,5)]),appl(U,W)),appl(V,W)))),lambda(X,drs([],[appl(mec,X)])))))))))).

% = Reduced Semantics

semantics(274, reduced, presup(drs([variable(B),variable(C),variable(E)],[appl(salle,B),appl(appl(de,C),B),appl(classe,C),bool(num(E),>,1),appl(dame,E)]),drs([event(A),variable(D)],[appl(appl(dans,B),A),bool(num(D),=,5),appl(mec,D),appl(appl(appl(poursuivre,E),D),A),appl(tout,E),appl(moins_de,D),drs([event(F)],[bool(appl(temps,A),<,appl(temps,F)),bool(appl(temps,F),overlaps,maintenant)])]))).


% = Semantics

semantics(275, unreduced, appl(lambda(O,O),appl(lambda(X1,merge(drs([event(Y1)],[]),appl(X1,Y1))),appl(appl(lambda(K1,lambda(L1,lambda(M1,merge(appl(K1,lambda(N1,drs([],[appl(appl(dans,N1),M1)]))),appl(L1,M1))))),appl(lambda(O1,lambda(P1,presup(merge(drs([variable(Q1)],[]),appl(O1,Q1)),appl(P1,Q1)))),appl(appl(lambda(S1,lambda(T1,lambda(U1,merge(appl(T1,U1),merge(drs([variable(V1)],[appl(appl(de,V1),U1)]),appl(S1,V1)))))),lambda(W1,drs([],[appl(classe,W1)]))),lambda(R1,drs([],[appl(salle,R1)]))))),appl(appl(lambda(X,lambda(Y,lambda(Z,merge(appl(appl(X,Y),Z),drs([],[drs([event(A1)],[bool(appl(temps,Z),<,appl(temps,A1)),bool(appl(temps,A1),overlaps,maintenant)])]))))),appl(lambda(B1,lambda(C1,lambda(D1,appl(C1,lambda(E1,appl(B1,lambda(F1,drs([],[appl(appl(appl(poursuivre,F1),E1),D1)])))))))),appl(lambda(G1,lambda(H1,merge(merge(drs([variable(I1)],[bool(num(I1),=,2)]),appl(G1,I1)),appl(H1,I1)))),lambda(J1,drs([],[appl(dame,J1)]))))),appl(lambda(P,lambda(Q,appl(P,lambda(R,merge(appl(Q,R),drs([],[appl(plus_de,R)])))))),appl(lambda(S,S),appl(lambda(T,lambda(U,merge(merge(drs([variable(V)],[bool(num(V),=,5)]),appl(T,V)),appl(U,V)))),lambda(W,drs([],[appl(mec,W)])))))))))).

% = Reduced Semantics

semantics(275, reduced, presup(drs([variable(B),variable(C)],[appl(salle,B),appl(appl(de,C),B),appl(classe,C)]),drs([event(A),variable(D),variable(E)],[appl(appl(dans,B),A),bool(num(D),=,5),appl(mec,D),bool(num(E),=,2),appl(dame,E),appl(appl(appl(poursuivre,E),D),A),appl(plus_de,D),drs([event(F)],[bool(appl(temps,A),<,appl(temps,F)),bool(appl(temps,F),overlaps,maintenant)])]))).


% = Semantics

semantics(276, unreduced, appl(lambda(M,M),appl(lambda(R1,merge(drs([event(S1)],[]),appl(R1,S1))),appl(appl(lambda(E1,lambda(F1,lambda(G1,merge(appl(E1,lambda(H1,drs([],[appl(appl(dans,H1),G1)]))),appl(F1,G1))))),appl(lambda(I1,lambda(J1,presup(merge(drs([variable(K1)],[]),appl(I1,K1)),appl(J1,K1)))),appl(appl(lambda(M1,lambda(N1,lambda(O1,merge(appl(N1,O1),merge(drs([variable(P1)],[appl(appl(de,P1),O1)]),appl(M1,P1)))))),lambda(Q1,drs([],[appl(classe,Q1)]))),lambda(L1,drs([],[appl(salle,L1)]))))),appl(appl(lambda(R,lambda(S,lambda(T,merge(appl(appl(R,S),T),drs([],[drs([event(U)],[bool(appl(temps,T),<,appl(temps,U)),bool(appl(temps,U),overlaps,maintenant)])]))))),appl(lambda(V,lambda(W,lambda(X,appl(W,lambda(Y,appl(V,lambda(Z,drs([],[appl(appl(appl(poursuivre,Z),Y),X)])))))))),appl(lambda(A1,lambda(B1,merge(merge(drs([variable(C1)],[bool(num(C1),=,2)]),appl(A1,C1)),appl(B1,C1)))),lambda(D1,drs([],[appl(dame,D1)]))))),appl(lambda(N,lambda(O,merge(merge(drs([variable(P)],[bool(num(P),=,2)]),appl(N,P)),appl(O,P)))),lambda(Q,drs([],[appl(mec,Q)])))))))).

% = Reduced Semantics

semantics(276, reduced, presup(drs([variable(B),variable(C)],[appl(salle,B),appl(appl(de,C),B),appl(classe,C)]),drs([event(A),variable(D),variable(E)],[appl(appl(dans,B),A),bool(num(D),=,2),appl(mec,D),bool(num(E),=,2),appl(dame,E),appl(appl(appl(poursuivre,E),D),A),drs([event(F)],[bool(appl(temps,A),<,appl(temps,F)),bool(appl(temps,F),overlaps,maintenant)])]))).


% = Semantics

semantics(277, unreduced, appl(lambda(O,O),appl(lambda(X1,merge(drs([event(Y1)],[]),appl(X1,Y1))),appl(appl(lambda(K1,lambda(L1,lambda(M1,merge(appl(K1,lambda(N1,drs([],[appl(appl(dans,N1),M1)]))),appl(L1,M1))))),appl(lambda(O1,lambda(P1,presup(merge(drs([variable(Q1)],[]),appl(O1,Q1)),appl(P1,Q1)))),appl(appl(lambda(S1,lambda(T1,lambda(U1,merge(appl(T1,U1),merge(drs([variable(V1)],[appl(appl(de,V1),U1)]),appl(S1,V1)))))),lambda(W1,drs([],[appl(classe,W1)]))),lambda(R1,drs([],[appl(salle,R1)]))))),appl(appl(lambda(X,lambda(Y,lambda(Z,merge(appl(appl(X,Y),Z),drs([],[drs([event(A1)],[bool(appl(temps,Z),<,appl(temps,A1)),bool(appl(temps,A1),overlaps,maintenant)])]))))),appl(lambda(B1,lambda(C1,lambda(D1,appl(C1,lambda(E1,appl(B1,lambda(F1,drs([],[appl(appl(appl(poursuivre,F1),E1),D1)])))))))),appl(lambda(G1,lambda(H1,merge(merge(drs([variable(I1)],[bool(num(I1),=,2)]),appl(G1,I1)),appl(H1,I1)))),lambda(J1,drs([],[appl(dame,J1)]))))),appl(lambda(P,lambda(Q,appl(P,lambda(R,merge(appl(Q,R),drs([],[appl(plus_de,R)])))))),appl(lambda(S,S),appl(lambda(T,lambda(U,merge(merge(drs([variable(V)],[bool(num(V),=,5)]),appl(T,V)),appl(U,V)))),lambda(W,drs([],[appl(mec,W)])))))))))).

% = Reduced Semantics

semantics(277, reduced, presup(drs([variable(B),variable(C)],[appl(salle,B),appl(appl(de,C),B),appl(classe,C)]),drs([event(A),variable(D),variable(E)],[appl(appl(dans,B),A),bool(num(D),=,5),appl(mec,D),bool(num(E),=,2),appl(dame,E),appl(appl(appl(poursuivre,E),D),A),appl(plus_de,D),drs([event(F)],[bool(appl(temps,A),<,appl(temps,F)),bool(appl(temps,F),overlaps,maintenant)])]))).


% = Semantics

semantics(278, unreduced, appl(lambda(O,O),appl(lambda(Y1,merge(drs([event(Z1)],[]),appl(Y1,Z1))),appl(appl(lambda(L1,lambda(M1,lambda(N1,merge(appl(L1,lambda(O1,drs([],[appl(appl(dans,O1),N1)]))),appl(M1,N1))))),appl(lambda(P1,lambda(Q1,presup(merge(drs([variable(R1)],[]),appl(P1,R1)),appl(Q1,R1)))),appl(appl(lambda(T1,lambda(U1,lambda(V1,merge(appl(U1,V1),merge(drs([variable(W1)],[appl(appl(de,W1),V1)]),appl(T1,W1)))))),lambda(X1,drs([],[appl(classe,X1)]))),lambda(S1,drs([],[appl(salle,S1)]))))),appl(appl(lambda(Y,lambda(Z,lambda(A1,merge(appl(appl(Y,Z),A1),drs([],[drs([event(B1)],[bool(appl(temps,A1),<,appl(temps,B1)),bool(appl(temps,B1),overlaps,maintenant)])]))))),appl(lambda(C1,lambda(D1,lambda(E1,appl(D1,lambda(F1,appl(C1,lambda(G1,drs([],[appl(appl(appl(poursuivre,G1),F1),E1)])))))))),appl(lambda(H1,lambda(I1,merge(merge(drs([variable(J1)],[bool(num(J1),=,2)]),appl(H1,J1)),appl(I1,J1)))),lambda(K1,drs([],[appl(dame,K1)]))))),appl(lambda(P,lambda(Q,merge(merge(drs([variable(R)],[bool(num(R),=,100)]),appl(P,R)),appl(Q,R)))),appl(appl(lambda(T,lambda(U,lambda(V,presup(merge(drs([variable(W)],[bool(num(W),>,1)]),appl(T,W)),merge(appl(U,V),drs([],[appl(appl(de,W),V)])))))),lambda(X,drs([],[appl(mec,X)]))),lambda(S,drs([],[appl('%',S)]))))))))).

% = Reduced Semantics

semantics(278, reduced, presup(drs([variable(B),variable(C),variable(E)],[appl(salle,B),appl(appl(de,C),B),appl(classe,C),bool(num(E),>,1),appl(mec,E)]),drs([event(A),variable(D),variable(F)],[appl(appl(dans,B),A),bool(num(D),=,100),appl('%',D),appl(appl(de,E),D),bool(num(F),=,2),appl(dame,F),appl(appl(appl(poursuivre,F),D),A),drs([event(G)],[bool(appl(temps,A),<,appl(temps,G)),bool(appl(temps,G),overlaps,maintenant)])]))).


% = Semantics

semantics(279, unreduced, appl(lambda(O,O),appl(lambda(X1,merge(drs([event(Y1)],[]),appl(X1,Y1))),appl(appl(lambda(K1,lambda(L1,lambda(M1,merge(appl(K1,lambda(N1,drs([],[appl(appl(dans,N1),M1)]))),appl(L1,M1))))),appl(lambda(O1,lambda(P1,presup(merge(drs([variable(Q1)],[]),appl(O1,Q1)),appl(P1,Q1)))),appl(appl(lambda(S1,lambda(T1,lambda(U1,merge(appl(T1,U1),merge(drs([variable(V1)],[appl(appl(de,V1),U1)]),appl(S1,V1)))))),lambda(W1,drs([],[appl(classe,W1)]))),lambda(R1,drs([],[appl(salle,R1)]))))),appl(appl(lambda(X,lambda(Y,lambda(Z,merge(appl(appl(X,Y),Z),drs([],[drs([event(A1)],[bool(appl(temps,Z),<,appl(temps,A1)),bool(appl(temps,A1),overlaps,maintenant)])]))))),appl(lambda(B1,lambda(C1,lambda(D1,appl(C1,lambda(E1,appl(B1,lambda(F1,drs([],[appl(appl(appl(poursuivre,F1),E1),D1)])))))))),appl(lambda(G1,lambda(H1,merge(merge(drs([variable(I1)],[bool(num(I1),=,2)]),appl(G1,I1)),appl(H1,I1)))),lambda(J1,drs([],[appl(dame,J1)]))))),appl(lambda(P,lambda(Q,appl(P,lambda(R,merge(appl(Q,R),drs([],[appl(plus_de,R)])))))),appl(lambda(S,S),appl(lambda(T,lambda(U,merge(merge(drs([variable(V)],[bool(num(V),=,5)]),appl(T,V)),appl(U,V)))),lambda(W,drs([],[appl(mec,W)])))))))))).

% = Reduced Semantics

semantics(279, reduced, presup(drs([variable(B),variable(C)],[appl(salle,B),appl(appl(de,C),B),appl(classe,C)]),drs([event(A),variable(D),variable(E)],[appl(appl(dans,B),A),bool(num(D),=,5),appl(mec,D),bool(num(E),=,2),appl(dame,E),appl(appl(appl(poursuivre,E),D),A),appl(plus_de,D),drs([event(F)],[bool(appl(temps,A),<,appl(temps,F)),bool(appl(temps,F),overlaps,maintenant)])]))).


% = Semantics

semantics(280, unreduced, appl(lambda(P,P),appl(lambda(B2,merge(drs([event(C2)],[]),appl(B2,C2))),appl(appl(lambda(O1,lambda(P1,lambda(Q1,merge(appl(O1,lambda(R1,drs([],[appl(appl(dans,R1),Q1)]))),appl(P1,Q1))))),appl(lambda(S1,lambda(T1,presup(merge(drs([variable(U1)],[]),appl(S1,U1)),appl(T1,U1)))),appl(appl(lambda(W1,lambda(X1,lambda(Y1,merge(appl(X1,Y1),merge(drs([variable(Z1)],[appl(appl(de,Z1),Y1)]),appl(W1,Z1)))))),lambda(A2,drs([],[appl(classe,A2)]))),lambda(V1,drs([],[appl(salle,V1)]))))),appl(appl(lambda(B1,lambda(C1,lambda(D1,merge(appl(appl(B1,C1),D1),drs([],[drs([event(E1)],[bool(appl(temps,D1),<,appl(temps,E1)),bool(appl(temps,E1),overlaps,maintenant)])]))))),appl(lambda(F1,lambda(G1,lambda(H1,appl(G1,lambda(I1,appl(F1,lambda(J1,drs([],[appl(appl(appl(poursuivre,J1),I1),H1)])))))))),appl(lambda(K1,lambda(L1,merge(merge(drs([variable(M1)],[bool(num(M1),=,2)]),appl(K1,M1)),appl(L1,M1)))),lambda(N1,drs([],[appl(dame,N1)]))))),appl(lambda(Q,lambda(R,presup(merge(drs([variable(S)],[bool(num(S),>,1)]),appl(Q,S)),appl(R,S)))),appl(appl(lambda(W,lambda(X,lambda(Y,presup(merge(drs([variable(Z)],[bool(num(Z),>,1)]),appl(W,Z)),merge(appl(X,Y),drs([],[appl(appl(de,Z),Y)])))))),lambda(A1,drs([],[appl(mec,A1)]))),appl(lambda(T,lambda(U,merge(drs([],[bool(num(U),=,2)]),appl(T,U)))),lambda(V,drs([],[appl(tiers,V)])))))))))).

% = Reduced Semantics

semantics(280, reduced, presup(drs([variable(E),variable(B),variable(C),variable(D)],[bool(num(E),>,1),appl(mec,E),appl(salle,B),appl(appl(de,C),B),appl(classe,C),bool(num(D),>,1),bool(num(D),=,2),appl(tiers,D),appl(appl(de,E),D)]),drs([event(A),variable(F)],[appl(appl(dans,B),A),bool(num(F),=,2),appl(dame,F),appl(appl(appl(poursuivre,F),D),A),drs([event(G)],[bool(appl(temps,A),<,appl(temps,G)),bool(appl(temps,G),overlaps,maintenant)])]))).


% = Semantics

semantics(281, unreduced, appl(lambda(O,O),appl(lambda(X1,merge(drs([event(Y1)],[]),appl(X1,Y1))),appl(appl(lambda(K1,lambda(L1,lambda(M1,merge(appl(K1,lambda(N1,drs([],[appl(appl(dans,N1),M1)]))),appl(L1,M1))))),appl(lambda(O1,lambda(P1,presup(merge(drs([variable(Q1)],[]),appl(O1,Q1)),appl(P1,Q1)))),appl(appl(lambda(S1,lambda(T1,lambda(U1,merge(appl(T1,U1),merge(drs([variable(V1)],[appl(appl(de,V1),U1)]),appl(S1,V1)))))),lambda(W1,drs([],[appl(classe,W1)]))),lambda(R1,drs([],[appl(salle,R1)]))))),appl(appl(lambda(X,lambda(Y,lambda(Z,merge(appl(appl(X,Y),Z),drs([],[drs([event(A1)],[bool(appl(temps,Z),<,appl(temps,A1)),bool(appl(temps,A1),overlaps,maintenant)])]))))),appl(lambda(B1,lambda(C1,lambda(D1,appl(C1,lambda(E1,appl(B1,lambda(F1,drs([],[appl(appl(appl(poursuivre,F1),E1),D1)])))))))),appl(lambda(G1,lambda(H1,merge(merge(drs([variable(I1)],[bool(num(I1),=,2)]),appl(G1,I1)),appl(H1,I1)))),lambda(J1,drs([],[appl(dame,J1)]))))),appl(lambda(P,lambda(Q,appl(P,lambda(R,merge(appl(Q,R),drs([],[appl(plus_de,R)])))))),appl(lambda(S,S),appl(lambda(T,lambda(U,merge(merge(drs([variable(V)],[bool(num(V),=,5)]),appl(T,V)),appl(U,V)))),lambda(W,drs([],[appl(mec,W)])))))))))).

% = Reduced Semantics

semantics(281, reduced, presup(drs([variable(B),variable(C)],[appl(salle,B),appl(appl(de,C),B),appl(classe,C)]),drs([event(A),variable(D),variable(E)],[appl(appl(dans,B),A),bool(num(D),=,5),appl(mec,D),bool(num(E),=,2),appl(dame,E),appl(appl(appl(poursuivre,E),D),A),appl(plus_de,D),drs([event(F)],[bool(appl(temps,A),<,appl(temps,F)),bool(appl(temps,F),overlaps,maintenant)])]))).


% = Semantics

semantics(282, unreduced, appl(lambda(O,O),appl(lambda(X1,merge(drs([event(Y1)],[]),appl(X1,Y1))),appl(appl(lambda(K1,lambda(L1,lambda(M1,merge(appl(K1,lambda(N1,drs([],[appl(appl(dans,N1),M1)]))),appl(L1,M1))))),appl(lambda(O1,lambda(P1,presup(merge(drs([variable(Q1)],[]),appl(O1,Q1)),appl(P1,Q1)))),appl(appl(lambda(S1,lambda(T1,lambda(U1,merge(appl(T1,U1),merge(drs([variable(V1)],[appl(appl(de,V1),U1)]),appl(S1,V1)))))),lambda(W1,drs([],[appl(classe,W1)]))),lambda(R1,drs([],[appl(salle,R1)]))))),appl(appl(lambda(T,T),appl(lambda(U,lambda(V,lambda(W,merge(appl(appl(U,V),W),drs([],[drs([event(X)],[bool(appl(temps,W),<,appl(temps,X)),bool(appl(temps,X),overlaps,maintenant)])]))))),appl(lambda(Y,lambda(Z,lambda(A1,drs([],[not(appl(appl(Y,Z),A1))])))),appl(lambda(B1,lambda(C1,lambda(D1,appl(C1,lambda(E1,appl(B1,lambda(F1,drs([],[appl(appl(appl(poursuivre,F1),E1),D1)])))))))),appl(lambda(G1,lambda(H1,presup(merge(drs([variable(I1)],[bool(num(I1),>,1)]),appl(G1,I1)),appl(H1,I1)))),lambda(J1,drs([],[appl(dame,J1)]))))))),appl(lambda(P,lambda(Q,merge(merge(drs([variable(R)],[bool(num(R),>,1)]),appl(P,R)),appl(Q,R)))),lambda(S,drs([],[appl(mec,S)])))))))).

% = Reduced Semantics

semantics(282, reduced, presup(drs([variable(B),variable(C),variable(E)],[appl(salle,B),appl(appl(de,C),B),appl(classe,C),bool(num(E),>,1),appl(dame,E)]),drs([event(A)],[not(drs([variable(D)],[bool(num(D),>,1),appl(mec,D),appl(appl(appl(poursuivre,E),D),A)])),appl(appl(dans,B),A),drs([event(F)],[bool(appl(temps,A),<,appl(temps,F)),bool(appl(temps,F),overlaps,maintenant)])]))).


% = Semantics

semantics(301, unreduced, appl(lambda(I1,I1),appl(lambda(O4,merge(drs([event(P4)],[]),appl(O4,P4))),appl(appl('.',appl(appl(lambda(V3,lambda(W3,lambda(X3,merge(drs([event(Y3),event(X3)],[appl(appl(narration,X3),Y3)]),merge(appl(V3,Y3),appl(W3,X3)))))),appl(appl(lambda(D4,lambda(E4,lambda(F4,appl(E4,lambda(G4,appl(D4,lambda(H4,drs([],[appl(appl(appl(porter,H4),G4),F4),bool(appl(temps,F4),overlaps,maintenant)])))))))),appl(lambda(I4,lambda(J4,merge(merge(drs([variable(K4)],[bool(num(K4),>,1)]),appl(I4,K4)),appl(J4,K4)))),appl(lambda(M4,lambda(N4,merge(drs([],[appl(noir,N4)]),appl(M4,N4)))),lambda(L4,drs([],[appl(haut,L4)]))))),appl(lambda(Z3,lambda(A4,merge(merge(drs([variable(B4)],[]),appl(Z3,B4)),appl(A4,B4)))),lambda(C4,drs([],[appl(tiers,C4)]))))),appl(appl(lambda(C3,lambda(D3,lambda(E3,merge(drs([event(F3),event(E3)],[appl(appl(narration,F3),E3)]),merge(appl(C3,F3),appl(D3,E3)))))),appl(appl(lambda(K3,lambda(L3,lambda(M3,appl(L3,lambda(N3,appl(K3,lambda(O3,drs([],[appl(appl(appl(porter,O3),N3),M3),bool(appl(temps,M3),overlaps,maintenant)])))))))),appl(lambda(P3,lambda(Q3,merge(merge(drs([variable(R3)],[bool(num(R3),>,1)]),appl(P3,R3)),appl(Q3,R3)))),appl(lambda(T3,lambda(U3,merge(drs([],[appl(gri,U3)]),appl(T3,U3)))),lambda(S3,drs([],[appl(haut,S3)]))))),appl(lambda(G3,lambda(H3,merge(merge(drs([variable(I3)],[]),appl(G3,I3)),appl(H3,I3)))),lambda(J3,drs([],[appl(tiers,J3)]))))),appl(appl(lambda(R2,lambda(S2,lambda(T2,appl(S2,lambda(U2,appl(R2,lambda(V2,drs([],[appl(appl(appl(porter,V2),U2),T2),bool(appl(temps,T2),overlaps,maintenant)])))))))),appl(lambda(W2,lambda(X2,merge(merge(drs([variable(Y2)],[bool(num(Y2),>,1)]),appl(W2,Y2)),appl(X2,Y2)))),appl(lambda(A3,lambda(B3,merge(drs([],[appl(orange,B3)]),appl(A3,B3)))),lambda(Z2,drs([],[appl(haut,Z2)]))))),appl(lambda(N2,lambda(O2,merge(merge(drs([variable(P2)],[]),appl(N2,P2)),appl(O2,P2)))),lambda(Q2,drs([],[appl(tiers,Q2)]))))))),appl(appl(appl(lambda(N1,lambda(O1,lambda(P1,lambda(Q1,appl(N1,lambda(R1,drs([event(Q1)],[appl(appl(existe,R1),Q1)]))))))),appl(lambda(S1,lambda(T1,merge(merge(drs([variable(U1)],[bool(num(U1),=,12)]),appl(S1,U1)),appl(T1,U1)))),appl(lambda(L2,lambda(M2,merge(drs([],[appl(jaune,M2)]),appl(L2,M2)))),appl(appl(lambda(D2,lambda(E2,lambda(F2,merge(appl(E2,F2),appl(D2,lambda(G2,drs([],[appl(appl(de,G2),F2)]))))))),appl(lambda(H2,lambda(I2,merge(merge(drs([variable(J2)],[]),appl(H2,J2)),appl(I2,J2)))),lambda(K2,drs([],[appl(montagne,K2)])))),appl(appl(lambda(Y1,lambda(Z1,lambda(A2,presup(merge(drs([variable(B2)],[]),appl(Y1,B2)),merge(appl(Z1,A2),drs([],[appl(appl(à,B2),A2)])))))),lambda(C2,drs([],[appl(sommet,C2)]))),appl(lambda(W1,lambda(X1,merge(drs([],[appl(debout,X1)]),appl(W1,X1)))),lambda(V1,drs([],[appl(enfant,V1)])))))))),lambda(L1,merge(drs([variable(M1)],[bool(M1,=,?)]),appl(L1,M1)))),lambda(J1,merge(drs([variable(K1)],[bool(K1,=,'masculin?')]),appl(J1,K1)))))))).

% = Reduced Semantics

semantics(301, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(noir,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),merge(drs([event(G),event(H)],[appl(appl(narration,G),B)]),merge(merge(merge(drs([variable(I)],[]),drs([],[appl(tiers,I)])),merge(merge(drs([variable(J)],[bool(num(J),>,1)]),merge(drs([],[appl(gri,J)]),drs([],[appl(haut,J)]))),drs([],[appl(appl(appl(porter,J),I),G),bool(appl(temps,G),overlaps,maintenant)]))),merge(merge(drs([variable(K)],[]),drs([],[appl(tiers,K)])),merge(merge(drs([variable(L)],[bool(num(L),>,1)]),merge(drs([],[appl(orange,L)]),drs([],[appl(haut,L)]))),drs([],[appl(appl(appl(porter,L),K),B),bool(appl(temps,B),overlaps,maintenant)]))))))))),lambda(M,merge(merge(drs([variable(N)],[bool(num(N),=,12)]),merge(drs([],[appl(jaune,N)]),merge(presup(merge(drs([variable(O)],[]),drs([],[appl(sommet,O)])),merge(merge(drs([],[appl(debout,N)]),drs([],[appl(enfant,N)])),drs([],[appl(appl(à,O),N)]))),merge(merge(drs([variable(P)],[]),drs([],[appl(montagne,P)])),drs([],[appl(appl(de,P),N)]))))),drs([event(Q)],[appl(appl(existe,N),M)])))),A))).


% = Semantics

semantics(302, unreduced, appl(lambda(O,O),appl(lambda(Z1,merge(drs([event(A2)],[]),appl(Z1,A2))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(J1,lambda(L1,appl(H1,lambda(M1,drs([],[appl(appl(appl(appl(tenir_à,M1),L1),L1),K1),bool(appl(temps,K1),overlaps,maintenant)]))))))))),appl(lambda(N1,lambda(O1,merge(merge(drs([variable(P1)],[]),appl(N1,P1)),appl(O1,P1)))),appl(appl(lambda(R1,lambda(S1,lambda(T1,merge(appl(S1,T1),appl(R1,lambda(U1,drs([],[appl(appl(de,U1),T1)]))))))),appl(lambda(V1,lambda(W1,merge(merge(drs([variable(X1)],[]),appl(V1,X1)),appl(W1,X1)))),lambda(Y1,drs([],[appl(montagne,Y1)])))),lambda(Q1,drs([],[appl(sommet,Q1)]))))),lambda(F1,appl(F1,G1))),appl(lambda(P,lambda(Q,merge(merge(drs([variable(R)],[bool(num(R),=,6)]),appl(P,R)),appl(Q,R)))),appl(lambda(D1,lambda(E1,merge(drs([],[appl(orange,E1)]),appl(D1,E1)))),appl(appl(lambda(T,lambda(U,lambda(V,merge(appl(T,lambda(W,drs([event(X),variable(Y)],[appl(generic,Y),appl(appl(appl(appl(porter,W),V),Y),X)]))),appl(U,V))))),appl(lambda(Z,lambda(A1,merge(merge(drs([variable(B1)],[bool(num(B1),>,1)]),appl(Z,B1)),appl(A1,B1)))),lambda(C1,drs([],[appl(haut,C1)])))),lambda(S,drs([],[appl(enfant,S)]))))))))).

% = Reduced Semantics

semantics(302, reduced, drs([event(A),variable(B),variable(C),event(D),variable(E),variable(F),variable(G)],[bool(num(B),=,6),appl(orange,B),bool(num(C),>,1),appl(haut,C),appl(generic,E),appl(appl(appl(appl(porter,C),B),E),D),appl(enfant,B),appl(sommet,F),appl(montagne,G),appl(appl(de,G),F),appl(appl(appl(appl(tenir_à,F),B),B),A),bool(appl(temps,A),overlaps,maintenant)])).


% = Semantics

semantics(303, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(gris,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(orange,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(303, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(gris,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(orange,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(305, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(gris,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(orange,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(305, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(gris,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(orange,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(307, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(gris,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(orange,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(307, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(gris,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(orange,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(308, unreduced, appl(lambda(H,H),appl(lambda(X,merge(drs([event(Y)],[]),appl(X,Y))),appl(appl(lambda(M,lambda(N,lambda(O,appl(N,lambda(P,appl(M,lambda(Q,drs([],[appl(appl(appl(porter,Q),P),O),bool(appl(temps,O),overlaps,maintenant)])))))))),appl(lambda(R,lambda(S,merge(merge(drs([variable(T)],[bool(num(T),>,1)]),appl(R,T)),appl(S,T)))),appl(lambda(V,lambda(W,merge(drs([],[appl(orange,W)]),appl(V,W)))),lambda(U,drs([],[appl(haut,U)]))))),appl(lambda(I,lambda(J,merge(merge(drs([variable(K)],[bool(num(K),=,4)]),appl(I,K)),appl(J,K)))),lambda(L,drs([],[appl(enfant,L)]))))))).

% = Reduced Semantics

semantics(308, reduced, drs([event(A),variable(B),variable(C)],[bool(num(B),=,4),appl(enfant,B),bool(num(C),>,1),appl(orange,C),appl(haut,C),appl(appl(appl(porter,C),B),A),bool(appl(temps,A),overlaps,maintenant)])).


% = Semantics

semantics(309, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(gris,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(orange,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(309, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(gris,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(orange,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(311, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(gris,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(orange,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(311, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(gris,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(orange,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(312, unreduced, appl(lambda(H,H),appl(lambda(Y,merge(drs([event(Z)],[]),appl(Y,Z))),appl(appl(lambda(P,lambda(Q,lambda(R,appl(Q,lambda(S,appl(P,lambda(T,drs([],[appl(appl(appl(porter,T),S),R),bool(appl(temps,R),overlaps,maintenant)])))))))),appl(lambda(U,lambda(V,merge(merge(drs([variable(W)],[bool(num(W),>,1)]),appl(U,W)),appl(V,W)))),lambda(X,drs([],[appl(haut,X)])))),appl(lambda(I,lambda(J,appl(I,lambda(K,merge(appl(J,K),drs([],[appl(tout,K)])))))),appl(lambda(L,lambda(M,presup(merge(drs([variable(N)],[bool(num(N),>,1)]),appl(L,N)),appl(M,N)))),lambda(O,drs([],[appl(enfant,O)])))))))).

% = Reduced Semantics

semantics(312, reduced, presup(drs([variable(B)],[bool(num(B),>,1),appl(enfant,B)]),drs([event(A),variable(C)],[bool(num(C),>,1),appl(haut,C),appl(appl(appl(porter,C),B),A),bool(appl(temps,A),overlaps,maintenant),appl(tout,B)]))).


% = Semantics

semantics(313, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(gris,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(orange,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(313, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(gris,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(orange,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(315, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(gris,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(orange,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(315, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(gris,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(orange,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(316, unreduced, appl(lambda(J,J),appl(lambda(D1,merge(drs([event(E1)],[]),appl(D1,E1))),appl(appl(lambda(S,lambda(T,lambda(U,appl(T,lambda(V,appl(S,lambda(W,drs([],[appl(appl(appl(porter,W),V),U),bool(appl(temps,U),overlaps,maintenant)])))))))),appl(lambda(X,lambda(Y,merge(merge(drs([variable(Z)],[bool(num(Z),>,1)]),appl(X,Z)),appl(Y,Z)))),appl(lambda(B1,lambda(C1,merge(drs([],[appl(orange,C1)]),appl(B1,C1)))),lambda(A1,drs([],[appl(haut,A1)]))))),appl(lambda(K,lambda(L,appl(K,lambda(M,merge(appl(L,M),drs([],[appl(moins_de,M)])))))),appl(lambda(N,N),appl(lambda(O,lambda(P,merge(merge(drs([variable(Q)],[bool(num(Q),=,5)]),appl(O,Q)),appl(P,Q)))),lambda(R,drs([],[appl(enfant,R)]))))))))).

% = Reduced Semantics

semantics(316, reduced, drs([event(A),variable(B),variable(C)],[bool(num(B),=,5),appl(enfant,B),bool(num(C),>,1),appl(orange,C),appl(haut,C),appl(appl(appl(porter,C),B),A),bool(appl(temps,A),overlaps,maintenant),appl(moins_de,B)])).


% = Semantics

semantics(317, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(gris,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(orange,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(317, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(gris,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(orange,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(319, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(gris,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(orange,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(319, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(gris,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(orange,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(321, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(gris,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(orange,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(321, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(gris,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(orange,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(323, unreduced, appl(lambda(C1,C1),appl(lambda(R3,merge(drs([event(S3)],[]),appl(R3,S3))),appl(appl('.',appl(appl(lambda(Y2,lambda(Z2,lambda(A3,merge(drs([event(B3),event(A3)],[appl(appl(narration,A3),B3)]),merge(appl(Y2,B3),appl(Z2,A3)))))),appl(appl(lambda(G3,lambda(H3,lambda(I3,appl(H3,lambda(J3,appl(G3,lambda(K3,drs([],[appl(appl(appl(porter,K3),J3),I3),bool(appl(temps,I3),overlaps,maintenant)])))))))),appl(lambda(L3,lambda(M3,merge(merge(drs([variable(N3)],[bool(num(N3),>,1)]),appl(L3,N3)),appl(M3,N3)))),appl(lambda(P3,lambda(Q3,merge(drs([],[appl(gris,Q3)]),appl(P3,Q3)))),lambda(O3,drs([],[appl(haut,O3)]))))),appl(lambda(C3,lambda(D3,merge(merge(drs([variable(E3)],[]),appl(C3,E3)),appl(D3,E3)))),lambda(F3,drs([],[appl(tiers,F3)]))))),appl(appl(lambda(N2,lambda(O2,lambda(P2,appl(O2,lambda(Q2,appl(N2,lambda(R2,drs([],[appl(appl(appl(porter,R2),Q2),P2),bool(appl(temps,P2),overlaps,maintenant)])))))))),appl(lambda(S2,lambda(T2,merge(merge(drs([variable(U2)],[bool(num(U2),>,1)]),appl(S2,U2)),appl(T2,U2)))),appl(lambda(W2,lambda(X2,merge(drs([],[appl(orange,X2)]),appl(W2,X2)))),lambda(V2,drs([],[appl(haut,V2)]))))),appl(lambda(H2,lambda(I2,presup(merge(drs([variable(J2)],[bool(num(J2),>,1)]),appl(H2,J2)),appl(I2,J2)))),appl(lambda(K2,lambda(L2,merge(drs([],[bool(num(L2),=,2)]),appl(K2,L2)))),lambda(M2,drs([],[appl(tiers,M2)]))))))),appl(appl(appl(lambda(H1,lambda(I1,lambda(J1,lambda(K1,appl(H1,lambda(L1,drs([event(K1)],[appl(appl(existe,L1),K1)]))))))),appl(lambda(M1,lambda(N1,merge(merge(drs([variable(O1)],[bool(num(O1),=,6)]),appl(M1,O1)),appl(N1,O1)))),appl(lambda(F2,lambda(G2,merge(drs([],[appl(jaune,G2)]),appl(F2,G2)))),appl(appl(lambda(X1,lambda(Y1,lambda(Z1,merge(appl(Y1,Z1),appl(X1,lambda(A2,drs([],[appl(appl(de,A2),Z1)]))))))),appl(lambda(B2,lambda(C2,merge(merge(drs([variable(D2)],[]),appl(B2,D2)),appl(C2,D2)))),lambda(E2,drs([],[appl(montagne,E2)])))),appl(appl(lambda(S1,lambda(T1,lambda(U1,presup(merge(drs([variable(V1)],[]),appl(S1,V1)),merge(appl(T1,U1),drs([],[appl(appl(à,V1),U1)])))))),lambda(W1,drs([],[appl(sommet,W1)]))),appl(lambda(Q1,lambda(R1,merge(drs([],[appl(debout,R1)]),appl(Q1,R1)))),lambda(P1,drs([],[appl(enfant,P1)])))))))),lambda(F1,merge(drs([variable(G1)],[bool(G1,=,?)]),appl(F1,G1)))),lambda(D1,merge(drs([variable(E1)],[bool(E1,=,'masculin?')]),appl(D1,E1)))))))).

% = Reduced Semantics

semantics(323, reduced, merge(drs([event(A)],[]),appl(appl(appl('.',lambda(B,merge(drs([event(C),event(D)],[appl(appl(narration,B),C)]),merge(merge(merge(drs([variable(E)],[]),drs([],[appl(tiers,E)])),merge(merge(drs([variable(F)],[bool(num(F),>,1)]),merge(drs([],[appl(gris,F)]),drs([],[appl(haut,F)]))),drs([],[appl(appl(appl(porter,F),E),C),bool(appl(temps,C),overlaps,maintenant)]))),presup(merge(drs([variable(G)],[bool(num(G),>,1)]),merge(drs([],[bool(num(G),=,2)]),drs([],[appl(tiers,G)]))),merge(merge(drs([variable(H)],[bool(num(H),>,1)]),merge(drs([],[appl(orange,H)]),drs([],[appl(haut,H)]))),drs([],[appl(appl(appl(porter,H),G),B),bool(appl(temps,B),overlaps,maintenant)]))))))),lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,6)]),merge(drs([],[appl(jaune,J)]),merge(presup(merge(drs([variable(K)],[]),drs([],[appl(sommet,K)])),merge(merge(drs([],[appl(debout,J)]),drs([],[appl(enfant,J)])),drs([],[appl(appl(à,K),J)]))),merge(merge(drs([variable(L)],[]),drs([],[appl(montagne,L)])),drs([],[appl(appl(de,L),J)]))))),drs([event(M)],[appl(appl(existe,J),I)])))),A))).


% = Semantics

semantics(324, unreduced, appl(lambda(H,H),appl(lambda(X,merge(drs([event(Y)],[]),appl(X,Y))),appl(appl(lambda(M,lambda(N,lambda(O,appl(N,lambda(P,appl(M,lambda(Q,drs([],[appl(appl(appl(avoir,Q),P),O),bool(appl(temps,O),overlaps,maintenant)])))))))),appl(lambda(R,lambda(S,presup(merge(drs([variable(T)],[bool(num(T),>,1)]),appl(R,T)),appl(S,T)))),appl(lambda(V,lambda(W,merge(drs([],[appl(orange,W)]),appl(V,W)))),lambda(U,drs([],[appl(cheveu,U)]))))),appl(lambda(I,lambda(J,merge(merge(drs([variable(K)],[bool(num(K),>,1)]),appl(I,K)),appl(J,K)))),lambda(L,drs([],[appl(enfant,L)]))))))).

% = Reduced Semantics

semantics(324, reduced, presup(drs([variable(C)],[bool(num(C),>,1),appl(orange,C),appl(cheveu,C)]),drs([event(A),variable(B)],[bool(num(B),>,1),appl(enfant,B),appl(appl(appl(avoir,C),B),A),bool(appl(temps,A),overlaps,maintenant)]))).


% = Semantics

semantics(326, unreduced, appl(lambda(J,J),appl(lambda(F1,merge(drs([event(G1)],[]),appl(F1,G1))),appl(appl(lambda(S,lambda(T,lambda(U,merge(appl(appl(S,T),U),drs([],[drs([event(V)],[bool(appl(temps,U),<,appl(temps,V)),bool(appl(temps,V),overlaps,maintenant)])]))))),appl(lambda(W,lambda(X,lambda(Y,appl(X,lambda(Z,appl(W,lambda(A1,drs([],[appl(appl(appl(originaire_de,A1),Z),Y)])))))))),appl(lambda(B1,lambda(C1,merge(merge(drs([variable(D1)],[]),appl(B1,D1)),appl(C1,D1)))),lambda(E1,presup(drs([],[appl(appl(nommé,'Brésil'),E1)]),drs([],[])))))),appl(lambda(K,lambda(L,appl(K,lambda(M,merge(appl(L,M),drs([],[appl(plus_de,M)])))))),appl(lambda(N,N),appl(lambda(O,lambda(P,merge(merge(drs([variable(Q)],[bool(num(Q),=,4)]),appl(O,Q)),appl(P,Q)))),lambda(R,drs([],[appl(chanteur,R)]))))))))).

% = Reduced Semantics

semantics(326, reduced, presup(drs([],[appl(appl(nommé,'Brésil'),C)]),drs([event(A),variable(B),variable(C)],[bool(num(B),=,4),appl(chanteur,B),appl(appl(appl(originaire_de,C),B),A),appl(plus_de,B),drs([event(D)],[bool(appl(temps,A),<,appl(temps,D)),bool(appl(temps,D),overlaps,maintenant)])]))).


% = Semantics

semantics(328, unreduced, appl(lambda(J,J),appl(lambda(E1,merge(drs([event(F1)],[]),appl(E1,F1))),appl(appl(lambda(V,lambda(W,lambda(X,appl(W,lambda(Y,appl(V,lambda(Z,drs([],[appl(appl(appl(venir_de,Z),Y),X),bool(appl(temps,X),overlaps,maintenant)])))))))),appl(lambda(A1,lambda(B1,merge(merge(drs([variable(C1)],[]),appl(A1,C1)),appl(B1,C1)))),lambda(D1,presup(drs([],[appl(appl(nommé,'Brésil'),D1)]),drs([],[]))))),appl(lambda(K,lambda(L,presup(merge(drs([variable(M)],[bool(num(M),>,1)]),appl(K,M)),appl(L,M)))),appl(appl(lambda(Q,lambda(R,lambda(S,presup(merge(drs([variable(T)],[bool(num(T),>,1)]),appl(Q,T)),merge(appl(R,S),drs([],[appl(appl(de,T),S)])))))),lambda(U,drs([],[appl(chanteur,U)]))),appl(lambda(N,lambda(O,merge(drs([],[bool(num(O),=,2)]),appl(N,O)))),lambda(P,drs([],[appl(tiers,P)]))))))))).

% = Reduced Semantics

semantics(328, reduced, presup(drs([variable(C),variable(B)],[bool(num(C),>,1),appl(chanteur,C),bool(num(B),>,1),bool(num(B),=,2),appl(tiers,B),appl(appl(de,C),B),appl(appl(nommé,'Brésil'),D)]),drs([event(A),variable(D)],[appl(appl(appl(venir_de,D),B),A),bool(appl(temps,A),overlaps,maintenant)]))).


% = Semantics

semantics(330, unreduced, appl(lambda(G,G),appl(lambda(U,merge(drs([event(V)],[]),appl(U,V))),appl(appl(lambda(L,lambda(M,lambda(N,appl(M,lambda(O,appl(L,lambda(P,drs([],[appl(appl(appl(venir_de,P),O),N),bool(appl(temps,N),overlaps,maintenant)])))))))),appl(lambda(Q,lambda(R,merge(merge(drs([variable(S)],[]),appl(Q,S)),appl(R,S)))),lambda(T,presup(drs([],[appl(appl(nommé,'Brésil'),T)]),drs([],[]))))),appl(lambda(H,lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,2)]),appl(H,J)),appl(I,J)))),lambda(K,drs([],[appl(chanteur,K)]))))))).

% = Reduced Semantics

semantics(330, reduced, presup(drs([],[appl(appl(nommé,'Brésil'),C)]),drs([event(A),variable(B),variable(C)],[bool(num(B),=,2),appl(chanteur,B),appl(appl(appl(venir_de,C),B),A),bool(appl(temps,A),overlaps,maintenant)]))).


% = Semantics

semantics(332, unreduced, appl(lambda(I,I),appl(lambda(C1,merge(drs([event(D1)],[]),appl(C1,D1))),appl(appl(lambda(T,lambda(U,lambda(V,appl(U,lambda(W,appl(T,lambda(X,drs([],[appl(appl(appl(venir_de,X),W),V),bool(appl(temps,V),overlaps,maintenant)])))))))),appl(lambda(Y,lambda(Z,merge(merge(drs([variable(A1)],[]),appl(Y,A1)),appl(Z,A1)))),lambda(B1,presup(drs([],[appl(appl(nommé,'Brésil'),B1)]),drs([],[]))))),appl(lambda(J,lambda(K,presup(merge(drs([variable(L)],[]),appl(J,L)),appl(K,L)))),appl(lambda(M,lambda(N,appl(M,lambda(O,drs([],[appl(plupart_de,O)]))))),appl(lambda(P,lambda(Q,presup(merge(drs([variable(R)],[bool(num(R),>,1)]),appl(P,R)),appl(Q,R)))),lambda(S,drs([],[appl(chanteur,S)]))))))))).

% = Reduced Semantics

semantics(332, reduced, presup(drs([variable(C),variable(B)],[bool(num(C),>,1),appl(chanteur,C),appl(plupart_de,C),appl(appl(nommé,'Brésil'),D)]),drs([event(A),variable(D)],[appl(appl(appl(venir_de,D),B),A),bool(appl(temps,A),overlaps,maintenant)]))).


% = Semantics

semantics(334, unreduced, appl(lambda(I,I),appl(lambda(Z,merge(drs([event(A1)],[]),appl(Z,A1))),appl(appl(lambda(N,N),lambda(A,appl(lambda(T,lambda(U,drs([],[not(appl(T,U))]))),appl(appl(lambda(O,lambda(P,lambda(Q,appl(P,lambda(R,appl(O,lambda(S,drs([],[appl(appl(appl(venir_de,S),R),Q),bool(appl(temps,Q),overlaps,maintenant)])))))))),appl(lambda(V,lambda(W,merge(merge(drs([variable(X)],[]),appl(V,X)),appl(W,X)))),lambda(Y,presup(drs([],[appl(appl(nommé,'Chili'),Y)]),drs([],[]))))),A)))),appl(lambda(J,lambda(K,merge(merge(drs([variable(L)],[bool(num(L),>,1)]),appl(J,L)),appl(K,L)))),lambda(M,drs([],[appl(chanteur,M)]))))))).

% = Reduced Semantics

semantics(334, reduced, presup(drs([],[appl(appl(nommé,'Chili'),C)]),drs([event(A)],[not(drs([variable(B),variable(C)],[bool(num(B),>,1),appl(chanteur,B),appl(appl(appl(venir_de,C),B),A),bool(appl(temps,A),overlaps,maintenant)]))]))).


% = Semantics

semantics(360, unreduced, appl(lambda(N,N),appl(lambda(R1,merge(drs([event(S1)],[]),appl(R1,S1))),appl(appl(lambda(H1,lambda(I1,lambda(J1,appl(I1,lambda(K1,appl(H1,lambda(L1,drs([],[appl(appl(appl(vivre_dans,L1),K1),J1),bool(appl(temps,J1),overlaps,maintenant)])))))))),appl(lambda(M1,M1),appl(lambda(N1,lambda(O1,presup(merge(drs([variable(P1)],[]),appl(N1,P1)),appl(O1,P1)))),lambda(Q1,drs([],[appl(richesse,Q1)]))))),appl(lambda(O,lambda(P,merge(merge(drs([variable(Q)],[bool(num(Q),=,36)]),appl(O,Q)),appl(P,Q)))),appl(appl(lambda(A1,lambda(B1,lambda(C1,merge(appl(B1,C1),merge(drs([variable(D1)],[appl(appl(de,D1),C1)]),appl(A1,D1)))))),appl(lambda(F1,lambda(G1,merge(drs([],[appl(latin,G1)]),appl(F1,G1)))),lambda(E1,presup(drs([],[appl(appl(nommé,'Amérique'),E1)]),drs([],[]))))),appl(appl(lambda(S,lambda(T,lambda(U,merge(appl(T,U),appl(S,lambda(V,drs([],[appl(appl(de,V),U)]))))))),appl(lambda(W,lambda(X,presup(merge(drs([variable(Y)],[]),appl(W,Y)),appl(X,Y)))),lambda(Z,drs([],[appl(population,Z)])))),lambda(R,drs([],[appl('%',R)]))))))))).

% = Reduced Semantics

semantics(360, reduced, presup(drs([variable(C),variable(E)],[appl(population,C),appl(appl(nommé,'Amérique'),D),appl(richesse,E)]),drs([event(A),variable(B),variable(D)],[bool(num(B),=,36),appl('%',B),appl(appl(de,C),B),appl(appl(de,D),B),appl(latin,D),appl(appl(appl(vivre_dans,E),B),A),bool(appl(temps,A),overlaps,maintenant)]))).


% = Semantics

semantics(374, unreduced, appl(lambda(I,I),appl(lambda(A1,merge(drs([event(B1)],[]),appl(A1,B1))),appl(appl(lambda(N,N),appl(lambda(O,lambda(P,lambda(Q,appl(P,lambda(R,appl(O,lambda(S,drs([],[appl(appl(appl(porter,S),R),Q),bool(appl(temps,Q),overlaps,maintenant)])))))))),appl(lambda(T,lambda(U,appl(T,lambda(V,merge(appl(U,V),drs([],[appl(pas_de,V)])))))),appl(lambda(W,lambda(X,merge(merge(drs([variable(Y)],[]),appl(W,Y)),appl(X,Y)))),lambda(Z,drs([],[appl(bleu,Z)])))))),appl(lambda(J,lambda(K,merge(merge(drs([variable(L)],[bool(num(L),>,1)]),appl(J,L)),appl(K,L)))),lambda(M,drs([],[appl(homme,M)]))))))).

% = Reduced Semantics

semantics(374, reduced, drs([event(A),variable(B),variable(C)],[bool(num(B),>,1),appl(homme,B),appl(bleu,C),appl(appl(appl(porter,C),B),A),bool(appl(temps,A),overlaps,maintenant),appl(pas_de,C)])).


% = Semantics

semantics(380, unreduced, appl(lambda(I,I),appl(lambda(C1,merge(drs([event(D1)],[]),appl(C1,D1))),appl(appl(lambda(T,lambda(U,lambda(V,appl(U,lambda(W,appl(T,lambda(X,drs([],[appl(appl(appl(porter,X),W),V),bool(appl(temps,V),overlaps,maintenant)])))))))),appl(lambda(Y,lambda(Z,merge(merge(drs([variable(A1)],[]),appl(Y,A1)),appl(Z,A1)))),lambda(B1,drs([],[appl(bleu,B1)])))),appl(lambda(J,lambda(K,presup(merge(drs([variable(L)],[]),appl(J,L)),appl(K,L)))),appl(lambda(M,lambda(N,appl(M,lambda(O,drs([],[appl(plupart_de,O)]))))),appl(lambda(P,lambda(Q,presup(merge(drs([variable(R)],[bool(num(R),>,1)]),appl(P,R)),appl(Q,R)))),lambda(S,drs([],[appl(homme,S)]))))))))).

% = Reduced Semantics

semantics(380, reduced, presup(drs([variable(C),variable(B)],[bool(num(C),>,1),appl(homme,C),appl(plupart_de,C)]),drs([event(A),variable(D)],[appl(bleu,D),appl(appl(appl(porter,D),B),A),bool(appl(temps,A),overlaps,maintenant)]))).


% = Semantics

semantics(382, unreduced, appl(lambda(J,J),appl(lambda(Z,merge(drs([event(A1)],[]),appl(Z,A1))),appl(appl(lambda(P,lambda(Q,lambda(R,appl(Q,lambda(S,appl(P,lambda(T,drs([],[appl(appl(appl(porter,T),S),R),bool(appl(temps,R),overlaps,maintenant)])))))))),appl(lambda(U,U),appl(lambda(V,lambda(W,presup(merge(drs([variable(X)],[]),appl(V,X)),appl(W,X)))),lambda(Y,drs([],[appl(orange,Y)]))))),appl(appl(au,lambda(K,drs([],[appl(moins,K)]))),appl(lambda(L,lambda(M,merge(merge(drs([variable(N)],[bool(num(N),=,2)]),appl(L,N)),appl(M,N)))),lambda(O,drs([],[appl(homme,O)])))))))).

% = Reduced Semantics

semantics(382, reduced, merge(drs([event(A)],[]),appl(appl(appl(au,lambda(B,drs([],[appl(moins,B)]))),lambda(C,merge(merge(drs([variable(D)],[bool(num(D),=,2)]),drs([],[appl(homme,D)])),appl(C,D)))),lambda(E,presup(merge(drs([variable(F)],[]),drs([],[appl(orange,F)])),drs([],[appl(appl(appl(porter,F),E),A),bool(appl(temps,A),overlaps,maintenant)])))))).


% = Semantics

semantics(402, unreduced, appl(lambda(F,F),appl(lambda(Q,merge(drs([event(R)],[]),appl(Q,R))),appl(appl(lambda(M,lambda(N,lambda(O,appl(N,lambda(P,drs([],[appl(appl('s\'asseoir',P),O),bool(appl(temps,O),overlaps,maintenant)])))))),lambda(K,appl(K,L))),appl(lambda(G,lambda(H,merge(merge(drs([variable(I)],[bool(num(I),>,1)]),appl(G,I)),appl(H,I)))),lambda(J,drs([],[appl(ours,J)]))))))).

% = Reduced Semantics

semantics(402, reduced, drs([event(A),variable(B)],[bool(num(B),>,1),appl(ours,B),appl(appl('s\'asseoir',B),A),bool(appl(temps,A),overlaps,maintenant)])).


% = Semantics

semantics(404, unreduced, appl(lambda(G,G),appl(lambda(R,merge(drs([event(S)],[]),appl(R,S))),appl(lambda(P,lambda(Q,drs([],[not(appl(P,Q))]))),appl(appl(lambda(L,L),lambda(M,lambda(N,appl(M,lambda(O,drs([],[appl(appl(courir,O),N),bool(appl(temps,N),overlaps,maintenant)])))))),appl(lambda(H,lambda(I,merge(merge(drs([variable(J)],[bool(num(J),>,1)]),appl(H,J)),appl(I,J)))),lambda(K,drs([],[appl(ours,K)])))))))).

% = Reduced Semantics

semantics(404, reduced, drs([event(A)],[not(drs([variable(B)],[bool(num(B),>,1),appl(ours,B),appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant)]))])).


% = Semantics

semantics(406, unreduced, appl(lambda(E,E),appl(lambda(M,merge(drs([event(N)],[]),appl(M,N))),appl(lambda(J,lambda(K,appl(J,lambda(L,drs([],[appl(appl(court,L),K)]))))),appl(lambda(F,lambda(G,drs([],[bool(merge(drs([variable(H)],[]),appl(F,H)),->,appl(G,H))]))),lambda(I,drs([],[appl(ours,I)]))))))).

% = Reduced Semantics

semantics(406, reduced, drs([event(A)],[bool(drs([variable(B)],[appl(ours,B)]),->,drs([],[appl(appl(court,B),A)]))])).


% = Semantics

semantics(408, unreduced, appl(lambda(H,H),appl(lambda(X,merge(drs([event(Y)],[]),appl(X,Y))),appl(appl(lambda(Q,lambda(R,lambda(S,presup(drs([],[bool(appl(temps,S),overlaps,maintenant)]),appl(appl(Q,R),S))))),lambda(T,lambda(U,appl(T,lambda(V,drs([variable(W)],[bool(W,=,'context?'),appl(appl(appl(asseoir,V),W),U)])))))),appl(lambda(I,lambda(J,appl(I,lambda(K,merge(appl(J,K),drs([],[appl(plus_de,K)])))))),appl(lambda(L,L),appl(lambda(M,lambda(N,merge(merge(drs([variable(O)],[]),appl(M,O)),appl(N,O)))),lambda(P,drs([],[appl(ours,P)]))))))))).

% = Reduced Semantics

semantics(408, reduced, presup(drs([],[bool(appl(temps,A),overlaps,maintenant)]),drs([event(A),variable(B),variable(C)],[appl(ours,B),bool(C,=,'context?'),appl(appl(appl(asseoir,B),C),A),appl(plus_de,B)]))).


% = Semantics

semantics(410, unreduced, appl(lambda(F,F),appl(lambda(Q,merge(drs([event(R)],[]),appl(Q,R))),appl(lambda(N,lambda(O,appl(N,lambda(P,drs([],[appl(appl(courir,P),O),bool(appl(temps,O),overlaps,maintenant)]))))),appl(lambda(G,lambda(H,appl(G,lambda(I,merge(appl(H,I),drs([],[appl(tout,I)])))))),appl(lambda(J,lambda(K,presup(merge(drs([variable(L)],[bool(num(L),>,1)]),appl(J,L)),appl(K,L)))),lambda(M,drs([],[appl(ours,M)])))))))).

% = Reduced Semantics

semantics(410, reduced, presup(drs([variable(B)],[bool(num(B),>,1),appl(ours,B)]),drs([event(A)],[appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant),appl(tout,B)]))).


% = Semantics

semantics(412, unreduced, appl(lambda(G,G),appl(lambda(S,merge(drs([event(T)],[]),appl(S,T))),appl(lambda(P,lambda(Q,appl(P,lambda(R,drs([],[appl(appl(courir,R),Q),bool(appl(temps,Q),overlaps,maintenant)]))))),appl(lambda(H,lambda(I,appl(H,lambda(J,merge(appl(I,J),drs([],[appl(plus_de,J)])))))),appl(lambda(K,K),appl(lambda(L,lambda(M,merge(merge(drs([variable(N)],[bool(num(N),=,2)]),appl(L,N)),appl(M,N)))),lambda(O,drs([],[appl(ours,O)]))))))))).

% = Reduced Semantics

semantics(412, reduced, drs([event(A),variable(B)],[bool(num(B),=,2),appl(ours,B),appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant),appl(plus_de,B)])).


% = Semantics

semantics(414, unreduced, appl(lambda(H,H),appl(lambda(X,merge(drs([event(Y)],[]),appl(X,Y))),appl(appl(lambda(Q,lambda(R,lambda(S,presup(drs([],[bool(appl(temps,S),overlaps,maintenant)]),appl(appl(Q,R),S))))),lambda(T,lambda(U,appl(T,lambda(V,drs([variable(W)],[bool(W,=,'context?'),appl(appl(appl(asseoir,V),W),U)])))))),appl(lambda(I,lambda(J,appl(I,lambda(K,merge(appl(J,K),drs([],[appl(plus_de,K)])))))),appl(lambda(L,L),appl(lambda(M,lambda(N,merge(merge(drs([variable(O)],[bool(num(O),=,4)]),appl(M,O)),appl(N,O)))),lambda(P,drs([],[appl(ours,P)]))))))))).

% = Reduced Semantics

semantics(414, reduced, presup(drs([],[bool(appl(temps,A),overlaps,maintenant)]),drs([event(A),variable(B),variable(C)],[bool(num(B),=,4),appl(ours,B),bool(C,=,'context?'),appl(appl(appl(asseoir,B),C),A),appl(plus_de,B)]))).


% = Semantics

semantics(416, unreduced, appl(lambda(J,J),appl(lambda(B1,merge(drs([event(C1)],[]),appl(B1,C1))),appl(lambda(Z,lambda(A1,drs([],[not(appl(Z,A1))]))),appl(appl(lambda(S,S),appl(lambda(V,lambda(W,lambda(X,appl(W,lambda(Y,drs([],[appl(appl('s\'asseoir',Y),X),bool(appl(temps,X),overlaps,maintenant)])))))),lambda(T,appl(T,U)))),appl(lambda(K,lambda(L,appl(K,lambda(M,merge(appl(L,M),drs([],[appl(plus_de,M)])))))),appl(lambda(N,N),appl(lambda(O,lambda(P,merge(merge(drs([variable(Q)],[bool(num(Q),=,3)]),appl(O,Q)),appl(P,Q)))),lambda(R,drs([],[appl(ours,R)])))))))))).

% = Reduced Semantics

semantics(416, reduced, drs([event(A)],[not(drs([variable(B)],[bool(num(B),=,3),appl(ours,B),appl(appl('s\'asseoir',B),A),bool(appl(temps,A),overlaps,maintenant),appl(plus_de,B)]))])).


% = Semantics

semantics(418, unreduced, appl(lambda(G,G),appl(lambda(S,merge(drs([event(T)],[]),appl(S,T))),appl(lambda(P,lambda(Q,appl(P,lambda(R,drs([],[appl(appl(courir,R),Q),bool(appl(temps,Q),overlaps,maintenant)]))))),appl(lambda(H,lambda(I,appl(H,lambda(J,merge(appl(I,J),drs([],[appl(moins_de,J)])))))),appl(lambda(K,K),appl(lambda(L,lambda(M,merge(merge(drs([variable(N)],[bool(num(N),=,6)]),appl(L,N)),appl(M,N)))),lambda(O,drs([],[appl(ours,O)]))))))))).

% = Reduced Semantics

semantics(418, reduced, drs([event(A),variable(B)],[bool(num(B),=,6),appl(ours,B),appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant),appl(moins_de,B)])).


% = Semantics

semantics(420, unreduced, appl(lambda(F,F),appl(lambda(R,merge(drs([event(S)],[]),appl(R,S))),appl(appl(lambda(K,lambda(L,lambda(M,presup(drs([],[bool(appl(temps,M),overlaps,maintenant)]),appl(appl(K,L),M))))),lambda(N,lambda(O,appl(N,lambda(P,drs([variable(Q)],[bool(Q,=,'context?'),appl(appl(appl(asseoir,P),Q),O)])))))),appl(lambda(G,lambda(H,merge(merge(drs([variable(I)],[]),appl(G,I)),appl(H,I)))),lambda(J,drs([],[appl(ours,J)]))))))).

% = Reduced Semantics

semantics(420, reduced, presup(drs([],[bool(appl(temps,A),overlaps,maintenant)]),drs([event(A),variable(B),variable(C)],[appl(ours,B),bool(C,=,'context?'),appl(appl(appl(asseoir,B),C),A)]))).


% = Semantics

semantics(422, unreduced, appl(lambda(E,E),appl(lambda(M,merge(drs([event(N)],[]),appl(M,N))),appl(lambda(J,lambda(K,appl(J,lambda(L,drs([],[appl(appl(courir,L),K),bool(appl(temps,K),overlaps,maintenant)]))))),appl(lambda(F,lambda(G,merge(merge(drs([variable(H)],[bool(num(H),=,3)]),appl(F,H)),appl(G,H)))),lambda(I,drs([],[appl(ours,I)]))))))).

% = Reduced Semantics

semantics(422, reduced, drs([event(A),variable(B)],[bool(num(B),=,3),appl(ours,B),appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant)])).


% = Semantics

semantics(430, unreduced, appl(lambda(F,F),appl(lambda(O,appl(O,lambda(P,drs([],[])))),appl(lambda(G,lambda(H,merge(merge(drs([variable(I)],[]),appl(G,I)),appl(H,I)))),appl(lambda(M,lambda(N,merge(drs([],[appl(court,N)]),appl(M,N)))),appl(lambda(K,lambda(L,merge(drs([],[appl(beige,L)]),appl(K,L)))),lambda(J,drs([],[appl(ours,J)])))))))).

% = Reduced Semantics

semantics(430, reduced, drs([variable(A)],[appl(court,A),appl(beige,A),appl(ours,A)])).


% = Semantics

semantics(432, unreduced, appl(lambda(G,G),appl(lambda(T,merge(drs([event(U)],[]),appl(T,U))),appl(lambda(Q,lambda(R,appl(Q,lambda(S,drs([],[appl(appl(courir,S),R),bool(appl(temps,R),overlaps,maintenant)]))))),appl(lambda(H,lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,60)]),appl(H,J)),appl(I,J)))),appl(appl(lambda(L,lambda(M,lambda(N,presup(merge(drs([variable(O)],[bool(num(O),>,1)]),appl(L,O)),merge(appl(M,N),drs([],[appl(appl(de,O),N)])))))),lambda(P,drs([],[appl(ours,P)]))),lambda(K,drs([],[appl('%',K)])))))))).

% = Reduced Semantics

semantics(432, reduced, presup(drs([variable(C)],[bool(num(C),>,1),appl(ours,C)]),drs([event(A),variable(B)],[bool(num(B),=,60),appl('%',B),appl(appl(de,C),B),appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant)]))).


% = Semantics

semantics(434, unreduced, appl(lambda(H,H),appl(lambda(Y,merge(drs([event(Z)],[]),appl(Y,Z))),appl(appl(lambda(R,lambda(S,lambda(T,presup(drs([],[bool(appl(temps,T),overlaps,maintenant)]),appl(appl(R,S),T))))),lambda(U,lambda(V,appl(U,lambda(W,drs([variable(X)],[bool(X,=,'context?'),appl(appl(appl(asseoir,W),X),V)])))))),appl(lambda(I,lambda(J,merge(merge(drs([variable(K)],[bool(num(K),=,40)]),appl(I,K)),appl(J,K)))),appl(appl(lambda(M,lambda(N,lambda(O,presup(merge(drs([variable(P)],[bool(num(P),>,1)]),appl(M,P)),merge(appl(N,O),drs([],[appl(appl(de,P),O)])))))),lambda(Q,drs([],[appl(ours,Q)]))),lambda(L,drs([],[appl('%',L)])))))))).

% = Reduced Semantics

semantics(434, reduced, presup(drs([variable(C)],[bool(appl(temps,A),overlaps,maintenant),bool(num(C),>,1),appl(ours,C)]),drs([event(A),variable(B),variable(D)],[bool(num(B),=,40),appl('%',B),appl(appl(de,C),B),bool(D,=,'context?'),appl(appl(appl(asseoir,B),D),A)]))).


% = Semantics

semantics(436, unreduced, appl(lambda(I,I),appl(lambda(Z,merge(drs([event(A1)],[]),appl(Z,A1))),appl(lambda(W,lambda(X,appl(W,lambda(Y,drs([],[appl(appl(courir,Y),X),bool(appl(temps,X),overlaps,maintenant)]))))),appl(lambda(J,lambda(K,appl(J,lambda(L,merge(appl(K,L),drs([],[appl(plus_de,L)])))))),appl(lambda(M,M),appl(lambda(N,lambda(O,merge(merge(drs([variable(P)],[bool(num(P),=,40)]),appl(N,P)),appl(O,P)))),appl(appl(lambda(R,lambda(S,lambda(T,presup(merge(drs([variable(U)],[bool(num(U),>,1)]),appl(R,U)),merge(appl(S,T),drs([],[appl(appl(de,U),T)])))))),lambda(V,drs([],[appl(ours,V)]))),lambda(Q,drs([],[appl('%',Q)])))))))))).

% = Reduced Semantics

semantics(436, reduced, presup(drs([variable(C)],[bool(num(C),>,1),appl(ours,C)]),drs([event(A),variable(B)],[bool(num(B),=,40),appl('%',B),appl(appl(de,C),B),appl(appl(courir,B),A),bool(appl(temps,A),overlaps,maintenant),appl(plus_de,B)]))).


% = Semantics

semantics(438, unreduced, appl(lambda(K,K),appl(lambda(I1,merge(drs([event(J1)],[]),appl(I1,J1))),appl(appl(lambda(E1,lambda(F1,lambda(G1,appl(F1,lambda(H1,drs([],[appl(appl(appl(poursuivre,H1),H1),G1),bool(appl(temps,G1),overlaps,maintenant)])))))),lambda(C1,appl(C1,D1))),appl(appl(lambda(R,lambda(S,lambda(T,merge(appl(S,lambda(U,appl(T,U))),appl(R,lambda(V,appl(T,V))))))),appl(lambda(W,lambda(X,merge(merge(drs([variable(Y)],[]),appl(W,Y)),appl(X,Y)))),appl(lambda(A1,lambda(B1,merge(drs([],[appl(beige,B1)]),appl(A1,B1)))),lambda(Z,drs([],[appl(ours,Z)]))))),appl(lambda(L,lambda(M,merge(merge(drs([variable(N)],[]),appl(L,N)),appl(M,N)))),appl(lambda(P,lambda(Q,merge(drs([],[appl(brun,Q)]),appl(P,Q)))),lambda(O,drs([],[appl(ours,O)]))))))))).

% = Reduced Semantics

semantics(438, reduced, drs([event(A),variable(B),variable(C)],[appl(brun,B),appl(ours,B),appl(appl(appl(poursuivre,B),B),A),bool(appl(temps,A),overlaps,maintenant),appl(beige,C),appl(ours,C),appl(appl(appl(poursuivre,C),C),A)])).


% = Semantics

semantics(440, unreduced, appl(lambda(G,G),appl(lambda(T,merge(drs([event(U)],[]),appl(T,U))),appl(appl(lambda(P,lambda(Q,lambda(R,appl(Q,lambda(S,drs([],[appl(appl(appl(poursuivre,S),S),R),bool(appl(temps,R),overlaps,maintenant)])))))),lambda(N,appl(N,O))),appl(lambda(H,lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,2)]),appl(H,J)),appl(I,J)))),appl(lambda(L,lambda(M,merge(drs([],[appl(beige,M)]),appl(L,M)))),lambda(K,drs([],[appl(ours,K)])))))))).

% = Reduced Semantics

semantics(440, reduced, drs([event(A),variable(B)],[bool(num(B),=,2),appl(beige,B),appl(ours,B),appl(appl(appl(poursuivre,B),B),A),bool(appl(temps,A),overlaps,maintenant)])).


% = Semantics

semantics(502, unreduced, appl(lambda(O,O),appl(lambda(A2,merge(drs([event(B2)],[]),appl(A2,B2))),appl(appl(lambda(N1,lambda(O1,lambda(P1,presup(merge(drs([variable(Q1)],[]),appl(N1,Q1)),merge(appl(O1,P1),drs([],[appl(appl(à,Q1),P1)])))))),appl(appl(lambda(S1,lambda(T1,lambda(U1,merge(appl(T1,U1),appl(S1,lambda(V1,drs([],[appl(appl(de,V1),U1)]))))))),appl(lambda(W1,lambda(X1,merge(merge(drs([variable(Y1)],[]),appl(W1,Y1)),appl(X1,Y1)))),lambda(Z1,drs([],[appl(montagne,Z1)])))),lambda(R1,drs([],[appl(sommet,R1)])))),appl(appl(lambda(F1,lambda(G1,lambda(H1,appl(G1,lambda(I1,presup(drs([],[bool(appl(temps,H1),overlaps,maintenant)]),merge(drs([variable(J1)],[bool(I1,is_at(H1),J1)]),appl(appl(F1,lambda(K1,drs([],[]))),J1)))))))),lambda(L1,lambda(M1,merge(drs([],[appl(debout,M1)]),appl(L1,M1))))),appl(lambda(P,lambda(Q,merge(merge(drs([variable(R)],[bool(num(R),=,6)]),appl(P,R)),appl(Q,R)))),appl(appl(lambda(T,lambda(U,lambda(V,merge(appl(T,lambda(W,drs([event(X),variable(Y)],[appl(generic,Y),appl(appl(appl(appl(porter,W),V),Y),X)]))),appl(U,V))))),appl(lambda(Z,lambda(A1,merge(merge(drs([variable(B1)],[bool(num(B1),>,1)]),appl(Z,B1)),appl(A1,B1)))),appl(lambda(C1,lambda(D1,merge(drs([],[appl(haut,D1)]),appl(C1,D1)))),lambda(E1,drs([],[appl(beige,E1)]))))),lambda(S,drs([],[appl(enfant,S)]))))))))).

% = Reduced Semantics

semantics(502, reduced, presup(drs([variable(B),variable(C)],[appl(sommet,B),appl(montagne,C),appl(appl(de,C),B),bool(appl(temps,A),overlaps,maintenant)]),drs([event(A),variable(D),variable(E),event(F),variable(G),variable(H)],[bool(num(D),=,6),bool(num(E),>,1),appl(haut,E),appl(beige,E),appl(generic,G),appl(appl(appl(appl(porter,E),D),G),F),appl(enfant,D),bool(D,is_at(A),H),appl(debout,H),appl(appl(à,B),A)]))).


% = Semantics

semantics(508, unreduced, appl(lambda(H,H),appl(lambda(X,merge(drs([event(Y)],[]),appl(X,Y))),appl(appl(lambda(M,lambda(N,lambda(O,appl(N,lambda(P,appl(M,lambda(Q,drs([],[appl(appl(appl(porter,Q),P),O),bool(appl(temps,O),overlaps,maintenant)])))))))),appl(lambda(R,lambda(S,merge(merge(drs([variable(T)],[bool(num(T),>,1)]),appl(R,T)),appl(S,T)))),appl(lambda(U,lambda(V,merge(drs([],[appl(haut,V)]),appl(U,V)))),lambda(W,drs([],[appl(beige,W)]))))),appl(lambda(I,lambda(J,merge(merge(drs([variable(K)],[bool(num(K),=,4)]),appl(I,K)),appl(J,K)))),lambda(L,drs([],[appl(enfant,L)]))))))).

% = Reduced Semantics

semantics(508, reduced, drs([event(A),variable(B),variable(C)],[bool(num(B),=,4),appl(enfant,B),bool(num(C),>,1),appl(haut,C),appl(beige,C),appl(appl(appl(porter,C),B),A),bool(appl(temps,A),overlaps,maintenant)])).


% = Semantics

semantics(512, unreduced, appl(lambda(H,H),appl(lambda(Y,merge(drs([event(Z)],[]),appl(Y,Z))),appl(appl(lambda(P,lambda(Q,lambda(R,appl(Q,lambda(S,appl(P,lambda(T,drs([],[appl(appl(appl(porter,T),S),R),bool(appl(temps,R),overlaps,maintenant)])))))))),appl(lambda(U,lambda(V,merge(merge(drs([variable(W)],[bool(num(W),>,1)]),appl(U,W)),appl(V,W)))),lambda(X,drs([],[appl(top,X)])))),appl(lambda(I,lambda(J,appl(I,lambda(K,merge(appl(J,K),drs([],[appl(tout,K)])))))),appl(lambda(L,lambda(M,presup(merge(drs([variable(N)],[bool(num(N),>,1)]),appl(L,N)),appl(M,N)))),lambda(O,drs([],[appl(enfant,O)])))))))).

% = Reduced Semantics

semantics(512, reduced, presup(drs([variable(B)],[bool(num(B),>,1),appl(enfant,B)]),drs([event(A),variable(C)],[bool(num(C),>,1),appl(top,C),appl(appl(appl(porter,C),B),A),bool(appl(temps,A),overlaps,maintenant),appl(tout,B)]))).


% = Semantics

semantics(516, unreduced, appl(lambda(J,J),appl(lambda(D1,merge(drs([event(E1)],[]),appl(D1,E1))),appl(appl(lambda(S,lambda(T,lambda(U,appl(T,lambda(V,appl(S,lambda(W,drs([],[appl(appl(appl(porter,W),V),U),bool(appl(temps,U),overlaps,maintenant)])))))))),appl(lambda(X,lambda(Y,merge(merge(drs([variable(Z)],[bool(num(Z),>,1)]),appl(X,Z)),appl(Y,Z)))),appl(lambda(A1,lambda(B1,merge(drs([],[appl(haut,B1)]),appl(A1,B1)))),lambda(C1,drs([],[appl(beige,C1)]))))),appl(lambda(K,lambda(L,appl(K,lambda(M,merge(appl(L,M),drs([],[appl(moins_de,M)])))))),appl(lambda(N,N),appl(lambda(O,lambda(P,merge(merge(drs([variable(Q)],[bool(num(Q),=,5)]),appl(O,Q)),appl(P,Q)))),lambda(R,drs([],[appl(enfant,R)]))))))))).

% = Reduced Semantics

semantics(516, reduced, drs([event(A),variable(B),variable(C)],[bool(num(B),=,5),appl(enfant,B),bool(num(C),>,1),appl(haut,C),appl(beige,C),appl(appl(appl(porter,C),B),A),bool(appl(temps,A),overlaps,maintenant),appl(moins_de,B)])).


% = Semantics

semantics(524, unreduced, appl(lambda(H,H),appl(lambda(X,merge(drs([event(Y)],[]),appl(X,Y))),appl(appl(lambda(M,lambda(N,lambda(O,appl(N,lambda(P,appl(M,lambda(Q,drs([],[appl(appl(appl(avoir,Q),P),O),bool(appl(temps,O),overlaps,maintenant)])))))))),appl(lambda(R,lambda(S,presup(merge(drs([variable(T)],[bool(num(T),>,1)]),appl(R,T)),appl(S,T)))),appl(lambda(V,lambda(W,merge(drs([],[appl(beige,W)]),appl(V,W)))),lambda(U,drs([],[appl(cheveu,U)]))))),appl(lambda(I,lambda(J,merge(merge(drs([variable(K)],[bool(num(K),>,1)]),appl(I,K)),appl(J,K)))),lambda(L,drs([],[appl(enfant,L)]))))))).

% = Reduced Semantics

semantics(524, reduced, presup(drs([variable(C)],[bool(num(C),>,1),appl(beige,C),appl(cheveu,C)]),drs([event(A),variable(B)],[bool(num(B),>,1),appl(enfant,B),appl(appl(appl(avoir,C),B),A),bool(appl(temps,A),overlaps,maintenant)]))).


% = Semantics

semantics(526, unreduced, appl(lambda(H,H),appl(lambda(Y,merge(drs([event(Z)],[]),appl(Y,Z))),appl(appl(lambda(Q,lambda(R,lambda(S,appl(R,lambda(T,presup(drs([],[bool(appl(temps,S),overlaps,maintenant)]),merge(drs([variable(U)],[bool(T,is_at(S),U)]),appl(appl(Q,lambda(V,drs([],[]))),U)))))))),lambda(W,lambda(X,merge(drs([],[appl(allemand,X)]),appl(W,X))))),appl(lambda(I,lambda(J,appl(I,lambda(K,merge(appl(J,K),drs([],[appl(plus_de,K)])))))),appl(lambda(L,L),appl(lambda(M,lambda(N,merge(merge(drs([variable(O)],[bool(num(O),=,4)]),appl(M,O)),appl(N,O)))),lambda(P,drs([],[appl(chanteur,P)]))))))))).

% = Reduced Semantics

semantics(526, reduced, presup(drs([],[bool(appl(temps,A),overlaps,maintenant)]),drs([event(A),variable(B),variable(C)],[bool(num(B),=,4),appl(chanteur,B),bool(B,is_at(A),C),appl(allemand,C),appl(plus_de,B)]))).


% = Semantics

semantics(528, unreduced, appl(lambda(I,I),appl(lambda(C1,merge(drs([event(D1)],[]),appl(C1,D1))),appl(appl(lambda(U,lambda(V,lambda(W,appl(V,lambda(X,presup(drs([],[bool(appl(temps,W),overlaps,maintenant)]),merge(drs([variable(Y)],[bool(X,is_at(W),Y)]),appl(appl(U,lambda(Z,drs([],[]))),Y)))))))),lambda(A1,lambda(B1,merge(drs([],[appl(allemand,B1)]),appl(A1,B1))))),appl(lambda(J,lambda(K,presup(merge(drs([variable(L)],[bool(num(L),>,1)]),appl(J,L)),appl(K,L)))),appl(appl(lambda(P,lambda(Q,lambda(R,presup(merge(drs([variable(S)],[bool(num(S),>,1)]),appl(P,S)),merge(appl(Q,R),drs([],[appl(appl(de,S),R)])))))),lambda(T,drs([],[appl(chanteur,T)]))),appl(lambda(M,lambda(N,merge(drs([],[bool(num(N),=,2)]),appl(M,N)))),lambda(O,drs([],[appl(tiers,O)]))))))))).

% = Reduced Semantics

semantics(528, reduced, presup(drs([variable(C),variable(B)],[bool(num(C),>,1),appl(chanteur,C),bool(num(B),>,1),bool(num(B),=,2),appl(tiers,B),appl(appl(de,C),B),bool(appl(temps,A),overlaps,maintenant)]),drs([event(A),variable(D)],[bool(B,is_at(A),D),appl(allemand,D)]))).


% = Semantics

semantics(530, unreduced, appl(lambda(G,G),appl(lambda(U,merge(drs([event(V)],[]),appl(U,V))),appl(appl(lambda(L,lambda(M,lambda(N,appl(M,lambda(O,appl(L,lambda(P,drs([],[appl(appl(appl(venir_de,P),O),N),bool(appl(temps,N),overlaps,maintenant)])))))))),appl(lambda(Q,lambda(R,merge(merge(drs([variable(S)],[]),appl(Q,S)),appl(R,S)))),lambda(T,presup(drs([],[appl(appl(nommé,'Allemagne'),T)]),drs([],[]))))),appl(lambda(H,lambda(I,merge(merge(drs([variable(J)],[bool(num(J),=,2)]),appl(H,J)),appl(I,J)))),lambda(K,drs([],[appl(chanteur,K)]))))))).

% = Reduced Semantics

semantics(530, reduced, presup(drs([],[appl(appl(nommé,'Allemagne'),C)]),drs([event(A),variable(B),variable(C)],[bool(num(B),=,2),appl(chanteur,B),appl(appl(appl(venir_de,C),B),A),bool(appl(temps,A),overlaps,maintenant)]))).


% = Semantics

semantics(532, unreduced, appl(lambda(I,I),appl(lambda(C1,merge(drs([event(D1)],[]),appl(C1,D1))),appl(appl(lambda(T,lambda(U,lambda(V,appl(U,lambda(W,appl(T,lambda(X,drs([],[appl(appl(appl(venir_de,X),W),V),bool(appl(temps,V),overlaps,maintenant)])))))))),appl(lambda(Y,lambda(Z,merge(merge(drs([variable(A1)],[]),appl(Y,A1)),appl(Z,A1)))),lambda(B1,presup(drs([],[appl(appl(nommé,'Allemagne'),B1)]),drs([],[]))))),appl(lambda(J,lambda(K,presup(merge(drs([variable(L)],[]),appl(J,L)),appl(K,L)))),appl(lambda(M,lambda(N,appl(M,lambda(O,drs([],[appl(plupart_de,O)]))))),appl(lambda(P,lambda(Q,presup(merge(drs([variable(R)],[bool(num(R),>,1)]),appl(P,R)),appl(Q,R)))),lambda(S,drs([],[appl(chanteur,S)]))))))))).

% = Reduced Semantics

semantics(532, reduced, presup(drs([variable(C),variable(B)],[bool(num(C),>,1),appl(chanteur,C),appl(plupart_de,C),appl(appl(nommé,'Allemagne'),D)]),drs([event(A),variable(D)],[appl(appl(appl(venir_de,D),B),A),bool(appl(temps,A),overlaps,maintenant)]))).


% = Semantics

semantics(534, unreduced, appl(lambda(I,I),appl(lambda(Z,merge(drs([event(A1)],[]),appl(Z,A1))),appl(appl(lambda(N,N),lambda(A,appl(lambda(T,lambda(U,drs([],[not(appl(T,U))]))),appl(appl(lambda(O,lambda(P,lambda(Q,appl(P,lambda(R,appl(O,lambda(S,drs([],[appl(appl(appl(venir_de,S),R),Q),bool(appl(temps,Q),overlaps,maintenant)])))))))),appl(lambda(V,lambda(W,merge(merge(drs([variable(X)],[]),appl(V,X)),appl(W,X)))),lambda(Y,presup(drs([],[appl(appl(nommé,'Chili'),Y)]),drs([],[]))))),A)))),appl(lambda(J,lambda(K,merge(merge(drs([variable(L)],[bool(num(L),>,1)]),appl(J,L)),appl(K,L)))),lambda(M,drs([],[appl(chanteur,M)]))))))).

% = Reduced Semantics

semantics(534, reduced, presup(drs([],[appl(appl(nommé,'Chili'),C)]),drs([event(A)],[not(drs([variable(B),variable(C)],[bool(num(B),>,1),appl(chanteur,B),appl(appl(appl(venir_de,C),B),A),bool(appl(temps,A),overlaps,maintenant)]))]))).


% = Semantics

semantics(560, unreduced, appl(lambda(L,L),appl(lambda(K1,merge(drs([event(L1)],[]),appl(K1,L1))),appl(appl(lambda(A1,lambda(B1,lambda(C1,appl(B1,lambda(D1,appl(A1,lambda(E1,drs([],[appl(appl(appl(vivre_dans,E1),D1),C1),bool(appl(temps,C1),overlaps,maintenant)])))))))),appl(lambda(F1,F1),appl(lambda(G1,lambda(H1,presup(merge(drs([variable(I1)],[]),appl(G1,I1)),appl(H1,I1)))),lambda(J1,drs([],[appl(richesse,J1)]))))),appl(lambda(M,lambda(N,merge(merge(drs([variable(O)],[bool(num(O),=,36)]),appl(M,O)),appl(N,O)))),appl(lambda(Y,lambda(Z,merge(drs([],[appl(australien,Z)]),appl(Y,Z)))),appl(appl(lambda(Q,lambda(R,lambda(S,merge(appl(R,S),appl(Q,lambda(T,drs([],[appl(appl(de,T),S)]))))))),appl(lambda(U,lambda(V,presup(merge(drs([variable(W)],[]),appl(U,W)),appl(V,W)))),lambda(X,drs([],[appl(population,X)])))),lambda(P,drs([],[appl('%',P)]))))))))).

% = Reduced Semantics

semantics(560, reduced, presup(drs([variable(C),variable(D)],[appl(population,C),appl(richesse,D)]),drs([event(A),variable(B)],[bool(num(B),=,36),appl(australien,B),appl('%',B),appl(appl(de,C),B),appl(appl(appl(vivre_dans,D),B),A),bool(appl(temps,A),overlaps,maintenant)]))).


% = Semantics

semantics(562, unreduced, appl(lambda(M,M),appl(lambda(E1,merge(drs([event(F1)],[]),appl(E1,F1))),appl(appl(lambda(Z,lambda(A1,lambda(B1,merge(merge(drs([variable(C1)],[appl(appl(en,C1),B1)]),appl(Z,C1)),appl(A1,B1))))),lambda(D1,presup(drs([],[appl(appl(nommé,'Ouzbékistan'),D1)]),drs([],[])))),appl(appl(appl(avoir,appl(appl(plus,appl(lambda(R,lambda(S,merge(merge(drs([variable(T)],[]),appl(R,T)),appl(S,T)))),lambda(U,drs([],[appl(femme,U)])))),appl(que,appl(lambda(V,lambda(W,merge(merge(drs([variable(X)],[]),appl(V,X)),appl(W,X)))),lambda(Y,drs([],[appl(homme,Y)])))))),lambda(P,merge(drs([variable(Q)],[bool(Q,=,?)]),appl(P,Q)))),lambda(N,merge(drs([variable(O)],[bool(O,=,'masculin?')]),appl(N,O)))))))).

% = Reduced Semantics

semantics(562, reduced, merge(drs([event(A)],[]),merge(presup(drs([],[appl(appl(nommé,'Ouzbékistan'),B)]),drs([variable(B)],[appl(appl(en,B),A)])),appl(appl(appl(appl(avoir,appl(appl(plus,lambda(C,merge(merge(drs([variable(D)],[]),drs([],[appl(femme,D)])),appl(C,D)))),appl(que,lambda(E,merge(merge(drs([variable(F)],[]),drs([],[appl(homme,F)])),appl(E,F)))))),lambda(G,merge(drs([variable(H)],[bool(H,=,?)]),appl(G,H)))),lambda(I,merge(drs([variable(J)],[bool(J,=,'masculin?')]),appl(I,J)))),A)))).


% = Semantics

semantics(564, unreduced, appl(lambda(P,P),appl('87.',appl(appl(appl(lambda(K1,lambda(L1,lambda(M1,lambda(N1,appl(M1,lambda(O1,appl(K1,lambda(P1,drs([],[appl(appl(appl(se_situer_entre,P1),O1),N1),drs([event(Q1)],[bool(appl(temps,Q1),subseteq,appl(temps,N1)),bool(appl(temps,Q1),<,maintenant)])]))))))))),appl(lambda(R1,R1),appl(appl(lambda(U1,lambda(V1,lambda(W1,merge(appl(V1,lambda(X1,appl(W1,X1))),appl(U1,lambda(Y1,appl(W1,Y1))))))),lambda(Z1,merge(drs([variable(A2)],[appl('.',A2)]),appl(Z1,A2)))),lambda(S1,merge(drs([variable(T1)],[bool(T1,=,86)]),appl(S1,T1)))))),lambda(I1,appl(I1,J1))),appl(lambda(Q,lambda(R,presup(merge(drs([variable(S)],[]),appl(Q,S)),appl(R,S)))),appl(appl(lambda(A1,lambda(B1,lambda(C1,merge(appl(B1,C1),appl(A1,lambda(D1,drs([],[appl(appl(pour,D1),C1)]))))))),appl(lambda(E1,lambda(F1,merge(merge(drs([variable(G1)],[bool(num(G1),=,100)]),appl(E1,G1)),appl(F1,G1)))),lambda(H1,drs([],[appl(femme,H1)])))),appl(appl(lambda(W,lambda(X,lambda(Y,merge(appl(W,Y),appl(X,Y))))),lambda(Z,drs([],[appl(femme,Z)]))),appl(lambda(U,lambda(V,merge(drs([],[appl(homme,V)]),appl(U,V)))),lambda(T,drs([],[appl(ratio,T)])))))))))).

% = Reduced Semantics

semantics(564, reduced, appl('87.',lambda(A,presup(merge(drs([variable(B)],[]),merge(merge(drs([],[appl(femme,B)]),merge(drs([],[appl(homme,B)]),drs([],[appl(ratio,B)]))),merge(merge(drs([variable(C)],[bool(num(C),=,100)]),drs([],[appl(femme,C)])),drs([],[appl(appl(pour,C),B)])))),merge(merge(drs([variable(D)],[bool(D,=,86)]),drs([],[appl(appl(appl(se_situer_entre,D),B),A),drs([event(E)],[bool(appl(temps,E),subseteq,appl(temps,A)),bool(appl(temps,E),<,maintenant)])])),merge(drs([variable(F)],[appl('.',F)]),drs([],[appl(appl(appl(se_situer_entre,F),B),A),drs([event(E)],[bool(appl(temps,E),subseteq,appl(temps,A)),bool(appl(temps,E),<,maintenant)])]))))))).


% = Semantics

semantics(566, unreduced, appl(lambda(N,N),appl(lambda(I1,merge(drs([event(J1)],[]),appl(I1,J1))),appl(appl(lambda(A1,lambda(B1,lambda(C1,merge(appl(A1,lambda(D1,drs([],[appl(appl(dans,D1),C1)]))),appl(B1,C1))))),appl(lambda(E1,lambda(F1,presup(merge(drs([variable(G1)],[]),appl(E1,G1)),appl(F1,G1)))),lambda(H1,drs([],[appl(monde,H1)])))),appl(appl(appl(avoir,appl(appl(plus,appl(lambda(S,lambda(T,merge(merge(drs([variable(U)],[]),appl(S,U)),appl(T,U)))),lambda(V,drs([],[appl(femme,V)])))),appl(que,appl(lambda(W,lambda(X,merge(merge(drs([variable(Y)],[]),appl(W,Y)),appl(X,Y)))),lambda(Z,drs([],[appl(homme,Z)])))))),lambda(Q,merge(drs([variable(R)],[bool(R,=,?)]),appl(Q,R)))),lambda(O,merge(drs([variable(P)],[bool(P,=,'masculin?')]),appl(O,P)))))))).

% = Reduced Semantics

semantics(566, reduced, merge(drs([event(A)],[]),merge(presup(drs([variable(B)],[appl(monde,B)]),drs([],[appl(appl(dans,B),A)])),appl(appl(appl(appl(avoir,appl(appl(plus,lambda(C,merge(merge(drs([variable(D)],[]),drs([],[appl(femme,D)])),appl(C,D)))),appl(que,lambda(E,merge(merge(drs([variable(F)],[]),drs([],[appl(homme,F)])),appl(E,F)))))),lambda(G,merge(drs([variable(H)],[bool(H,=,?)]),appl(G,H)))),lambda(I,merge(drs([variable(J)],[bool(J,=,'masculin?')]),appl(I,J)))),A)))).


% = Semantics

semantics(568, unreduced, appl(lambda(M,M),appl(lambda(E1,merge(drs([event(F1)],[]),appl(E1,F1))),appl(appl(lambda(Z,lambda(A1,lambda(B1,merge(merge(drs([variable(C1)],[appl(appl(en,C1),B1)]),appl(Z,C1)),appl(A1,B1))))),lambda(D1,presup(drs([],[appl(appl(nommé,'Ouzbékistan'),D1)]),drs([],[])))),appl(appl(appl(avoir,appl(appl(plus,appl(lambda(R,lambda(S,merge(merge(drs([variable(T)],[]),appl(R,T)),appl(S,T)))),lambda(U,drs([],[appl(homme,U)])))),appl(que,appl(lambda(V,lambda(W,merge(merge(drs([variable(X)],[]),appl(V,X)),appl(W,X)))),lambda(Y,drs([],[appl(femme,Y)])))))),lambda(P,merge(drs([variable(Q)],[bool(Q,=,?)]),appl(P,Q)))),lambda(N,merge(drs([variable(O)],[bool(O,=,'masculin?')]),appl(N,O)))))))).

% = Reduced Semantics

semantics(568, reduced, merge(drs([event(A)],[]),merge(presup(drs([],[appl(appl(nommé,'Ouzbékistan'),B)]),drs([variable(B)],[appl(appl(en,B),A)])),appl(appl(appl(appl(avoir,appl(appl(plus,lambda(C,merge(merge(drs([variable(D)],[]),drs([],[appl(homme,D)])),appl(C,D)))),appl(que,lambda(E,merge(merge(drs([variable(F)],[]),drs([],[appl(femme,F)])),appl(E,F)))))),lambda(G,merge(drs([variable(H)],[bool(H,=,?)]),appl(G,H)))),lambda(I,merge(drs([variable(J)],[bool(J,=,'masculin?')]),appl(I,J)))),A)))).


% = Semantics

semantics(574, unreduced, appl(lambda(I,I),appl(lambda(A1,merge(drs([event(B1)],[]),appl(A1,B1))),appl(appl(lambda(N,N),appl(lambda(O,lambda(P,lambda(Q,appl(P,lambda(R,appl(O,lambda(S,drs([],[appl(appl(appl(porter,S),R),Q),bool(appl(temps,Q),overlaps,maintenant)])))))))),appl(lambda(T,lambda(U,appl(T,lambda(V,merge(appl(U,V),drs([],[appl(pas_de,V)])))))),appl(lambda(W,lambda(X,merge(merge(drs([variable(Y)],[]),appl(W,Y)),appl(X,Y)))),lambda(Z,drs([],[appl(bleu,Z)])))))),appl(lambda(J,lambda(K,merge(merge(drs([variable(L)],[bool(num(L),>,1)]),appl(J,L)),appl(K,L)))),lambda(M,drs([],[appl(homme,M)]))))))).

% = Reduced Semantics

semantics(574, reduced, drs([event(A),variable(B),variable(C)],[bool(num(B),>,1),appl(homme,B),appl(bleu,C),appl(appl(appl(porter,C),B),A),bool(appl(temps,A),overlaps,maintenant),appl(pas_de,C)])).


% = Semantics

semantics(580, unreduced, appl(lambda(I,I),appl(lambda(C1,merge(drs([event(D1)],[]),appl(C1,D1))),appl(appl(lambda(T,lambda(U,lambda(V,appl(U,lambda(W,appl(T,lambda(X,drs([],[appl(appl(appl(porter,X),W),V),bool(appl(temps,V),overlaps,maintenant)])))))))),appl(lambda(Y,lambda(Z,merge(merge(drs([variable(A1)],[]),appl(Y,A1)),appl(Z,A1)))),lambda(B1,drs([],[appl(bleu,B1)])))),appl(lambda(J,lambda(K,presup(merge(drs([variable(L)],[]),appl(J,L)),appl(K,L)))),appl(lambda(M,lambda(N,appl(M,lambda(O,drs([],[appl(plupart_de,O)]))))),appl(lambda(P,lambda(Q,presup(merge(drs([variable(R)],[bool(num(R),>,1)]),appl(P,R)),appl(Q,R)))),lambda(S,drs([],[appl(homme,S)]))))))))).

% = Reduced Semantics

semantics(580, reduced, presup(drs([variable(C),variable(B)],[bool(num(C),>,1),appl(homme,C),appl(plupart_de,C)]),drs([event(A),variable(D)],[appl(bleu,D),appl(appl(appl(porter,D),B),A),bool(appl(temps,A),overlaps,maintenant)]))).


% = Semantics

semantics(582, unreduced, appl(lambda(I,I),appl(lambda(X,merge(drs([event(Y)],[]),appl(X,Y))),appl(appl(lambda(O,lambda(P,lambda(Q,appl(P,lambda(R,appl(O,lambda(S,drs([],[appl(appl(appl(porter,S),R),Q),bool(appl(temps,Q),overlaps,maintenant)])))))))),appl(lambda(T,lambda(U,merge(merge(drs([variable(V)],[]),appl(T,V)),appl(U,V)))),lambda(W,drs([],[appl(beige,W)])))),appl(appl(au,lambda(J,drs([],[appl(moins,J)]))),appl(lambda(K,lambda(L,merge(merge(drs([variable(M)],[bool(num(M),=,2)]),appl(K,M)),appl(L,M)))),lambda(N,drs([],[appl(homme,N)])))))))).

% = Reduced Semantics

semantics(582, reduced, merge(drs([event(A)],[]),appl(appl(appl(au,lambda(B,drs([],[appl(moins,B)]))),lambda(C,merge(merge(drs([variable(D)],[bool(num(D),=,2)]),drs([],[appl(homme,D)])),appl(C,D)))),lambda(E,merge(merge(drs([variable(F)],[]),drs([],[appl(beige,F)])),drs([],[appl(appl(appl(porter,F),E),A),bool(appl(temps,A),overlaps,maintenant)])))))).

