% 2. Certains chiens sont assis . 

proof(2, rule(dl, p(0,p(0,p(0,'Certains',chiens),p(0,sont,assis)),'.'), lit(txt)-appl(word(4),appl(appl(word(2),word(3)),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Certains',chiens),p(0,sont,assis)), lit(s(main))-appl(appl(word(2),word(3)),appl(word(0),word(1))), [
      rule(dr, p(0,'Certains',chiens), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Certains', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, chiens, lit(n)-word(1), [])
         ]),
      rule(dr, p(0,sont,assis), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),word(3)), [
         rule(axiom, sont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(pass))))-word(2), []),
         rule(axiom, assis, dl(0,lit(np(nom,_,_)),lit(s(pass)))-word(3), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(4), [])
   ])).

% 4. Certains chiens ne courent pas . 

proof(4, rule(dl, p(0,p(1,p(0,p(0,'Certains',chiens),p(0,ne,courent)),pas),'.'), lit(txt)-appl(word(5),appl(word(4),appl(appl(word(2),word(3)),appl(word(0),word(1))))), [
   rule(dl, p(1,p(0,p(0,'Certains',chiens),p(0,ne,courent)),pas), lit(s(main))-appl(word(4),appl(appl(word(2),word(3)),appl(word(0),word(1)))), [
      rule(dl, p(0,p(0,'Certains',chiens),p(0,ne,courent)), lit(s(main))-appl(appl(word(2),word(3)),appl(word(0),word(1))), [
         rule(dr, p(0,'Certains',chiens), lit(np(nom,_,_))-appl(word(0),word(1)), [
            rule(axiom, 'Certains', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
            rule(axiom, chiens, lit(n)-word(1), [])
            ]),
         rule(dr, p(0,ne,courent), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),word(3)), [
            rule(axiom, ne, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(2), []),
            rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(3), [])
            ])
         ]),
      rule(axiom, pas, dl(1,lit(s(main)),lit(s(main)))-word(4), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(5), [])
   ])).

% 6. Tout chien court . 

proof(6, rule(dl, p(0,p(0,p(0,'Tout',chien),court),'.'), lit(txt)-appl(word(3),appl(word(2),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Tout',chien),court), lit(s(main))-appl(word(2),appl(word(0),word(1))), [
      rule(dr, p(0,'Tout',chien), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Tout', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, chien, lit(n)-word(1), [])
         ]),
      rule(axiom, court, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(2), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(3), [])
   ])).

% 8. Plus d' un chien est assis . 

proof(8, rule(dl, p(0,p(0,p(0,'Plus',p(0,'d\'',p(0,un,chien))),p(0,est,assis)),'.'), lit(txt)-appl(word(6),appl(appl(word(4),word(5)),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'Plus',p(0,'d\'',p(0,un,chien))),p(0,est,assis)), lit(s(main))-appl(appl(word(4),word(5)),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'Plus',p(0,'d\'',p(0,un,chien))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
         rule(dr, p(0,'d\'',p(0,un,chien)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, 'd\'', dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
            rule(dr, p(0,un,chien), lit(np(acc,_,_))-appl(word(2),word(3)), [
               rule(axiom, un, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
               rule(axiom, chien, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(dr, p(0,est,assis), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),word(5)), [
         rule(axiom, est, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(pass))))-word(4), []),
         rule(axiom, assis, dl(0,lit(np(nom,_,_)),lit(s(pass)))-word(5), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(6), [])
   ])).

% 10. Tous les chiens courent . 

proof(10, rule(dl, p(0,p(0,p(0,'Tous',p(0,les,chiens)),courent),'.'), lit(txt)-appl(word(4),appl(word(3),appl(word(0),appl(word(1),word(2))))), [
   rule(dl, p(0,p(0,'Tous',p(0,les,chiens)),courent), lit(s(main))-appl(word(3),appl(word(0),appl(word(1),word(2)))), [
      rule(dr, p(0,'Tous',p(0,les,chiens)), lit(np(nom,_,_))-appl(word(0),appl(word(1),word(2))), [
         rule(axiom, 'Tous', dr(0,lit(np(nom,_,_)),lit(np(_,_,_)))-word(0), []),
         rule(dr, p(0,les,chiens), lit(np(_,_,_))-appl(word(1),word(2)), [
            rule(axiom, les, dr(0,lit(np(_,_,_)),lit(n))-word(1), []),
            rule(axiom, chiens, lit(n)-word(2), [])
            ])
         ]),
      rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(3), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(4), [])
   ])).

% 12. Plus de deux chiens courent . 

proof(12, rule(dl, p(0,p(0,p(0,'Plus',p(0,de,p(0,deux,chiens))),courent),'.'), lit(txt)-appl(word(5),appl(word(4),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'Plus',p(0,de,p(0,deux,chiens))),courent), lit(s(main))-appl(word(4),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'Plus',p(0,de,p(0,deux,chiens))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
         rule(dr, p(0,de,p(0,deux,chiens)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
            rule(dr, p(0,deux,chiens), lit(np(acc,_,_))-appl(word(2),word(3)), [
               rule(axiom, deux, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
               rule(axiom, chiens, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(4), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(5), [])
   ])).

% 14. Plus de quatre chiens sont assis . 

proof(14, rule(dl, p(0,p(0,p(0,'Plus',p(0,de,p(0,quatre,chiens))),p(0,sont,assis)),'.'), lit(txt)-appl(word(6),appl(appl(word(4),word(5)),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'Plus',p(0,de,p(0,quatre,chiens))),p(0,sont,assis)), lit(s(main))-appl(appl(word(4),word(5)),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'Plus',p(0,de,p(0,quatre,chiens))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
         rule(dr, p(0,de,p(0,quatre,chiens)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
            rule(dr, p(0,quatre,chiens), lit(np(acc,_,_))-appl(word(2),word(3)), [
               rule(axiom, quatre, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
               rule(axiom, chiens, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(dr, p(0,sont,assis), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),word(5)), [
         rule(axiom, sont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(pass))))-word(4), []),
         rule(axiom, assis, dl(0,lit(np(nom,_,_)),lit(s(pass)))-word(5), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(6), [])
   ])).

% 16. Plus de 3 chiens ne sont pas assis . 

proof(16, rule(dl, p(0,p(0,p(0,'Plus',p(0,de,p(0,3,chiens))),p(0,ne,p(0,sont,p(0,pas,assis)))),'.'), lit(txt)-appl(word(8),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'Plus',p(0,de,p(0,3,chiens))),p(0,ne,p(0,sont,p(0,pas,assis)))), lit(s(main))-appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'Plus',p(0,de,p(0,3,chiens))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
         rule(dr, p(0,de,p(0,3,chiens)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
            rule(dr, p(0,3,chiens), lit(np(acc,_,_))-appl(word(2),word(3)), [
               rule(axiom, 3, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
               rule(axiom, chiens, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(dr, p(0,ne,p(0,sont,p(0,pas,assis))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
         rule(axiom, ne, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(4), []),
         rule(dr, p(0,sont,p(0,pas,assis)), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(5),appl(word(6),word(7))), [
            rule(axiom, sont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(pass))))-word(5), []),
            rule(dr, p(0,pas,assis), dl(0,lit(np(nom,_,_)),lit(s(pass)))-appl(word(6),word(7)), [
               rule(axiom, pas, dr(0,dl(0,lit(np(nom,_,_)),lit(s(pass))),dl(0,lit(np(nom,_,_)),lit(s(pass))))-word(6), []),
               rule(axiom, assis, dl(0,lit(np(nom,_,_)),lit(s(pass)))-word(7), [])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(8), [])
   ])).

% 18. Moins de six chiens courent . 

proof(18, rule(dl, p(0,p(0,p(0,'Moins',p(0,de,p(0,six,chiens))),courent),'.'), lit(txt)-appl(word(5),appl(word(4),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'Moins',p(0,de,p(0,six,chiens))),courent), lit(s(main))-appl(word(4),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'Moins',p(0,de,p(0,six,chiens))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'Moins', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
         rule(dr, p(0,de,p(0,six,chiens)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
            rule(dr, p(0,six,chiens), lit(np(acc,_,_))-appl(word(2),word(3)), [
               rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
               rule(axiom, chiens, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(4), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(5), [])
   ])).

% 20. Un chien est assis . 

proof(20, rule(dl, p(0,p(0,p(0,'Un',chien),p(0,est,assis)),'.'), lit(txt)-appl(word(4),appl(appl(word(2),word(3)),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Un',chien),p(0,est,assis)), lit(s(main))-appl(appl(word(2),word(3)),appl(word(0),word(1))), [
      rule(dr, p(0,'Un',chien), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Un', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, chien, lit(n)-word(1), [])
         ]),
      rule(dr, p(0,est,assis), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),word(3)), [
         rule(axiom, est, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(pass))))-word(2), []),
         rule(axiom, assis, dl(0,lit(np(nom,_,_)),lit(s(pass)))-word(3), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(4), [])
   ])).

% 22. Trois chiens courent . 

proof(22, rule(dl, p(0,p(0,p(0,'Trois',chiens),courent),'.'), lit(txt)-appl(word(3),appl(word(2),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Trois',chiens),courent), lit(s(main))-appl(word(2),appl(word(0),word(1))), [
      rule(dr, p(0,'Trois',chiens), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Trois', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, chiens, lit(n)-word(1), [])
         ]),
      rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(2), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(3), [])
   ])).

% 24. Entre six et sept chiens courent . 

proof(24, rule(dl, p(0,p(0,p(0,'Entre',p(0,p(0,six,p(0,et,sept)),chiens)),courent),'.'), lit(txt)-appl(word(6),appl(word(5),appl(word(0),appl(appl(appl(word(2),word(3)),word(1)),word(4))))), [
   rule(dl, p(0,p(0,'Entre',p(0,p(0,six,p(0,et,sept)),chiens)),courent), lit(s(main))-appl(word(5),appl(word(0),appl(appl(appl(word(2),word(3)),word(1)),word(4)))), [
      rule(dr, p(0,'Entre',p(0,p(0,six,p(0,et,sept)),chiens)), lit(np(nom,_,_))-appl(word(0),appl(appl(appl(word(2),word(3)),word(1)),word(4))), [
         rule(axiom, 'Entre', dr(0,lit(np(nom,_,_)),lit(np(_,_,_)))-word(0), []),
         rule(dr, p(0,p(0,six,p(0,et,sept)),chiens), lit(np(_,_,_))-appl(appl(appl(word(2),word(3)),word(1)),word(4)), [
            rule(dl, p(0,six,p(0,et,sept)), dr(0,lit(np(_,_,_)),lit(n))-appl(appl(word(2),word(3)),word(1)), [
               rule(axiom, six, dr(0,lit(np(_,_,_)),lit(n))-word(1), []),
               rule(dr, p(0,et,sept), dl(0,dr(0,lit(np(_,_,_)),lit(n)),dr(0,lit(np(_,_,_)),lit(n)))-appl(word(2),word(3)), [
                  rule(axiom, et, dr(0,dl(0,dr(0,lit(np(_,_,_)),lit(n)),dr(0,lit(np(_,_,_)),lit(n))),dr(0,lit(np(_,_,_)),lit(n)))-word(2), []),
                  rule(axiom, sept, dr(0,lit(np(_,_,_)),lit(n))-word(3), [])
                  ])
               ]),
            rule(axiom, chiens, lit(n)-word(4), [])
            ])
         ]),
      rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(5), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(6), [])
   ])).

% 30. Un chien rouge court . 

proof(30, rule(dl, p(0,p(0,'Un',p(0,p(0,chien,rouge),court)),'.'), lit(txt)-appl(word(4),appl(word(0),appl(word(3),appl(word(2),word(1))))), [
   rule(dr, p(0,'Un',p(0,p(0,chien,rouge),court)), lit(np(_,_,_))-appl(word(0),appl(word(3),appl(word(2),word(1)))), [
      rule(axiom, 'Un', dr(0,lit(np(_,_,_)),lit(n))-word(0), []),
      rule(dl, p(0,p(0,chien,rouge),court), lit(n)-appl(word(3),appl(word(2),word(1))), [
         rule(dl, p(0,chien,rouge), lit(n)-appl(word(2),word(1)), [
            rule(axiom, chien, lit(n)-word(1), []),
            rule(axiom, rouge, dl(0,lit(n),lit(n))-word(2), [])
            ]),
         rule(axiom, court, dl(0,lit(n),lit(n))-word(3), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(np(_,_,_)),lit(txt))-word(4), [])
   ])).

% 32. 60 % des chiens courent . 

proof(32, rule(dl, p(0,p(0,p(0,60,p(0,'%',p(0,des,chiens))),courent),'.'), lit(txt)-appl(word(5),appl(word(4),appl(word(0),appl(appl(word(2),word(3)),word(1))))), [
   rule(dl, p(0,p(0,60,p(0,'%',p(0,des,chiens))),courent), lit(s(main))-appl(word(4),appl(word(0),appl(appl(word(2),word(3)),word(1)))), [
      rule(dr, p(0,60,p(0,'%',p(0,des,chiens))), lit(np(nom,_,_))-appl(word(0),appl(appl(word(2),word(3)),word(1))), [
         rule(axiom, 60, dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dl, p(0,'%',p(0,des,chiens)), lit(n)-appl(appl(word(2),word(3)),word(1)), [
            rule(axiom, '%', lit(n)-word(1), []),
            rule(dr, p(0,des,chiens), dl(0,lit(n),lit(n))-appl(word(2),word(3)), [
               rule(axiom, des, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(2), []),
               rule(axiom, chiens, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(4), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(5), [])
   ])).

% 34. 40 % des chiens sont assis . 

proof(34, rule(dl, p(0,p(0,p(0,40,p(0,'%',p(0,des,chiens))),p(0,sont,assis)),'.'), lit(txt)-appl(word(6),appl(appl(word(4),word(5)),appl(word(0),appl(appl(word(2),word(3)),word(1))))), [
   rule(dl, p(0,p(0,40,p(0,'%',p(0,des,chiens))),p(0,sont,assis)), lit(s(main))-appl(appl(word(4),word(5)),appl(word(0),appl(appl(word(2),word(3)),word(1)))), [
      rule(dr, p(0,40,p(0,'%',p(0,des,chiens))), lit(np(nom,_,_))-appl(word(0),appl(appl(word(2),word(3)),word(1))), [
         rule(axiom, 40, dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dl, p(0,'%',p(0,des,chiens)), lit(n)-appl(appl(word(2),word(3)),word(1)), [
            rule(axiom, '%', lit(n)-word(1), []),
            rule(dr, p(0,des,chiens), dl(0,lit(n),lit(n))-appl(word(2),word(3)), [
               rule(axiom, des, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(2), []),
               rule(axiom, chiens, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(dr, p(0,sont,assis), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),word(5)), [
         rule(axiom, sont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(pass))))-word(4), []),
         rule(axiom, assis, dl(0,lit(np(nom,_,_)),lit(s(pass)))-word(5), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(6), [])
   ])).

% 36. Plus de 40 % des chiens courent . 

proof(36, rule(dl, p(0,p(0,p(0,'Plus',p(0,de,p(0,40,p(0,'%',p(0,des,chiens))))),courent),'.'), lit(txt)-appl(word(7),appl(word(6),appl(word(0),appl(word(1),appl(word(2),appl(appl(word(4),word(5)),word(3))))))), [
   rule(dl, p(0,p(0,'Plus',p(0,de,p(0,40,p(0,'%',p(0,des,chiens))))),courent), lit(s(main))-appl(word(6),appl(word(0),appl(word(1),appl(word(2),appl(appl(word(4),word(5)),word(3)))))), [
      rule(dr, p(0,'Plus',p(0,de,p(0,40,p(0,'%',p(0,des,chiens))))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),appl(appl(word(4),word(5)),word(3))))), [
         rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
         rule(dr, p(0,de,p(0,40,p(0,'%',p(0,des,chiens)))), lit(pp(de))-appl(word(1),appl(word(2),appl(appl(word(4),word(5)),word(3)))), [
            rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
            rule(dr, p(0,40,p(0,'%',p(0,des,chiens))), lit(np(acc,_,_))-appl(word(2),appl(appl(word(4),word(5)),word(3))), [
               rule(axiom, 40, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
               rule(dl, p(0,'%',p(0,des,chiens)), lit(n)-appl(appl(word(4),word(5)),word(3)), [
                  rule(axiom, '%', lit(n)-word(3), []),
                  rule(dr, p(0,des,chiens), dl(0,lit(n),lit(n))-appl(word(4),word(5)), [
                     rule(axiom, des, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(4), []),
                     rule(axiom, chiens, lit(n)-word(5), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(6), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(7), [])
   ])).

% 38. Un chien brun et un chien rouge se poursuivent . 

proof(38, rule(dl, p(0,p(0,p(0,p(0,'Un',p(0,chien,brun)),p(0,et,p(0,un,p(0,chien,rouge)))),p(0,se,poursuivent)),'.'), lit(txt)-appl(word(9),appl(appl(word(8),word(7)),appl(appl(word(3),appl(word(4),appl(word(6),word(5)))),appl(word(0),appl(word(2),word(1)))))), [
   rule(dl, p(0,p(0,p(0,'Un',p(0,chien,brun)),p(0,et,p(0,un,p(0,chien,rouge)))),p(0,se,poursuivent)), lit(s(main))-appl(appl(word(8),word(7)),appl(appl(word(3),appl(word(4),appl(word(6),word(5)))),appl(word(0),appl(word(2),word(1))))), [
      rule(dl, p(0,p(0,'Un',p(0,chien,brun)),p(0,et,p(0,un,p(0,chien,rouge)))), lit(np(nom,_,_))-appl(appl(word(3),appl(word(4),appl(word(6),word(5)))),appl(word(0),appl(word(2),word(1)))), [
         rule(dr, p(0,'Un',p(0,chien,brun)), lit(np(nom,_,_))-appl(word(0),appl(word(2),word(1))), [
            rule(axiom, 'Un', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
            rule(dl, p(0,chien,brun), lit(n)-appl(word(2),word(1)), [
               rule(axiom, chien, lit(n)-word(1), []),
               rule(axiom, brun, dl(0,lit(n),lit(n))-word(2), [])
               ])
            ]),
         rule(dr, p(0,et,p(0,un,p(0,chien,rouge))), dl(0,lit(np(nom,_,_)),lit(np(nom,_,_)))-appl(word(3),appl(word(4),appl(word(6),word(5)))), [
            rule(axiom, et, dr(0,dl(0,lit(np(nom,_,_)),lit(np(nom,_,_))),lit(np(_,_,_)))-word(3), []),
            rule(dr, p(0,un,p(0,chien,rouge)), lit(np(_,_,_))-appl(word(4),appl(word(6),word(5))), [
               rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(4), []),
               rule(dl, p(0,chien,rouge), lit(n)-appl(word(6),word(5)), [
                  rule(axiom, chien, lit(n)-word(5), []),
                  rule(axiom, rouge, dl(0,lit(n),lit(n))-word(6), [])
                  ])
               ])
            ])
         ]),
      rule(dl, p(0,se,poursuivent), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(8),word(7)), [
         rule(axiom, se, lit(cl_r)-word(7), []),
         rule(axiom, poursuivent, dl(0,lit(cl_r),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(8), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(9), [])
   ])).

% 40. Deux chiens rouges se poursuivent l' un l' autre . 

proof(40, rule(dl, p(0,p(1,p(0,p(0,'Deux',p(0,chiens,rouges)),p(0,se,poursuivent)),p(0,'l\'',p(0,un,p(0,'l\'',autre)))),'.'), lit(txt)-appl(word(9),appl(appl(word(5),appl(appl(word(7),word(8)),word(6))),appl(appl(word(4),word(3)),appl(word(0),appl(word(2),word(1)))))), [
   rule(dl, p(1,p(0,p(0,'Deux',p(0,chiens,rouges)),p(0,se,poursuivent)),p(0,'l\'',p(0,un,p(0,'l\'',autre)))), lit(s(main))-appl(appl(word(5),appl(appl(word(7),word(8)),word(6))),appl(appl(word(4),word(3)),appl(word(0),appl(word(2),word(1))))), [
      rule(dl, p(0,p(0,'Deux',p(0,chiens,rouges)),p(0,se,poursuivent)), lit(s(main))-appl(appl(word(4),word(3)),appl(word(0),appl(word(2),word(1)))), [
         rule(dr, p(0,'Deux',p(0,chiens,rouges)), lit(np(nom,_,_))-appl(word(0),appl(word(2),word(1))), [
            rule(axiom, 'Deux', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
            rule(dl, p(0,chiens,rouges), lit(n)-appl(word(2),word(1)), [
               rule(axiom, chiens, lit(n)-word(1), []),
               rule(axiom, rouges, dl(0,lit(n),lit(n))-word(2), [])
               ])
            ]),
         rule(dl, p(0,se,poursuivent), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),word(3)), [
            rule(axiom, se, lit(cl_r)-word(3), []),
            rule(axiom, poursuivent, dl(0,lit(cl_r),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(4), [])
            ])
         ]),
      rule(dr, p(0,'l\'',p(0,un,p(0,'l\'',autre))), dl(1,lit(s(main)),lit(s(main)))-appl(word(5),appl(appl(word(7),word(8)),word(6))), [
         rule(axiom, 'l\'', dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(5), []),
         rule(dl, p(0,un,p(0,'l\'',autre)), lit(n)-appl(appl(word(7),word(8)),word(6)), [
            rule(axiom, un, lit(n)-word(6), []),
            rule(dr, p(0,'l\'',autre), dl(0,lit(n),lit(n))-appl(word(7),word(8)), [
               rule(axiom, 'l\'', dr(0,dl(0,lit(n),lit(n)),lit(n))-word(7), []),
               rule(axiom, autre, lit(n)-word(8), [])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(9), [])
   ])).

% 101. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts rouges et un tiers portent des hauts verts . 

proof(101, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,rouges))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,rouges)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,rouges), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, rouges, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,verts))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,verts)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,verts), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, verts, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 102. Six enfants portant des hauts rouges se tiennent debout au sommet d' une montagne . 

proof(102, rule(dl, p(0,p(1,p(0,p(0,'Six',p(0,p(0,enfants,p(0,portant,p(0,des,hauts))),rouges)),p(0,se,p(0,tiennent,debout))),p(0,au,p(0,sommet,p(0,'d\'',p(0,une,montagne))))),'.'), lit(txt)-appl(word(14),appl(appl(word(9),appl(appl(word(11),appl(word(12),word(13))),word(10))),appl(appl(appl(word(7),word(8)),word(6)),appl(word(0),appl(word(5),appl(appl(word(2),appl(word(3),word(4))),word(1))))))), [
   rule(dl, p(1,p(0,p(0,'Six',p(0,p(0,enfants,p(0,portant,p(0,des,hauts))),rouges)),p(0,se,p(0,tiennent,debout))),p(0,au,p(0,sommet,p(0,'d\'',p(0,une,montagne))))), lit(s(main))-appl(appl(word(9),appl(appl(word(11),appl(word(12),word(13))),word(10))),appl(appl(appl(word(7),word(8)),word(6)),appl(word(0),appl(word(5),appl(appl(word(2),appl(word(3),word(4))),word(1)))))), [
      rule(dl, p(0,p(0,'Six',p(0,p(0,enfants,p(0,portant,p(0,des,hauts))),rouges)),p(0,se,p(0,tiennent,debout))), lit(s(main))-appl(appl(appl(word(7),word(8)),word(6)),appl(word(0),appl(word(5),appl(appl(word(2),appl(word(3),word(4))),word(1))))), [
         rule(dr, p(0,'Six',p(0,p(0,enfants,p(0,portant,p(0,des,hauts))),rouges)), lit(np(nom,_,_))-appl(word(0),appl(word(5),appl(appl(word(2),appl(word(3),word(4))),word(1)))), [
            rule(axiom, 'Six', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
            rule(dl, p(0,p(0,enfants,p(0,portant,p(0,des,hauts))),rouges), lit(n)-appl(word(5),appl(appl(word(2),appl(word(3),word(4))),word(1))), [
               rule(dl, p(0,enfants,p(0,portant,p(0,des,hauts))), lit(n)-appl(appl(word(2),appl(word(3),word(4))),word(1)), [
                  rule(axiom, enfants, lit(n)-word(1), []),
                  rule(dr, p(0,portant,p(0,des,hauts)), dl(0,lit(n),lit(n))-appl(word(2),appl(word(3),word(4))), [
                     rule(axiom, portant, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(2), []),
                     rule(dr, p(0,des,hauts), lit(np(_,_,_))-appl(word(3),word(4)), [
                        rule(axiom, des, dr(0,lit(np(_,_,_)),lit(n))-word(3), []),
                        rule(axiom, hauts, lit(n)-word(4), [])
                        ])
                     ])
                  ]),
               rule(axiom, rouges, dl(0,lit(n),lit(n))-word(5), [])
               ])
            ]),
         rule(dl, p(0,se,p(0,tiennent,debout)), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(appl(word(7),word(8)),word(6)), [
            rule(axiom, se, lit(cl_r)-word(6), []),
            rule(dr, p(0,tiennent,debout), dl(0,lit(cl_r),dl(0,lit(np(nom,_,_)),lit(s(main))))-appl(word(7),word(8)), [
               rule(axiom, tiennent, dr(0,dl(0,lit(cl_r),dl(0,lit(np(nom,_,_)),lit(s(main)))),dl(0,lit(n),lit(n)))-word(7), []),
               rule(axiom, debout, dl(0,lit(n),lit(n))-word(8), [])
               ])
            ])
         ]),
      rule(dr, p(0,au,p(0,sommet,p(0,'d\'',p(0,une,montagne)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(9),appl(appl(word(11),appl(word(12),word(13))),word(10))), [
         rule(axiom, au, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(9), []),
         rule(dl, p(0,sommet,p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(11),appl(word(12),word(13))),word(10)), [
            rule(axiom, sommet, lit(n)-word(10), []),
            rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(11),appl(word(12),word(13))), [
               rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(11), []),
               rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(12),word(13)), [
                  rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(12), []),
                  rule(axiom, montagne, lit(n)-word(13), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(14), [])
   ])).

% 103. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts rouges et un tiers portent des hauts verts . 

proof(103, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,rouges))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,rouges)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,rouges), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, rouges, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,verts))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,verts)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,verts), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, verts, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 105. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts rouges et un tiers portent des hauts verts . 

proof(105, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,rouges))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,rouges)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,rouges), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, rouges, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,verts))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,verts)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,verts), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, verts, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 107. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts rouges et un tiers portent des hauts verts . 

proof(107, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,rouges))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,rouges)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,rouges), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, rouges, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,verts))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,verts)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,verts), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, verts, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 108. Quatre enfants portent des hauts rouges . 

proof(108, rule(dl, p(0,p(0,p(0,'Quatre',enfants),p(0,portent,p(0,des,p(0,hauts,rouges)))),'.'), lit(txt)-appl(word(6),appl(appl(word(2),appl(word(3),appl(word(5),word(4)))),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Quatre',enfants),p(0,portent,p(0,des,p(0,hauts,rouges)))), lit(s(main))-appl(appl(word(2),appl(word(3),appl(word(5),word(4)))),appl(word(0),word(1))), [
      rule(dr, p(0,'Quatre',enfants), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Quatre', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, enfants, lit(n)-word(1), [])
         ]),
      rule(dr, p(0,portent,p(0,des,p(0,hauts,rouges))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),appl(word(3),appl(word(5),word(4)))), [
         rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(2), []),
         rule(dr, p(0,des,p(0,hauts,rouges)), lit(np(acc,_,_))-appl(word(3),appl(word(5),word(4))), [
            rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
            rule(dl, p(0,hauts,rouges), lit(n)-appl(word(5),word(4)), [
               rule(axiom, hauts, lit(n)-word(4), []),
               rule(axiom, rouges, dl(0,lit(n),lit(n))-word(5), [])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(6), [])
   ])).

% 109. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts rouges et un tiers portent des hauts verts . 

proof(109, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,rouges))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,rouges)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,rouges), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, rouges, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,verts))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,verts)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,verts), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, verts, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 111. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts rouges et un tiers portent des hauts verts . 

proof(111, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,rouges))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,rouges)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,rouges), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, rouges, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,verts))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,verts)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,verts), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, verts, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 112. Tous les enfants portent des hauts . 

proof(112, rule(dl, p(0,p(0,p(0,'Tous',p(0,les,enfants)),p(0,portent,p(0,des,hauts))),'.'), lit(txt)-appl(word(6),appl(appl(word(3),appl(word(4),word(5))),appl(word(0),appl(word(1),word(2))))), [
   rule(dl, p(0,p(0,'Tous',p(0,les,enfants)),p(0,portent,p(0,des,hauts))), lit(s(main))-appl(appl(word(3),appl(word(4),word(5))),appl(word(0),appl(word(1),word(2)))), [
      rule(dr, p(0,'Tous',p(0,les,enfants)), lit(np(nom,_,_))-appl(word(0),appl(word(1),word(2))), [
         rule(axiom, 'Tous', dr(0,lit(np(nom,_,_)),lit(np(_,_,_)))-word(0), []),
         rule(dr, p(0,les,enfants), lit(np(_,_,_))-appl(word(1),word(2)), [
            rule(axiom, les, dr(0,lit(np(_,_,_)),lit(n))-word(1), []),
            rule(axiom, enfants, lit(n)-word(2), [])
            ])
         ]),
      rule(dr, p(0,portent,p(0,des,hauts)), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(3),appl(word(4),word(5))), [
         rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(3), []),
         rule(dr, p(0,des,hauts), lit(np(acc,_,_))-appl(word(4),word(5)), [
            rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(4), []),
            rule(axiom, hauts, lit(n)-word(5), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(6), [])
   ])).

% 113. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts rouges et un tiers portent des hauts verts . 

proof(113, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,rouges))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,rouges)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,rouges), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, rouges, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,verts))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,verts)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,verts), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, verts, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 115. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts rouges et un tiers portent des hauts verts . 

proof(115, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,rouges))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,rouges)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,rouges), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, rouges, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,verts))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,verts)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,verts), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, verts, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 116. Moins de cinq enfants portent des hauts rouges . 

proof(116, rule(dl, p(0,p(0,p(0,'Moins',p(0,de,p(0,cinq,enfants))),p(0,portent,p(0,des,p(0,hauts,rouges)))),'.'), lit(txt)-appl(word(8),appl(appl(word(4),appl(word(5),appl(word(7),word(6)))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'Moins',p(0,de,p(0,cinq,enfants))),p(0,portent,p(0,des,p(0,hauts,rouges)))), lit(s(main))-appl(appl(word(4),appl(word(5),appl(word(7),word(6)))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'Moins',p(0,de,p(0,cinq,enfants))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'Moins', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
         rule(dr, p(0,de,p(0,cinq,enfants)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
            rule(dr, p(0,cinq,enfants), lit(np(acc,_,_))-appl(word(2),word(3)), [
               rule(axiom, cinq, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
               rule(axiom, enfants, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(dr, p(0,portent,p(0,des,p(0,hauts,rouges))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),appl(word(7),word(6)))), [
         rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(4), []),
         rule(dr, p(0,des,p(0,hauts,rouges)), lit(np(acc,_,_))-appl(word(5),appl(word(7),word(6))), [
            rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(5), []),
            rule(dl, p(0,hauts,rouges), lit(n)-appl(word(7),word(6)), [
               rule(axiom, hauts, lit(n)-word(6), []),
               rule(axiom, rouges, dl(0,lit(n),lit(n))-word(7), [])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(8), [])
   ])).

% 117. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts rouges et un tiers portent des hauts verts . 

proof(117, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,rouges))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,rouges)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,rouges), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, rouges, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,verts))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,verts)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,verts), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, verts, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 119. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts rouges et un tiers portent des hauts verts . 

proof(119, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,rouges))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,rouges)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,rouges), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, rouges, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,verts))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,verts)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,verts), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, verts, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 121. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts rouges et un tiers portent des hauts verts . 

proof(121, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,rouges))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,rouges)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,rouges), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, rouges, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,verts))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,verts)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,verts), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, verts, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 123. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts rouges et un tiers portent des hauts verts . 

proof(123, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,rouges)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,rouges))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,rouges)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,rouges), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, rouges, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,verts)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,verts))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,verts)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,verts), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, verts, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 124. Certains enfants ont les cheveux roux . 

proof(124, rule(dl, p(0,p(0,p(0,'Certains',enfants),p(0,ont,p(0,les,p(0,cheveux,roux)))),'.'), lit(txt)-appl(word(6),appl(appl(word(2),appl(word(3),appl(word(5),word(4)))),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Certains',enfants),p(0,ont,p(0,les,p(0,cheveux,roux)))), lit(s(main))-appl(appl(word(2),appl(word(3),appl(word(5),word(4)))),appl(word(0),word(1))), [
      rule(dr, p(0,'Certains',enfants), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Certains', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, enfants, lit(n)-word(1), [])
         ]),
      rule(dr, p(0,ont,p(0,les,p(0,cheveux,roux))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),appl(word(3),appl(word(5),word(4)))), [
         rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(2), []),
         rule(dr, p(0,les,p(0,cheveux,roux)), lit(np(acc,_,_))-appl(word(3),appl(word(5),word(4))), [
            rule(axiom, les, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
            rule(dl, p(0,cheveux,roux), lit(n)-appl(word(5),word(4)), [
               rule(axiom, cheveux, lit(n)-word(4), []),
               rule(axiom, roux, dl(0,lit(n),lit(n))-word(5), [])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(6), [])
   ])).

% 126. Plus de 4 chanteurs sont originaires d' Argentine . 

proof(126, rule(dl, p(0,p(0,p(0,'Plus',p(0,de,p(0,4,chanteurs))),p(0,sont,p(0,originaires,p(0,'d\'','Argentine')))),'.'), lit(txt)-appl(word(8),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'Plus',p(0,de,p(0,4,chanteurs))),p(0,sont,p(0,originaires,p(0,'d\'','Argentine')))), lit(s(main))-appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'Plus',p(0,de,p(0,4,chanteurs))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
         rule(dr, p(0,de,p(0,4,chanteurs)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
            rule(dr, p(0,4,chanteurs), lit(np(acc,_,_))-appl(word(2),word(3)), [
               rule(axiom, 4, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
               rule(axiom, chanteurs, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(dr, p(0,sont,p(0,originaires,p(0,'d\'','Argentine'))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
         rule(axiom, sont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(4), []),
         rule(dr, p(0,originaires,p(0,'d\'','Argentine')), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(5),appl(word(6),word(7))), [
            rule(axiom, originaires, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(pp(de)))-word(5), []),
            rule(dr, p(0,'d\'','Argentine'), lit(pp(de))-appl(word(6),word(7)), [
               rule(axiom, 'd\'', dr(0,lit(pp(de)),lit(n))-word(6), []),
               rule(axiom, 'Argentine', lit(n)-word(7), [])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(8), [])
   ])).

% 128. Les deux tiers des chanteurs sont originaires d' Argentine . 

proof(128, rule(dl, p(0,p(0,p(0,'Les',p(0,p(0,deux,tiers),p(0,des,chanteurs))),p(0,sont,p(0,originaires,p(0,'d\'','Argentine')))),'.'), lit(txt)-appl(word(9),appl(appl(word(5),appl(word(6),appl(word(7),word(8)))),appl(word(0),appl(appl(word(3),word(4)),appl(word(1),word(2)))))), [
   rule(dl, p(0,p(0,'Les',p(0,p(0,deux,tiers),p(0,des,chanteurs))),p(0,sont,p(0,originaires,p(0,'d\'','Argentine')))), lit(s(main))-appl(appl(word(5),appl(word(6),appl(word(7),word(8)))),appl(word(0),appl(appl(word(3),word(4)),appl(word(1),word(2))))), [
      rule(dr, p(0,'Les',p(0,p(0,deux,tiers),p(0,des,chanteurs))), lit(np(nom,_,_))-appl(word(0),appl(appl(word(3),word(4)),appl(word(1),word(2)))), [
         rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dl, p(0,p(0,deux,tiers),p(0,des,chanteurs)), lit(n)-appl(appl(word(3),word(4)),appl(word(1),word(2))), [
            rule(dr, p(0,deux,tiers), lit(n)-appl(word(1),word(2)), [
               rule(axiom, deux, dr(0,lit(n),lit(n))-word(1), []),
               rule(axiom, tiers, lit(n)-word(2), [])
               ]),
            rule(dr, p(0,des,chanteurs), dl(0,lit(n),lit(n))-appl(word(3),word(4)), [
               rule(axiom, des, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(3), []),
               rule(axiom, chanteurs, lit(n)-word(4), [])
               ])
            ])
         ]),
      rule(dr, p(0,sont,p(0,originaires,p(0,'d\'','Argentine'))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(5),appl(word(6),appl(word(7),word(8)))), [
         rule(axiom, sont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(5), []),
         rule(dr, p(0,originaires,p(0,'d\'','Argentine')), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(6),appl(word(7),word(8))), [
            rule(axiom, originaires, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(pp(de)))-word(6), []),
            rule(dr, p(0,'d\'','Argentine'), lit(pp(de))-appl(word(7),word(8)), [
               rule(axiom, 'd\'', dr(0,lit(pp(de)),lit(n))-word(7), []),
               rule(axiom, 'Argentine', lit(n)-word(8), [])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(9), [])
   ])).

% 130. Deux chanteurs viennent d' Argentine . 

proof(130, rule(dl, p(0,p(0,p(0,'Deux',chanteurs),p(0,viennent,p(0,'d\'','Argentine'))),'.'), lit(txt)-appl(word(5),appl(appl(word(2),appl(word(3),word(4))),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Deux',chanteurs),p(0,viennent,p(0,'d\'','Argentine'))), lit(s(main))-appl(appl(word(2),appl(word(3),word(4))),appl(word(0),word(1))), [
      rule(dr, p(0,'Deux',chanteurs), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Deux', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, chanteurs, lit(n)-word(1), [])
         ]),
      rule(dr, p(0,viennent,p(0,'d\'','Argentine')), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),appl(word(3),word(4))), [
         rule(axiom, viennent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(pp(de)))-word(2), []),
         rule(dr, p(0,'d\'','Argentine'), lit(pp(de))-appl(word(3),word(4)), [
            rule(axiom, 'd\'', dr(0,lit(pp(de)),lit(n))-word(3), []),
            rule(axiom, 'Argentine', lit(n)-word(4), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(5), [])
   ])).

% 132. La plupart des chanteurs viennent d' Argentine . 

proof(132, rule(dl, p(0,p(0,p(0,'La',p(0,plupart,p(0,des,chanteurs))),p(0,viennent,p(0,'d\'','Argentine'))),'.'), lit(txt)-appl(word(7),appl(appl(word(4),appl(word(5),word(6))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'La',p(0,plupart,p(0,des,chanteurs))),p(0,viennent,p(0,'d\'','Argentine'))), lit(s(main))-appl(appl(word(4),appl(word(5),word(6))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'La',p(0,plupart,p(0,des,chanteurs))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'La', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dr, p(0,plupart,p(0,des,chanteurs)), lit(n)-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, plupart, dr(0,lit(n),lit(pp(de)))-word(1), []),
            rule(dr, p(0,des,chanteurs), lit(pp(de))-appl(word(2),word(3)), [
               rule(axiom, des, dr(0,lit(pp(de)),lit(n))-word(2), []),
               rule(axiom, chanteurs, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(dr, p(0,viennent,p(0,'d\'','Argentine')), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),word(6))), [
         rule(axiom, viennent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(pp(de)))-word(4), []),
         rule(dr, p(0,'d\'','Argentine'), lit(pp(de))-appl(word(5),word(6)), [
            rule(axiom, 'd\'', dr(0,lit(pp(de)),lit(n))-word(5), []),
            rule(axiom, 'Argentine', lit(n)-word(6), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(7), [])
   ])).

% 134. Plusieurs chanteurs ne viennent pas du Chili . 

proof(134, rule(dl, p(0,p(0,p(0,'Plusieurs',chanteurs),p(0,ne,p(0,p(1,viennent,pas),p(0,du,'Chili')))),'.'), lit(txt)-appl(word(7),appl(appl(word(2),lambda('$VAR'(0),appl(word(4),appl(appl(word(3),appl(word(5),word(6))),'$VAR'(0))))),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Plusieurs',chanteurs),p(0,ne,p(0,p(1,viennent,pas),p(0,du,'Chili')))), lit(s(main))-appl(appl(word(2),lambda('$VAR'(0),appl(word(4),appl(appl(word(3),appl(word(5),word(6))),'$VAR'(0))))),appl(word(0),word(1))), [
      rule(dr, p(0,'Plusieurs',chanteurs), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Plusieurs', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, chanteurs, lit(n)-word(1), [])
         ]),
      rule(dr, p(0,ne,p(0,p(1,viennent,pas),p(0,du,'Chili'))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),lambda('$VAR'(0),appl(word(4),appl(appl(word(3),appl(word(5),word(6))),'$VAR'(0))))), [
         rule(axiom, ne, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(2), []),
         rule(dli(0), p(0,p(1,viennent,pas),p(0,du,'Chili')), dl(0,lit(np(nom,_,_)),lit(s(main)))-lambda('$VAR'(3),appl(word(4),appl(appl(word(3),appl(word(5),word(6))),'$VAR'(3)))), [
            rule(dl1, p(0,'$VAR'(0),p(0,p(1,viennent,pas),p(0,du,'Chili'))), lit(s(main))-appl(word(4),appl(appl(word(3),appl(word(5),word(6))),'$VAR'(3))), [
               rule(dl, p(0,'$VAR'(0),p(0,viennent,p(0,du,'Chili'))), lit(s(main))-appl(appl(word(3),appl(word(5),word(6))),'$VAR'(3)), [
                  rule(hyp(0), '$VAR'(0), lit(np(nom,_,_))-'$VAR'(3), []),
                  rule(dr, p(0,viennent,p(0,du,'Chili')), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(3),appl(word(5),word(6))), [
                     rule(axiom, viennent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(pp(de)))-word(3), []),
                     rule(dr, p(0,du,'Chili'), lit(pp(de))-appl(word(5),word(6)), [
                        rule(axiom, du, dr(0,lit(pp(de)),lit(n))-word(5), []),
                        rule(axiom, 'Chili', lit(n)-word(6), [])
                        ])
                     ])
                  ]),
               rule(axiom, pas, dl(1,lit(s(main)),lit(s(main)))-word(4), [])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(7), [])
   ])).

% 160. 36 % de la population africaine vit dans la richesse . 

proof(160, rule(dl, p(0,p(0,p(0,36,p(0,p(0,'%',p(0,de,p(0,la,population))),africaine)),p(0,vit,p(0,dans,p(0,la,richesse)))),'.'), lit(txt)-appl(word(10),appl(appl(word(6),appl(word(7),appl(word(8),word(9)))),appl(word(0),appl(word(5),appl(appl(word(2),appl(word(3),word(4))),word(1)))))), [
   rule(dl, p(0,p(0,36,p(0,p(0,'%',p(0,de,p(0,la,population))),africaine)),p(0,vit,p(0,dans,p(0,la,richesse)))), lit(s(main))-appl(appl(word(6),appl(word(7),appl(word(8),word(9)))),appl(word(0),appl(word(5),appl(appl(word(2),appl(word(3),word(4))),word(1))))), [
      rule(dr, p(0,36,p(0,p(0,'%',p(0,de,p(0,la,population))),africaine)), lit(np(nom,_,_))-appl(word(0),appl(word(5),appl(appl(word(2),appl(word(3),word(4))),word(1)))), [
         rule(axiom, 36, dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dl, p(0,p(0,'%',p(0,de,p(0,la,population))),africaine), lit(n)-appl(word(5),appl(appl(word(2),appl(word(3),word(4))),word(1))), [
            rule(dl, p(0,'%',p(0,de,p(0,la,population))), lit(n)-appl(appl(word(2),appl(word(3),word(4))),word(1)), [
               rule(axiom, '%', lit(n)-word(1), []),
               rule(dr, p(0,de,p(0,la,population)), dl(0,lit(n),lit(n))-appl(word(2),appl(word(3),word(4))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(2), []),
                  rule(dr, p(0,la,population), lit(np(_,_,_))-appl(word(3),word(4)), [
                     rule(axiom, la, dr(0,lit(np(_,_,_)),lit(n))-word(3), []),
                     rule(axiom, population, lit(n)-word(4), [])
                     ])
                  ])
               ]),
            rule(axiom, africaine, dl(0,lit(n),lit(n))-word(5), [])
            ])
         ]),
      rule(dr, p(0,vit,p(0,dans,p(0,la,richesse))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(6),appl(word(7),appl(word(8),word(9)))), [
         rule(axiom, vit, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(pp(dans)))-word(6), []),
         rule(dr, p(0,dans,p(0,la,richesse)), lit(pp(dans))-appl(word(7),appl(word(8),word(9))), [
            rule(axiom, dans, dr(0,lit(pp(dans)),lit(np(acc,_,_)))-word(7), []),
            rule(dr, p(0,la,richesse), lit(np(acc,_,_))-appl(word(8),word(9)), [
               rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(8), []),
               rule(axiom, richesse, lit(n)-word(9), [])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(10), [])
   ])).

% 162. Il y avait plus de femmes que d' hommes en Ukraine . 

proof(162, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,avait,p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes)))))),p(0,en,'Ukraine')),'.'), lit(txt)-appl(word(11),appl(appl(word(9),word(10)),appl(appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,avait,p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes)))))),p(0,en,'Ukraine')), lit(s(main))-appl(appl(word(9),word(10)),appl(appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,avait,p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes)))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,avait,p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,avait,p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes)))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))), [
               rule(axiom, avait, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes))), lit(np(acc,_,_))-appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8)))), [
                  rule(dr, p(0,plus,p(0,de,femmes)), dr(0,lit(np(acc,_,_)),lit(s(q)))-appl(word(3),appl(word(4),word(5))), [
                     rule(axiom, plus, dr(0,dr(0,lit(np(acc,_,_)),lit(s(q))),lit(pp(de)))-word(3), []),
                     rule(dr, p(0,de,femmes), lit(pp(de))-appl(word(4),word(5)), [
                        rule(axiom, de, dr(0,lit(pp(de)),lit(n))-word(4), []),
                        rule(axiom, femmes, lit(n)-word(5), [])
                        ])
                     ]),
                  rule(dr, p(0,que,p(0,'d\'',hommes)), lit(s(q))-appl(word(6),appl(word(7),word(8))), [
                     rule(axiom, que, dr(0,lit(s(q)),lit(pp(de)))-word(6), []),
                     rule(dr, p(0,'d\'',hommes), lit(pp(de))-appl(word(7),word(8)), [
                        rule(axiom, 'd\'', dr(0,lit(pp(de)),lit(n))-word(7), []),
                        rule(axiom, hommes, lit(n)-word(8), [])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,en,'Ukraine'), dl(1,lit(s(main)),lit(s(main)))-appl(word(9),word(10)), [
         rule(axiom, en, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(9), []),
         rule(axiom, 'Ukraine', lit(n)-word(10), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(11), [])
   ])).

% 164. Le ratio hommes-femmes pour 100 femmes en Ukraine se situait entre 86 et . 87. 

proof(164, rule(dl, p(0,p(0,p(0,'Le',p(0,p(0,p(0,ratio,'hommes-femmes'),p(0,pour,p(0,100,femmes))),p(0,en,'Ukraine'))),p(0,se,p(0,situait,p(0,entre,p(0,86,p(0,et,'.')))))),'87.'), lit(txt)-appl(word(14),appl(appl(appl(word(9),appl(word(10),appl(appl(word(12),word(13)),word(11)))),word(8)),appl(word(0),appl(appl(word(6),word(7)),appl(appl(word(3),appl(word(4),word(5))),appl(word(2),word(1))))))), [
   rule(dl, p(0,p(0,'Le',p(0,p(0,p(0,ratio,'hommes-femmes'),p(0,pour,p(0,100,femmes))),p(0,en,'Ukraine'))),p(0,se,p(0,situait,p(0,entre,p(0,86,p(0,et,'.')))))), lit(s(main))-appl(appl(appl(word(9),appl(word(10),appl(appl(word(12),word(13)),word(11)))),word(8)),appl(word(0),appl(appl(word(6),word(7)),appl(appl(word(3),appl(word(4),word(5))),appl(word(2),word(1)))))), [
      rule(dr, p(0,'Le',p(0,p(0,p(0,ratio,'hommes-femmes'),p(0,pour,p(0,100,femmes))),p(0,en,'Ukraine'))), lit(np(nom,_,_))-appl(word(0),appl(appl(word(6),word(7)),appl(appl(word(3),appl(word(4),word(5))),appl(word(2),word(1))))), [
         rule(axiom, 'Le', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dl, p(0,p(0,p(0,ratio,'hommes-femmes'),p(0,pour,p(0,100,femmes))),p(0,en,'Ukraine')), lit(n)-appl(appl(word(6),word(7)),appl(appl(word(3),appl(word(4),word(5))),appl(word(2),word(1)))), [
            rule(dl, p(0,p(0,ratio,'hommes-femmes'),p(0,pour,p(0,100,femmes))), lit(n)-appl(appl(word(3),appl(word(4),word(5))),appl(word(2),word(1))), [
               rule(dl, p(0,ratio,'hommes-femmes'), lit(n)-appl(word(2),word(1)), [
                  rule(axiom, ratio, lit(n)-word(1), []),
                  rule(axiom, 'hommes-femmes', dl(0,lit(n),lit(n))-word(2), [])
                  ]),
               rule(dr, p(0,pour,p(0,100,femmes)), dl(0,lit(n),lit(n))-appl(word(3),appl(word(4),word(5))), [
                  rule(axiom, pour, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(3), []),
                  rule(dr, p(0,100,femmes), lit(np(_,_,_))-appl(word(4),word(5)), [
                     rule(axiom, 100, dr(0,lit(np(_,_,_)),lit(n))-word(4), []),
                     rule(axiom, femmes, lit(n)-word(5), [])
                     ])
                  ])
               ]),
            rule(dr, p(0,en,'Ukraine'), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
               rule(axiom, en, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
               rule(axiom, 'Ukraine', lit(n)-word(7), [])
               ])
            ])
         ]),
      rule(dl, p(0,se,p(0,situait,p(0,entre,p(0,86,p(0,et,'.'))))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(appl(word(9),appl(word(10),appl(appl(word(12),word(13)),word(11)))),word(8)), [
         rule(axiom, se, lit(cl_r)-word(8), []),
         rule(dr, p(0,situait,p(0,entre,p(0,86,p(0,et,'.')))), dl(0,lit(cl_r),dl(0,lit(np(nom,_,_)),lit(s(main))))-appl(word(9),appl(word(10),appl(appl(word(12),word(13)),word(11)))), [
            rule(axiom, situait, dr(0,dl(0,lit(cl_r),dl(0,lit(np(nom,_,_)),lit(s(main)))),lit(pp(entre)))-word(9), []),
            rule(dr, p(0,entre,p(0,86,p(0,et,'.'))), lit(pp(entre))-appl(word(10),appl(appl(word(12),word(13)),word(11))), [
               rule(axiom, entre, dr(0,lit(pp(entre)),lit(np(acc,_,_)))-word(10), []),
               rule(dl, p(0,86,p(0,et,'.')), lit(np(acc,_,_))-appl(appl(word(12),word(13)),word(11)), [
                  rule(axiom, 86, lit(np(acc,_,_))-word(11), []),
                  rule(dr, p(0,et,'.'), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(12),word(13)), [
                     rule(axiom, et, dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(12), []),
                     rule(axiom, '.', lit(np(_,_,_))-word(13), [])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '87.', dl(0,lit(s(main)),lit(txt))-word(14), [])
   ])).

% 166. Il y avait plus de femmes que d' hommes dans le monde . 

proof(166, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,avait,p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes)))))),p(0,dans,p(0,le,monde))),'.'), lit(txt)-appl(word(12),appl(appl(word(9),appl(word(10),word(11))),appl(appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,avait,p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes)))))),p(0,dans,p(0,le,monde))), lit(s(main))-appl(appl(word(9),appl(word(10),word(11))),appl(appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,avait,p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes)))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,avait,p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,avait,p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes)))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))), [
               rule(axiom, avait, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes))), lit(np(acc,_,_))-appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8)))), [
                  rule(dr, p(0,plus,p(0,de,femmes)), dr(0,lit(np(acc,_,_)),lit(s(q)))-appl(word(3),appl(word(4),word(5))), [
                     rule(axiom, plus, dr(0,dr(0,lit(np(acc,_,_)),lit(s(q))),lit(pp(de)))-word(3), []),
                     rule(dr, p(0,de,femmes), lit(pp(de))-appl(word(4),word(5)), [
                        rule(axiom, de, dr(0,lit(pp(de)),lit(n))-word(4), []),
                        rule(axiom, femmes, lit(n)-word(5), [])
                        ])
                     ]),
                  rule(dr, p(0,que,p(0,'d\'',hommes)), lit(s(q))-appl(word(6),appl(word(7),word(8))), [
                     rule(axiom, que, dr(0,lit(s(q)),lit(pp(de)))-word(6), []),
                     rule(dr, p(0,'d\'',hommes), lit(pp(de))-appl(word(7),word(8)), [
                        rule(axiom, 'd\'', dr(0,lit(pp(de)),lit(n))-word(7), []),
                        rule(axiom, hommes, lit(n)-word(8), [])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,le,monde)), dl(1,lit(s(main)),lit(s(main)))-appl(word(9),appl(word(10),word(11))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(9), []),
         rule(dr, p(0,le,monde), lit(np(acc,_,_))-appl(word(10),word(11)), [
            rule(axiom, le, dr(0,lit(np(acc,_,_)),lit(n))-word(10), []),
            rule(axiom, monde, lit(n)-word(11), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(12), [])
   ])).

% 168. Il y avait plus d' hommes que de femmes en Ukraine . 

proof(168, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,avait,p(0,p(0,plus,p(0,'d\'',hommes)),p(0,que,p(0,de,femmes)))))),p(0,en,'Ukraine')),'.'), lit(txt)-appl(word(11),appl(appl(word(9),word(10)),appl(appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,avait,p(0,p(0,plus,p(0,'d\'',hommes)),p(0,que,p(0,de,femmes)))))),p(0,en,'Ukraine')), lit(s(main))-appl(appl(word(9),word(10)),appl(appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,avait,p(0,p(0,plus,p(0,'d\'',hommes)),p(0,que,p(0,de,femmes)))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,avait,p(0,p(0,plus,p(0,'d\'',hommes)),p(0,que,p(0,de,femmes))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,avait,p(0,p(0,plus,p(0,'d\'',hommes)),p(0,que,p(0,de,femmes)))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))), [
               rule(axiom, avait, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,p(0,plus,p(0,'d\'',hommes)),p(0,que,p(0,de,femmes))), lit(np(acc,_,_))-appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8)))), [
                  rule(dr, p(0,plus,p(0,'d\'',hommes)), dr(0,lit(np(acc,_,_)),lit(s(q)))-appl(word(3),appl(word(4),word(5))), [
                     rule(axiom, plus, dr(0,dr(0,lit(np(acc,_,_)),lit(s(q))),lit(pp(de)))-word(3), []),
                     rule(dr, p(0,'d\'',hommes), lit(pp(de))-appl(word(4),word(5)), [
                        rule(axiom, 'd\'', dr(0,lit(pp(de)),lit(n))-word(4), []),
                        rule(axiom, hommes, lit(n)-word(5), [])
                        ])
                     ]),
                  rule(dr, p(0,que,p(0,de,femmes)), lit(s(q))-appl(word(6),appl(word(7),word(8))), [
                     rule(axiom, que, dr(0,lit(s(q)),lit(pp(de)))-word(6), []),
                     rule(dr, p(0,de,femmes), lit(pp(de))-appl(word(7),word(8)), [
                        rule(axiom, de, dr(0,lit(pp(de)),lit(n))-word(7), []),
                        rule(axiom, femmes, lit(n)-word(8), [])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,en,'Ukraine'), dl(1,lit(s(main)),lit(s(main)))-appl(word(9),word(10)), [
         rule(axiom, en, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(9), []),
         rule(axiom, 'Ukraine', lit(n)-word(10), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(11), [])
   ])).

% 174. Certains hommes ne portent pas de bleu . 

proof(174, rule(dl, p(0,p(0,p(0,'Certains',hommes),p(0,ne,p(0,portent,p(0,pas,p(0,de,bleu))))),'.'), lit(txt)-appl(word(7),appl(appl(word(2),appl(word(3),appl(word(4),appl(word(5),word(6))))),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Certains',hommes),p(0,ne,p(0,portent,p(0,pas,p(0,de,bleu))))), lit(s(main))-appl(appl(word(2),appl(word(3),appl(word(4),appl(word(5),word(6))))),appl(word(0),word(1))), [
      rule(dr, p(0,'Certains',hommes), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Certains', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, hommes, lit(n)-word(1), [])
         ]),
      rule(dr, p(0,ne,p(0,portent,p(0,pas,p(0,de,bleu)))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),appl(word(3),appl(word(4),appl(word(5),word(6))))), [
         rule(axiom, ne, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(2), []),
         rule(dr, p(0,portent,p(0,pas,p(0,de,bleu))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(3),appl(word(4),appl(word(5),word(6)))), [
            rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(3), []),
            rule(dr, p(0,pas,p(0,de,bleu)), lit(np(acc,_,_))-appl(word(4),appl(word(5),word(6))), [
               rule(axiom, pas, dr(0,lit(np(acc,_,_)),lit(pp(de)))-word(4), []),
               rule(dr, p(0,de,bleu), lit(pp(de))-appl(word(5),word(6)), [
                  rule(axiom, de, dr(0,lit(pp(de)),lit(n))-word(5), []),
                  rule(axiom, bleu, lit(n)-word(6), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(7), [])
   ])).

% 180. La plupart des hommes portent du bleu . 

proof(180, rule(dl, p(0,p(0,p(0,'La',p(0,plupart,p(0,des,hommes))),p(0,portent,p(0,du,bleu))),'.'), lit(txt)-appl(word(7),appl(appl(word(4),appl(word(5),word(6))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'La',p(0,plupart,p(0,des,hommes))),p(0,portent,p(0,du,bleu))), lit(s(main))-appl(appl(word(4),appl(word(5),word(6))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'La',p(0,plupart,p(0,des,hommes))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'La', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dr, p(0,plupart,p(0,des,hommes)), lit(n)-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, plupart, dr(0,lit(n),lit(pp(de)))-word(1), []),
            rule(dr, p(0,des,hommes), lit(pp(de))-appl(word(2),word(3)), [
               rule(axiom, des, dr(0,lit(pp(de)),lit(n))-word(2), []),
               rule(axiom, hommes, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(dr, p(0,portent,p(0,du,bleu)), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),word(6))), [
         rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(4), []),
         rule(dr, p(0,du,bleu), lit(np(acc,_,_))-appl(word(5),word(6)), [
            rule(axiom, du, dr(0,lit(np(acc,_,_)),lit(n))-word(5), []),
            rule(axiom, bleu, lit(n)-word(6), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(7), [])
   ])).

% 182. Au moins deux hommes portent du rouge . 

proof(182, rule(dl, p(0,p(0,p(0,p(0,'Au',moins),p(0,deux,hommes)),p(0,portent,p(0,du,rouge))),'.'), lit(txt)-appl(word(7),appl(appl(word(4),appl(word(5),word(6))),appl(appl(word(0),word(1)),appl(word(2),word(3))))), [
   rule(dl, p(0,p(0,p(0,'Au',moins),p(0,deux,hommes)),p(0,portent,p(0,du,rouge))), lit(s(main))-appl(appl(word(4),appl(word(5),word(6))),appl(appl(word(0),word(1)),appl(word(2),word(3)))), [
      rule(dr, p(0,p(0,'Au',moins),p(0,deux,hommes)), lit(np(nom,_,_))-appl(appl(word(0),word(1)),appl(word(2),word(3))), [
         rule(dr, p(0,'Au',moins), dr(0,lit(np(nom,_,_)),lit(np(_,_,_)))-appl(word(0),word(1)), [
            rule(axiom, 'Au', dr(0,dr(0,lit(np(nom,_,_)),lit(np(_,_,_))),lit(n))-word(0), []),
            rule(axiom, moins, lit(n)-word(1), [])
            ]),
         rule(dr, p(0,deux,hommes), lit(np(_,_,_))-appl(word(2),word(3)), [
            rule(axiom, deux, dr(0,lit(np(_,_,_)),lit(n))-word(2), []),
            rule(axiom, hommes, lit(n)-word(3), [])
            ])
         ]),
      rule(dr, p(0,portent,p(0,du,rouge)), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),word(6))), [
         rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(4), []),
         rule(dr, p(0,du,rouge), lit(np(acc,_,_))-appl(word(5),word(6)), [
            rule(axiom, du, dr(0,lit(np(acc,_,_)),lit(n))-word(5), []),
            rule(axiom, rouge, lit(n)-word(6), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(7), [])
   ])).

% 201. Il y a six chats , trois chats violets , un chat noir et un chat blanc qui courent le long de l' herbe grise . 

proof(201, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))),'.'), lit(txt)-appl(word(25),appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))), lit(s(main))-appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dl, p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))), lit(np(acc,_,_))-appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))))), [
                  rule(dl, p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))), lit(np(acc,_,_))-appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))), [
                     rule(dl, p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))), lit(np(acc,_,_))-appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))), [
                        rule(dr, p(0,six,chats), lit(np(acc,_,_))-appl(word(3),word(4)), [
                           rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                           rule(axiom, chats, lit(n)-word(4), [])
                           ]),
                        rule(dr, p(0,',',p(0,trois,p(0,chats,violets))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(5),appl(word(6),appl(word(8),word(7)))), [
                           rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(5), []),
                           rule(dr, p(0,trois,p(0,chats,violets)), lit(np(_,_,_))-appl(word(6),appl(word(8),word(7))), [
                              rule(axiom, trois, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                              rule(dl, p(0,chats,violets), lit(n)-appl(word(8),word(7)), [
                                 rule(axiom, chats, lit(n)-word(7), []),
                                 rule(axiom, violets, dl(0,lit(n),lit(n))-word(8), [])
                                 ])
                              ])
                           ])
                        ]),
                     rule(dr, p(0,',',p(0,un,p(0,chat,noir))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(9),appl(word(10),appl(word(12),word(11)))), [
                        rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(9), []),
                        rule(dr, p(0,un,p(0,chat,noir)), lit(np(_,_,_))-appl(word(10),appl(word(12),word(11))), [
                           rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(10), []),
                           rule(dl, p(0,chat,noir), lit(n)-appl(word(12),word(11)), [
                              rule(axiom, chat, lit(n)-word(11), []),
                              rule(axiom, noir, dl(0,lit(n),lit(n))-word(12), [])
                              ])
                           ])
                        ])
                     ]),
                  rule(dr, p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))), [
                     rule(axiom, et, dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(13), []),
                     rule(dr, p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))), lit(np(_,_,_))-appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15)))), [
                        rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(14), []),
                        rule(dl, p(0,p(0,chat,blanc),p(0,qui,courent)), lit(n)-appl(appl(word(17),word(18)),appl(word(16),word(15))), [
                           rule(dl, p(0,chat,blanc), lit(n)-appl(word(16),word(15)), [
                              rule(axiom, chat, lit(n)-word(15), []),
                              rule(axiom, blanc, dl(0,lit(n),lit(n))-word(16), [])
                              ]),
                           rule(dr, p(0,qui,courent), dl(0,lit(n),lit(n))-appl(word(17),word(18)), [
                              rule(axiom, qui, dr(0,dl(0,lit(n),lit(n)),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(17), []),
                              rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(18), [])
                              ])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise)), dl(1,lit(s(main)),lit(s(main)))-appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))), [
         rule(axiom, le, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(19), []),
         rule(dl, p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise), lit(n)-appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20))), [
            rule(dl, p(0,long,p(0,de,p(0,'l\'',herbe))), lit(n)-appl(appl(word(21),appl(word(22),word(23))),word(20)), [
               rule(axiom, long, lit(n)-word(20), []),
               rule(dr, p(0,de,p(0,'l\'',herbe)), dl(0,lit(n),lit(n))-appl(word(21),appl(word(22),word(23))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(21), []),
                  rule(dr, p(0,'l\'',herbe), lit(np(_,_,_))-appl(word(22),word(23)), [
                     rule(axiom, 'l\'', dr(0,lit(np(_,_,_)),lit(n))-word(22), []),
                     rule(axiom, herbe, lit(n)-word(23), [])
                     ])
                  ])
               ]),
            rule(axiom, grise, dl(0,lit(n),lit(n))-word(24), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(25), [])
   ])).

% 202. Certains chats s' assoient . 

proof(202, rule(dl, p(0,p(0,p(0,'Certains',chats),p(0,'s\'',assoient)),'.'), lit(txt)-appl(word(4),appl(appl(word(3),word(2)),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Certains',chats),p(0,'s\'',assoient)), lit(s(main))-appl(appl(word(3),word(2)),appl(word(0),word(1))), [
      rule(dr, p(0,'Certains',chats), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Certains', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, chats, lit(n)-word(1), [])
         ]),
      rule(dl, p(0,'s\'',assoient), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(3),word(2)), [
         rule(axiom, 's\'', lit(cl_r)-word(2), []),
         rule(axiom, assoient, dl(0,lit(cl_r),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(3), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(4), [])
   ])).

% 203. Il y a six chats , trois chats violets , un chat noir et un chat blanc qui courent le long de l' herbe grise . 

proof(203, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))),'.'), lit(txt)-appl(word(25),appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))), lit(s(main))-appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dl, p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))), lit(np(acc,_,_))-appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))))), [
                  rule(dl, p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))), lit(np(acc,_,_))-appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))), [
                     rule(dl, p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))), lit(np(acc,_,_))-appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))), [
                        rule(dr, p(0,six,chats), lit(np(acc,_,_))-appl(word(3),word(4)), [
                           rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                           rule(axiom, chats, lit(n)-word(4), [])
                           ]),
                        rule(dr, p(0,',',p(0,trois,p(0,chats,violets))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(5),appl(word(6),appl(word(8),word(7)))), [
                           rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(5), []),
                           rule(dr, p(0,trois,p(0,chats,violets)), lit(np(_,_,_))-appl(word(6),appl(word(8),word(7))), [
                              rule(axiom, trois, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                              rule(dl, p(0,chats,violets), lit(n)-appl(word(8),word(7)), [
                                 rule(axiom, chats, lit(n)-word(7), []),
                                 rule(axiom, violets, dl(0,lit(n),lit(n))-word(8), [])
                                 ])
                              ])
                           ])
                        ]),
                     rule(dr, p(0,',',p(0,un,p(0,chat,noir))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(9),appl(word(10),appl(word(12),word(11)))), [
                        rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(9), []),
                        rule(dr, p(0,un,p(0,chat,noir)), lit(np(_,_,_))-appl(word(10),appl(word(12),word(11))), [
                           rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(10), []),
                           rule(dl, p(0,chat,noir), lit(n)-appl(word(12),word(11)), [
                              rule(axiom, chat, lit(n)-word(11), []),
                              rule(axiom, noir, dl(0,lit(n),lit(n))-word(12), [])
                              ])
                           ])
                        ])
                     ]),
                  rule(dr, p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))), [
                     rule(axiom, et, dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(13), []),
                     rule(dr, p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))), lit(np(_,_,_))-appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15)))), [
                        rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(14), []),
                        rule(dl, p(0,p(0,chat,blanc),p(0,qui,courent)), lit(n)-appl(appl(word(17),word(18)),appl(word(16),word(15))), [
                           rule(dl, p(0,chat,blanc), lit(n)-appl(word(16),word(15)), [
                              rule(axiom, chat, lit(n)-word(15), []),
                              rule(axiom, blanc, dl(0,lit(n),lit(n))-word(16), [])
                              ]),
                           rule(dr, p(0,qui,courent), dl(0,lit(n),lit(n))-appl(word(17),word(18)), [
                              rule(axiom, qui, dr(0,dl(0,lit(n),lit(n)),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(17), []),
                              rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(18), [])
                              ])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise)), dl(1,lit(s(main)),lit(s(main)))-appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))), [
         rule(axiom, le, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(19), []),
         rule(dl, p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise), lit(n)-appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20))), [
            rule(dl, p(0,long,p(0,de,p(0,'l\'',herbe))), lit(n)-appl(appl(word(21),appl(word(22),word(23))),word(20)), [
               rule(axiom, long, lit(n)-word(20), []),
               rule(dr, p(0,de,p(0,'l\'',herbe)), dl(0,lit(n),lit(n))-appl(word(21),appl(word(22),word(23))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(21), []),
                  rule(dr, p(0,'l\'',herbe), lit(np(_,_,_))-appl(word(22),word(23)), [
                     rule(axiom, 'l\'', dr(0,lit(np(_,_,_)),lit(n))-word(22), []),
                     rule(axiom, herbe, lit(n)-word(23), [])
                     ])
                  ])
               ]),
            rule(axiom, grise, dl(0,lit(n),lit(n))-word(24), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(25), [])
   ])).

% 204. Certains chats ne courent pas . 

proof(204, rule(dl, p(0,p(1,p(0,p(0,'Certains',chats),p(0,ne,courent)),pas),'.'), lit(txt)-appl(word(5),appl(word(4),appl(appl(word(2),word(3)),appl(word(0),word(1))))), [
   rule(dl, p(1,p(0,p(0,'Certains',chats),p(0,ne,courent)),pas), lit(s(main))-appl(word(4),appl(appl(word(2),word(3)),appl(word(0),word(1)))), [
      rule(dl, p(0,p(0,'Certains',chats),p(0,ne,courent)), lit(s(main))-appl(appl(word(2),word(3)),appl(word(0),word(1))), [
         rule(dr, p(0,'Certains',chats), lit(np(nom,_,_))-appl(word(0),word(1)), [
            rule(axiom, 'Certains', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
            rule(axiom, chats, lit(n)-word(1), [])
            ]),
         rule(dr, p(0,ne,courent), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),word(3)), [
            rule(axiom, ne, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(2), []),
            rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(3), [])
            ])
         ]),
      rule(axiom, pas, dl(1,lit(s(main)),lit(s(main)))-word(4), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(5), [])
   ])).

% 205. Il y a six chats , trois chats violets , un chat noir et un chat blanc qui courent le long de l' herbe grise . 

proof(205, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))),'.'), lit(txt)-appl(word(25),appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))), lit(s(main))-appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dl, p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))), lit(np(acc,_,_))-appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))))), [
                  rule(dl, p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))), lit(np(acc,_,_))-appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))), [
                     rule(dl, p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))), lit(np(acc,_,_))-appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))), [
                        rule(dr, p(0,six,chats), lit(np(acc,_,_))-appl(word(3),word(4)), [
                           rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                           rule(axiom, chats, lit(n)-word(4), [])
                           ]),
                        rule(dr, p(0,',',p(0,trois,p(0,chats,violets))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(5),appl(word(6),appl(word(8),word(7)))), [
                           rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(5), []),
                           rule(dr, p(0,trois,p(0,chats,violets)), lit(np(_,_,_))-appl(word(6),appl(word(8),word(7))), [
                              rule(axiom, trois, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                              rule(dl, p(0,chats,violets), lit(n)-appl(word(8),word(7)), [
                                 rule(axiom, chats, lit(n)-word(7), []),
                                 rule(axiom, violets, dl(0,lit(n),lit(n))-word(8), [])
                                 ])
                              ])
                           ])
                        ]),
                     rule(dr, p(0,',',p(0,un,p(0,chat,noir))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(9),appl(word(10),appl(word(12),word(11)))), [
                        rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(9), []),
                        rule(dr, p(0,un,p(0,chat,noir)), lit(np(_,_,_))-appl(word(10),appl(word(12),word(11))), [
                           rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(10), []),
                           rule(dl, p(0,chat,noir), lit(n)-appl(word(12),word(11)), [
                              rule(axiom, chat, lit(n)-word(11), []),
                              rule(axiom, noir, dl(0,lit(n),lit(n))-word(12), [])
                              ])
                           ])
                        ])
                     ]),
                  rule(dr, p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))), [
                     rule(axiom, et, dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(13), []),
                     rule(dr, p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))), lit(np(_,_,_))-appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15)))), [
                        rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(14), []),
                        rule(dl, p(0,p(0,chat,blanc),p(0,qui,courent)), lit(n)-appl(appl(word(17),word(18)),appl(word(16),word(15))), [
                           rule(dl, p(0,chat,blanc), lit(n)-appl(word(16),word(15)), [
                              rule(axiom, chat, lit(n)-word(15), []),
                              rule(axiom, blanc, dl(0,lit(n),lit(n))-word(16), [])
                              ]),
                           rule(dr, p(0,qui,courent), dl(0,lit(n),lit(n))-appl(word(17),word(18)), [
                              rule(axiom, qui, dr(0,dl(0,lit(n),lit(n)),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(17), []),
                              rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(18), [])
                              ])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise)), dl(1,lit(s(main)),lit(s(main)))-appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))), [
         rule(axiom, le, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(19), []),
         rule(dl, p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise), lit(n)-appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20))), [
            rule(dl, p(0,long,p(0,de,p(0,'l\'',herbe))), lit(n)-appl(appl(word(21),appl(word(22),word(23))),word(20)), [
               rule(axiom, long, lit(n)-word(20), []),
               rule(dr, p(0,de,p(0,'l\'',herbe)), dl(0,lit(n),lit(n))-appl(word(21),appl(word(22),word(23))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(21), []),
                  rule(dr, p(0,'l\'',herbe), lit(np(_,_,_))-appl(word(22),word(23)), [
                     rule(axiom, 'l\'', dr(0,lit(np(_,_,_)),lit(n))-word(22), []),
                     rule(axiom, herbe, lit(n)-word(23), [])
                     ])
                  ])
               ]),
            rule(axiom, grise, dl(0,lit(n),lit(n))-word(24), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(25), [])
   ])).

% 206. Tout chat court . 

proof(206, rule(dl, p(0,p(0,p(0,'Tout',chat),court),'.'), lit(txt)-appl(word(3),appl(word(2),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Tout',chat),court), lit(s(main))-appl(word(2),appl(word(0),word(1))), [
      rule(dr, p(0,'Tout',chat), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Tout', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, chat, lit(n)-word(1), [])
         ]),
      rule(axiom, court, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(2), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(3), [])
   ])).

% 207. Il y a six chats , trois chats violets , un chat noir et un chat blanc qui courent le long de l' herbe grise . 

proof(207, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))),'.'), lit(txt)-appl(word(25),appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))), lit(s(main))-appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dl, p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))), lit(np(acc,_,_))-appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))))), [
                  rule(dl, p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))), lit(np(acc,_,_))-appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))), [
                     rule(dl, p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))), lit(np(acc,_,_))-appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))), [
                        rule(dr, p(0,six,chats), lit(np(acc,_,_))-appl(word(3),word(4)), [
                           rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                           rule(axiom, chats, lit(n)-word(4), [])
                           ]),
                        rule(dr, p(0,',',p(0,trois,p(0,chats,violets))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(5),appl(word(6),appl(word(8),word(7)))), [
                           rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(5), []),
                           rule(dr, p(0,trois,p(0,chats,violets)), lit(np(_,_,_))-appl(word(6),appl(word(8),word(7))), [
                              rule(axiom, trois, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                              rule(dl, p(0,chats,violets), lit(n)-appl(word(8),word(7)), [
                                 rule(axiom, chats, lit(n)-word(7), []),
                                 rule(axiom, violets, dl(0,lit(n),lit(n))-word(8), [])
                                 ])
                              ])
                           ])
                        ]),
                     rule(dr, p(0,',',p(0,un,p(0,chat,noir))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(9),appl(word(10),appl(word(12),word(11)))), [
                        rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(9), []),
                        rule(dr, p(0,un,p(0,chat,noir)), lit(np(_,_,_))-appl(word(10),appl(word(12),word(11))), [
                           rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(10), []),
                           rule(dl, p(0,chat,noir), lit(n)-appl(word(12),word(11)), [
                              rule(axiom, chat, lit(n)-word(11), []),
                              rule(axiom, noir, dl(0,lit(n),lit(n))-word(12), [])
                              ])
                           ])
                        ])
                     ]),
                  rule(dr, p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))), [
                     rule(axiom, et, dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(13), []),
                     rule(dr, p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))), lit(np(_,_,_))-appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15)))), [
                        rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(14), []),
                        rule(dl, p(0,p(0,chat,blanc),p(0,qui,courent)), lit(n)-appl(appl(word(17),word(18)),appl(word(16),word(15))), [
                           rule(dl, p(0,chat,blanc), lit(n)-appl(word(16),word(15)), [
                              rule(axiom, chat, lit(n)-word(15), []),
                              rule(axiom, blanc, dl(0,lit(n),lit(n))-word(16), [])
                              ]),
                           rule(dr, p(0,qui,courent), dl(0,lit(n),lit(n))-appl(word(17),word(18)), [
                              rule(axiom, qui, dr(0,dl(0,lit(n),lit(n)),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(17), []),
                              rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(18), [])
                              ])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise)), dl(1,lit(s(main)),lit(s(main)))-appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))), [
         rule(axiom, le, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(19), []),
         rule(dl, p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise), lit(n)-appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20))), [
            rule(dl, p(0,long,p(0,de,p(0,'l\'',herbe))), lit(n)-appl(appl(word(21),appl(word(22),word(23))),word(20)), [
               rule(axiom, long, lit(n)-word(20), []),
               rule(dr, p(0,de,p(0,'l\'',herbe)), dl(0,lit(n),lit(n))-appl(word(21),appl(word(22),word(23))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(21), []),
                  rule(dr, p(0,'l\'',herbe), lit(np(_,_,_))-appl(word(22),word(23)), [
                     rule(axiom, 'l\'', dr(0,lit(np(_,_,_)),lit(n))-word(22), []),
                     rule(axiom, herbe, lit(n)-word(23), [])
                     ])
                  ])
               ]),
            rule(axiom, grise, dl(0,lit(n),lit(n))-word(24), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(25), [])
   ])).

% 208. Plus d' un chat est assis . 

proof(208, rule(dl, p(0,p(0,p(0,'Plus',p(0,'d\'',p(0,un,chat))),p(0,est,assis)),'.'), lit(txt)-appl(word(6),appl(appl(word(4),word(5)),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'Plus',p(0,'d\'',p(0,un,chat))),p(0,est,assis)), lit(s(main))-appl(appl(word(4),word(5)),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'Plus',p(0,'d\'',p(0,un,chat))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
         rule(dr, p(0,'d\'',p(0,un,chat)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, 'd\'', dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
            rule(dr, p(0,un,chat), lit(np(acc,_,_))-appl(word(2),word(3)), [
               rule(axiom, un, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
               rule(axiom, chat, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(dr, p(0,est,assis), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),word(5)), [
         rule(axiom, est, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(pass))))-word(4), []),
         rule(axiom, assis, dl(0,lit(np(nom,_,_)),lit(s(pass)))-word(5), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(6), [])
   ])).

% 209. Il y a six chats , trois chats violets , un chat noir et un chat blanc qui courent le long de l' herbe grise . 

proof(209, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))),'.'), lit(txt)-appl(word(25),appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))), lit(s(main))-appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dl, p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))), lit(np(acc,_,_))-appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))))), [
                  rule(dl, p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))), lit(np(acc,_,_))-appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))), [
                     rule(dl, p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))), lit(np(acc,_,_))-appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))), [
                        rule(dr, p(0,six,chats), lit(np(acc,_,_))-appl(word(3),word(4)), [
                           rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                           rule(axiom, chats, lit(n)-word(4), [])
                           ]),
                        rule(dr, p(0,',',p(0,trois,p(0,chats,violets))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(5),appl(word(6),appl(word(8),word(7)))), [
                           rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(5), []),
                           rule(dr, p(0,trois,p(0,chats,violets)), lit(np(_,_,_))-appl(word(6),appl(word(8),word(7))), [
                              rule(axiom, trois, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                              rule(dl, p(0,chats,violets), lit(n)-appl(word(8),word(7)), [
                                 rule(axiom, chats, lit(n)-word(7), []),
                                 rule(axiom, violets, dl(0,lit(n),lit(n))-word(8), [])
                                 ])
                              ])
                           ])
                        ]),
                     rule(dr, p(0,',',p(0,un,p(0,chat,noir))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(9),appl(word(10),appl(word(12),word(11)))), [
                        rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(9), []),
                        rule(dr, p(0,un,p(0,chat,noir)), lit(np(_,_,_))-appl(word(10),appl(word(12),word(11))), [
                           rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(10), []),
                           rule(dl, p(0,chat,noir), lit(n)-appl(word(12),word(11)), [
                              rule(axiom, chat, lit(n)-word(11), []),
                              rule(axiom, noir, dl(0,lit(n),lit(n))-word(12), [])
                              ])
                           ])
                        ])
                     ]),
                  rule(dr, p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))), [
                     rule(axiom, et, dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(13), []),
                     rule(dr, p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))), lit(np(_,_,_))-appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15)))), [
                        rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(14), []),
                        rule(dl, p(0,p(0,chat,blanc),p(0,qui,courent)), lit(n)-appl(appl(word(17),word(18)),appl(word(16),word(15))), [
                           rule(dl, p(0,chat,blanc), lit(n)-appl(word(16),word(15)), [
                              rule(axiom, chat, lit(n)-word(15), []),
                              rule(axiom, blanc, dl(0,lit(n),lit(n))-word(16), [])
                              ]),
                           rule(dr, p(0,qui,courent), dl(0,lit(n),lit(n))-appl(word(17),word(18)), [
                              rule(axiom, qui, dr(0,dl(0,lit(n),lit(n)),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(17), []),
                              rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(18), [])
                              ])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise)), dl(1,lit(s(main)),lit(s(main)))-appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))), [
         rule(axiom, le, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(19), []),
         rule(dl, p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise), lit(n)-appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20))), [
            rule(dl, p(0,long,p(0,de,p(0,'l\'',herbe))), lit(n)-appl(appl(word(21),appl(word(22),word(23))),word(20)), [
               rule(axiom, long, lit(n)-word(20), []),
               rule(dr, p(0,de,p(0,'l\'',herbe)), dl(0,lit(n),lit(n))-appl(word(21),appl(word(22),word(23))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(21), []),
                  rule(dr, p(0,'l\'',herbe), lit(np(_,_,_))-appl(word(22),word(23)), [
                     rule(axiom, 'l\'', dr(0,lit(np(_,_,_)),lit(n))-word(22), []),
                     rule(axiom, herbe, lit(n)-word(23), [])
                     ])
                  ])
               ]),
            rule(axiom, grise, dl(0,lit(n),lit(n))-word(24), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(25), [])
   ])).

% 210. Tous les chats courent . 

proof(210, rule(dl, p(0,p(0,p(0,'Tous',p(0,les,chats)),courent),'.'), lit(txt)-appl(word(4),appl(word(3),appl(word(0),appl(word(1),word(2))))), [
   rule(dl, p(0,p(0,'Tous',p(0,les,chats)),courent), lit(s(main))-appl(word(3),appl(word(0),appl(word(1),word(2)))), [
      rule(dr, p(0,'Tous',p(0,les,chats)), lit(np(nom,_,_))-appl(word(0),appl(word(1),word(2))), [
         rule(axiom, 'Tous', dr(0,lit(np(nom,_,_)),lit(np(_,_,_)))-word(0), []),
         rule(dr, p(0,les,chats), lit(np(_,_,_))-appl(word(1),word(2)), [
            rule(axiom, les, dr(0,lit(np(_,_,_)),lit(n))-word(1), []),
            rule(axiom, chats, lit(n)-word(2), [])
            ])
         ]),
      rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(3), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(4), [])
   ])).

% 211. Il y a six chats , trois chats violets , un chat noir et un chat blanc qui courent le long de l' herbe grise . 

proof(211, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))),'.'), lit(txt)-appl(word(25),appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))), lit(s(main))-appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dl, p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))), lit(np(acc,_,_))-appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))))), [
                  rule(dl, p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))), lit(np(acc,_,_))-appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))), [
                     rule(dl, p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))), lit(np(acc,_,_))-appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))), [
                        rule(dr, p(0,six,chats), lit(np(acc,_,_))-appl(word(3),word(4)), [
                           rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                           rule(axiom, chats, lit(n)-word(4), [])
                           ]),
                        rule(dr, p(0,',',p(0,trois,p(0,chats,violets))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(5),appl(word(6),appl(word(8),word(7)))), [
                           rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(5), []),
                           rule(dr, p(0,trois,p(0,chats,violets)), lit(np(_,_,_))-appl(word(6),appl(word(8),word(7))), [
                              rule(axiom, trois, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                              rule(dl, p(0,chats,violets), lit(n)-appl(word(8),word(7)), [
                                 rule(axiom, chats, lit(n)-word(7), []),
                                 rule(axiom, violets, dl(0,lit(n),lit(n))-word(8), [])
                                 ])
                              ])
                           ])
                        ]),
                     rule(dr, p(0,',',p(0,un,p(0,chat,noir))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(9),appl(word(10),appl(word(12),word(11)))), [
                        rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(9), []),
                        rule(dr, p(0,un,p(0,chat,noir)), lit(np(_,_,_))-appl(word(10),appl(word(12),word(11))), [
                           rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(10), []),
                           rule(dl, p(0,chat,noir), lit(n)-appl(word(12),word(11)), [
                              rule(axiom, chat, lit(n)-word(11), []),
                              rule(axiom, noir, dl(0,lit(n),lit(n))-word(12), [])
                              ])
                           ])
                        ])
                     ]),
                  rule(dr, p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))), [
                     rule(axiom, et, dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(13), []),
                     rule(dr, p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))), lit(np(_,_,_))-appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15)))), [
                        rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(14), []),
                        rule(dl, p(0,p(0,chat,blanc),p(0,qui,courent)), lit(n)-appl(appl(word(17),word(18)),appl(word(16),word(15))), [
                           rule(dl, p(0,chat,blanc), lit(n)-appl(word(16),word(15)), [
                              rule(axiom, chat, lit(n)-word(15), []),
                              rule(axiom, blanc, dl(0,lit(n),lit(n))-word(16), [])
                              ]),
                           rule(dr, p(0,qui,courent), dl(0,lit(n),lit(n))-appl(word(17),word(18)), [
                              rule(axiom, qui, dr(0,dl(0,lit(n),lit(n)),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(17), []),
                              rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(18), [])
                              ])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise)), dl(1,lit(s(main)),lit(s(main)))-appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))), [
         rule(axiom, le, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(19), []),
         rule(dl, p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise), lit(n)-appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20))), [
            rule(dl, p(0,long,p(0,de,p(0,'l\'',herbe))), lit(n)-appl(appl(word(21),appl(word(22),word(23))),word(20)), [
               rule(axiom, long, lit(n)-word(20), []),
               rule(dr, p(0,de,p(0,'l\'',herbe)), dl(0,lit(n),lit(n))-appl(word(21),appl(word(22),word(23))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(21), []),
                  rule(dr, p(0,'l\'',herbe), lit(np(_,_,_))-appl(word(22),word(23)), [
                     rule(axiom, 'l\'', dr(0,lit(np(_,_,_)),lit(n))-word(22), []),
                     rule(axiom, herbe, lit(n)-word(23), [])
                     ])
                  ])
               ]),
            rule(axiom, grise, dl(0,lit(n),lit(n))-word(24), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(25), [])
   ])).

% 212. Plus de deux chats courent . 

proof(212, rule(dl, p(0,p(0,p(0,'Plus',p(0,de,p(0,deux,chats))),courent),'.'), lit(txt)-appl(word(5),appl(word(4),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'Plus',p(0,de,p(0,deux,chats))),courent), lit(s(main))-appl(word(4),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'Plus',p(0,de,p(0,deux,chats))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
         rule(dr, p(0,de,p(0,deux,chats)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
            rule(dr, p(0,deux,chats), lit(np(acc,_,_))-appl(word(2),word(3)), [
               rule(axiom, deux, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
               rule(axiom, chats, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(4), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(5), [])
   ])).

% 213. Il y a six chats , trois chats violets , un chat noir et un chat blanc qui courent le long de l' herbe grise . 

proof(213, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))),'.'), lit(txt)-appl(word(25),appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))), lit(s(main))-appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dl, p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))), lit(np(acc,_,_))-appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))))), [
                  rule(dl, p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))), lit(np(acc,_,_))-appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))), [
                     rule(dl, p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))), lit(np(acc,_,_))-appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))), [
                        rule(dr, p(0,six,chats), lit(np(acc,_,_))-appl(word(3),word(4)), [
                           rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                           rule(axiom, chats, lit(n)-word(4), [])
                           ]),
                        rule(dr, p(0,',',p(0,trois,p(0,chats,violets))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(5),appl(word(6),appl(word(8),word(7)))), [
                           rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(5), []),
                           rule(dr, p(0,trois,p(0,chats,violets)), lit(np(_,_,_))-appl(word(6),appl(word(8),word(7))), [
                              rule(axiom, trois, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                              rule(dl, p(0,chats,violets), lit(n)-appl(word(8),word(7)), [
                                 rule(axiom, chats, lit(n)-word(7), []),
                                 rule(axiom, violets, dl(0,lit(n),lit(n))-word(8), [])
                                 ])
                              ])
                           ])
                        ]),
                     rule(dr, p(0,',',p(0,un,p(0,chat,noir))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(9),appl(word(10),appl(word(12),word(11)))), [
                        rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(9), []),
                        rule(dr, p(0,un,p(0,chat,noir)), lit(np(_,_,_))-appl(word(10),appl(word(12),word(11))), [
                           rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(10), []),
                           rule(dl, p(0,chat,noir), lit(n)-appl(word(12),word(11)), [
                              rule(axiom, chat, lit(n)-word(11), []),
                              rule(axiom, noir, dl(0,lit(n),lit(n))-word(12), [])
                              ])
                           ])
                        ])
                     ]),
                  rule(dr, p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))), [
                     rule(axiom, et, dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(13), []),
                     rule(dr, p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))), lit(np(_,_,_))-appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15)))), [
                        rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(14), []),
                        rule(dl, p(0,p(0,chat,blanc),p(0,qui,courent)), lit(n)-appl(appl(word(17),word(18)),appl(word(16),word(15))), [
                           rule(dl, p(0,chat,blanc), lit(n)-appl(word(16),word(15)), [
                              rule(axiom, chat, lit(n)-word(15), []),
                              rule(axiom, blanc, dl(0,lit(n),lit(n))-word(16), [])
                              ]),
                           rule(dr, p(0,qui,courent), dl(0,lit(n),lit(n))-appl(word(17),word(18)), [
                              rule(axiom, qui, dr(0,dl(0,lit(n),lit(n)),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(17), []),
                              rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(18), [])
                              ])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise)), dl(1,lit(s(main)),lit(s(main)))-appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))), [
         rule(axiom, le, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(19), []),
         rule(dl, p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise), lit(n)-appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20))), [
            rule(dl, p(0,long,p(0,de,p(0,'l\'',herbe))), lit(n)-appl(appl(word(21),appl(word(22),word(23))),word(20)), [
               rule(axiom, long, lit(n)-word(20), []),
               rule(dr, p(0,de,p(0,'l\'',herbe)), dl(0,lit(n),lit(n))-appl(word(21),appl(word(22),word(23))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(21), []),
                  rule(dr, p(0,'l\'',herbe), lit(np(_,_,_))-appl(word(22),word(23)), [
                     rule(axiom, 'l\'', dr(0,lit(np(_,_,_)),lit(n))-word(22), []),
                     rule(axiom, herbe, lit(n)-word(23), [])
                     ])
                  ])
               ]),
            rule(axiom, grise, dl(0,lit(n),lit(n))-word(24), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(25), [])
   ])).

% 214. Plus de quatre chats sont assis . 

proof(214, rule(dl, p(0,p(0,p(0,'Plus',p(0,de,p(0,quatre,chats))),p(0,sont,assis)),'.'), lit(txt)-appl(word(6),appl(appl(word(4),word(5)),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'Plus',p(0,de,p(0,quatre,chats))),p(0,sont,assis)), lit(s(main))-appl(appl(word(4),word(5)),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'Plus',p(0,de,p(0,quatre,chats))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
         rule(dr, p(0,de,p(0,quatre,chats)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
            rule(dr, p(0,quatre,chats), lit(np(acc,_,_))-appl(word(2),word(3)), [
               rule(axiom, quatre, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
               rule(axiom, chats, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(dr, p(0,sont,assis), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),word(5)), [
         rule(axiom, sont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(pass))))-word(4), []),
         rule(axiom, assis, dl(0,lit(np(nom,_,_)),lit(s(pass)))-word(5), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(6), [])
   ])).

% 215. Il y a six chats , trois chats violets , un chat noir et un chat blanc qui courent le long de l' herbe grise . 

proof(215, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))),'.'), lit(txt)-appl(word(25),appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))), lit(s(main))-appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dl, p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))), lit(np(acc,_,_))-appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))))), [
                  rule(dl, p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))), lit(np(acc,_,_))-appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))), [
                     rule(dl, p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))), lit(np(acc,_,_))-appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))), [
                        rule(dr, p(0,six,chats), lit(np(acc,_,_))-appl(word(3),word(4)), [
                           rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                           rule(axiom, chats, lit(n)-word(4), [])
                           ]),
                        rule(dr, p(0,',',p(0,trois,p(0,chats,violets))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(5),appl(word(6),appl(word(8),word(7)))), [
                           rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(5), []),
                           rule(dr, p(0,trois,p(0,chats,violets)), lit(np(_,_,_))-appl(word(6),appl(word(8),word(7))), [
                              rule(axiom, trois, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                              rule(dl, p(0,chats,violets), lit(n)-appl(word(8),word(7)), [
                                 rule(axiom, chats, lit(n)-word(7), []),
                                 rule(axiom, violets, dl(0,lit(n),lit(n))-word(8), [])
                                 ])
                              ])
                           ])
                        ]),
                     rule(dr, p(0,',',p(0,un,p(0,chat,noir))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(9),appl(word(10),appl(word(12),word(11)))), [
                        rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(9), []),
                        rule(dr, p(0,un,p(0,chat,noir)), lit(np(_,_,_))-appl(word(10),appl(word(12),word(11))), [
                           rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(10), []),
                           rule(dl, p(0,chat,noir), lit(n)-appl(word(12),word(11)), [
                              rule(axiom, chat, lit(n)-word(11), []),
                              rule(axiom, noir, dl(0,lit(n),lit(n))-word(12), [])
                              ])
                           ])
                        ])
                     ]),
                  rule(dr, p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))), [
                     rule(axiom, et, dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(13), []),
                     rule(dr, p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))), lit(np(_,_,_))-appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15)))), [
                        rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(14), []),
                        rule(dl, p(0,p(0,chat,blanc),p(0,qui,courent)), lit(n)-appl(appl(word(17),word(18)),appl(word(16),word(15))), [
                           rule(dl, p(0,chat,blanc), lit(n)-appl(word(16),word(15)), [
                              rule(axiom, chat, lit(n)-word(15), []),
                              rule(axiom, blanc, dl(0,lit(n),lit(n))-word(16), [])
                              ]),
                           rule(dr, p(0,qui,courent), dl(0,lit(n),lit(n))-appl(word(17),word(18)), [
                              rule(axiom, qui, dr(0,dl(0,lit(n),lit(n)),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(17), []),
                              rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(18), [])
                              ])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise)), dl(1,lit(s(main)),lit(s(main)))-appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))), [
         rule(axiom, le, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(19), []),
         rule(dl, p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise), lit(n)-appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20))), [
            rule(dl, p(0,long,p(0,de,p(0,'l\'',herbe))), lit(n)-appl(appl(word(21),appl(word(22),word(23))),word(20)), [
               rule(axiom, long, lit(n)-word(20), []),
               rule(dr, p(0,de,p(0,'l\'',herbe)), dl(0,lit(n),lit(n))-appl(word(21),appl(word(22),word(23))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(21), []),
                  rule(dr, p(0,'l\'',herbe), lit(np(_,_,_))-appl(word(22),word(23)), [
                     rule(axiom, 'l\'', dr(0,lit(np(_,_,_)),lit(n))-word(22), []),
                     rule(axiom, herbe, lit(n)-word(23), [])
                     ])
                  ])
               ]),
            rule(axiom, grise, dl(0,lit(n),lit(n))-word(24), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(25), [])
   ])).

% 216. Plus de 3 chats ne s' assoient pas . 

proof(216, rule(dl, p(0,p(1,p(0,p(0,'Plus',p(0,de,p(0,3,chats))),p(0,ne,p(0,'s\'',assoient))),pas),'.'), lit(txt)-appl(word(8),appl(word(7),appl(appl(word(4),appl(word(6),word(5))),appl(word(0),appl(word(1),appl(word(2),word(3))))))), [
   rule(dl, p(1,p(0,p(0,'Plus',p(0,de,p(0,3,chats))),p(0,ne,p(0,'s\'',assoient))),pas), lit(s(main))-appl(word(7),appl(appl(word(4),appl(word(6),word(5))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
      rule(dl, p(0,p(0,'Plus',p(0,de,p(0,3,chats))),p(0,ne,p(0,'s\'',assoient))), lit(s(main))-appl(appl(word(4),appl(word(6),word(5))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
         rule(dr, p(0,'Plus',p(0,de,p(0,3,chats))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
            rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
            rule(dr, p(0,de,p(0,3,chats)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
               rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
               rule(dr, p(0,3,chats), lit(np(acc,_,_))-appl(word(2),word(3)), [
                  rule(axiom, 3, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
                  rule(axiom, chats, lit(n)-word(3), [])
                  ])
               ])
            ]),
         rule(dr, p(0,ne,p(0,'s\'',assoient)), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(6),word(5))), [
            rule(axiom, ne, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(4), []),
            rule(dl, p(0,'s\'',assoient), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(6),word(5)), [
               rule(axiom, 's\'', lit(cl_r)-word(5), []),
               rule(axiom, assoient, dl(0,lit(cl_r),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(6), [])
               ])
            ])
         ]),
      rule(axiom, pas, dl(1,lit(s(main)),lit(s(main)))-word(7), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(8), [])
   ])).

% 217. Il y a six chats , trois chats violets , un chat noir et un chat blanc qui courent le long de l' herbe grise . 

proof(217, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))),'.'), lit(txt)-appl(word(25),appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))), lit(s(main))-appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dl, p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))), lit(np(acc,_,_))-appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))))), [
                  rule(dl, p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))), lit(np(acc,_,_))-appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))), [
                     rule(dl, p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))), lit(np(acc,_,_))-appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))), [
                        rule(dr, p(0,six,chats), lit(np(acc,_,_))-appl(word(3),word(4)), [
                           rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                           rule(axiom, chats, lit(n)-word(4), [])
                           ]),
                        rule(dr, p(0,',',p(0,trois,p(0,chats,violets))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(5),appl(word(6),appl(word(8),word(7)))), [
                           rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(5), []),
                           rule(dr, p(0,trois,p(0,chats,violets)), lit(np(_,_,_))-appl(word(6),appl(word(8),word(7))), [
                              rule(axiom, trois, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                              rule(dl, p(0,chats,violets), lit(n)-appl(word(8),word(7)), [
                                 rule(axiom, chats, lit(n)-word(7), []),
                                 rule(axiom, violets, dl(0,lit(n),lit(n))-word(8), [])
                                 ])
                              ])
                           ])
                        ]),
                     rule(dr, p(0,',',p(0,un,p(0,chat,noir))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(9),appl(word(10),appl(word(12),word(11)))), [
                        rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(9), []),
                        rule(dr, p(0,un,p(0,chat,noir)), lit(np(_,_,_))-appl(word(10),appl(word(12),word(11))), [
                           rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(10), []),
                           rule(dl, p(0,chat,noir), lit(n)-appl(word(12),word(11)), [
                              rule(axiom, chat, lit(n)-word(11), []),
                              rule(axiom, noir, dl(0,lit(n),lit(n))-word(12), [])
                              ])
                           ])
                        ])
                     ]),
                  rule(dr, p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))), [
                     rule(axiom, et, dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(13), []),
                     rule(dr, p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))), lit(np(_,_,_))-appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15)))), [
                        rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(14), []),
                        rule(dl, p(0,p(0,chat,blanc),p(0,qui,courent)), lit(n)-appl(appl(word(17),word(18)),appl(word(16),word(15))), [
                           rule(dl, p(0,chat,blanc), lit(n)-appl(word(16),word(15)), [
                              rule(axiom, chat, lit(n)-word(15), []),
                              rule(axiom, blanc, dl(0,lit(n),lit(n))-word(16), [])
                              ]),
                           rule(dr, p(0,qui,courent), dl(0,lit(n),lit(n))-appl(word(17),word(18)), [
                              rule(axiom, qui, dr(0,dl(0,lit(n),lit(n)),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(17), []),
                              rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(18), [])
                              ])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise)), dl(1,lit(s(main)),lit(s(main)))-appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))), [
         rule(axiom, le, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(19), []),
         rule(dl, p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise), lit(n)-appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20))), [
            rule(dl, p(0,long,p(0,de,p(0,'l\'',herbe))), lit(n)-appl(appl(word(21),appl(word(22),word(23))),word(20)), [
               rule(axiom, long, lit(n)-word(20), []),
               rule(dr, p(0,de,p(0,'l\'',herbe)), dl(0,lit(n),lit(n))-appl(word(21),appl(word(22),word(23))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(21), []),
                  rule(dr, p(0,'l\'',herbe), lit(np(_,_,_))-appl(word(22),word(23)), [
                     rule(axiom, 'l\'', dr(0,lit(np(_,_,_)),lit(n))-word(22), []),
                     rule(axiom, herbe, lit(n)-word(23), [])
                     ])
                  ])
               ]),
            rule(axiom, grise, dl(0,lit(n),lit(n))-word(24), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(25), [])
   ])).

% 218. Moins de six chats courent . 

proof(218, rule(dl, p(0,p(0,p(0,'Moins',p(0,de,p(0,six,chats))),courent),'.'), lit(txt)-appl(word(5),appl(word(4),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'Moins',p(0,de,p(0,six,chats))),courent), lit(s(main))-appl(word(4),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'Moins',p(0,de,p(0,six,chats))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'Moins', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
         rule(dr, p(0,de,p(0,six,chats)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
            rule(dr, p(0,six,chats), lit(np(acc,_,_))-appl(word(2),word(3)), [
               rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
               rule(axiom, chats, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(4), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(5), [])
   ])).

% 219. Il y a six chats , trois chats violets , un chat noir et un chat blanc qui courent le long de l' herbe grise . 

proof(219, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))),'.'), lit(txt)-appl(word(25),appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))), lit(s(main))-appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dl, p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))), lit(np(acc,_,_))-appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))))), [
                  rule(dl, p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))), lit(np(acc,_,_))-appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))), [
                     rule(dl, p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))), lit(np(acc,_,_))-appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))), [
                        rule(dr, p(0,six,chats), lit(np(acc,_,_))-appl(word(3),word(4)), [
                           rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                           rule(axiom, chats, lit(n)-word(4), [])
                           ]),
                        rule(dr, p(0,',',p(0,trois,p(0,chats,violets))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(5),appl(word(6),appl(word(8),word(7)))), [
                           rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(5), []),
                           rule(dr, p(0,trois,p(0,chats,violets)), lit(np(_,_,_))-appl(word(6),appl(word(8),word(7))), [
                              rule(axiom, trois, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                              rule(dl, p(0,chats,violets), lit(n)-appl(word(8),word(7)), [
                                 rule(axiom, chats, lit(n)-word(7), []),
                                 rule(axiom, violets, dl(0,lit(n),lit(n))-word(8), [])
                                 ])
                              ])
                           ])
                        ]),
                     rule(dr, p(0,',',p(0,un,p(0,chat,noir))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(9),appl(word(10),appl(word(12),word(11)))), [
                        rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(9), []),
                        rule(dr, p(0,un,p(0,chat,noir)), lit(np(_,_,_))-appl(word(10),appl(word(12),word(11))), [
                           rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(10), []),
                           rule(dl, p(0,chat,noir), lit(n)-appl(word(12),word(11)), [
                              rule(axiom, chat, lit(n)-word(11), []),
                              rule(axiom, noir, dl(0,lit(n),lit(n))-word(12), [])
                              ])
                           ])
                        ])
                     ]),
                  rule(dr, p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))), [
                     rule(axiom, et, dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(13), []),
                     rule(dr, p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))), lit(np(_,_,_))-appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15)))), [
                        rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(14), []),
                        rule(dl, p(0,p(0,chat,blanc),p(0,qui,courent)), lit(n)-appl(appl(word(17),word(18)),appl(word(16),word(15))), [
                           rule(dl, p(0,chat,blanc), lit(n)-appl(word(16),word(15)), [
                              rule(axiom, chat, lit(n)-word(15), []),
                              rule(axiom, blanc, dl(0,lit(n),lit(n))-word(16), [])
                              ]),
                           rule(dr, p(0,qui,courent), dl(0,lit(n),lit(n))-appl(word(17),word(18)), [
                              rule(axiom, qui, dr(0,dl(0,lit(n),lit(n)),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(17), []),
                              rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(18), [])
                              ])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise)), dl(1,lit(s(main)),lit(s(main)))-appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))), [
         rule(axiom, le, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(19), []),
         rule(dl, p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise), lit(n)-appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20))), [
            rule(dl, p(0,long,p(0,de,p(0,'l\'',herbe))), lit(n)-appl(appl(word(21),appl(word(22),word(23))),word(20)), [
               rule(axiom, long, lit(n)-word(20), []),
               rule(dr, p(0,de,p(0,'l\'',herbe)), dl(0,lit(n),lit(n))-appl(word(21),appl(word(22),word(23))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(21), []),
                  rule(dr, p(0,'l\'',herbe), lit(np(_,_,_))-appl(word(22),word(23)), [
                     rule(axiom, 'l\'', dr(0,lit(np(_,_,_)),lit(n))-word(22), []),
                     rule(axiom, herbe, lit(n)-word(23), [])
                     ])
                  ])
               ]),
            rule(axiom, grise, dl(0,lit(n),lit(n))-word(24), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(25), [])
   ])).

% 220. Un chat est assis . 

proof(220, rule(dl, p(0,p(0,p(0,'Un',chat),p(0,est,assis)),'.'), lit(txt)-appl(word(4),appl(appl(word(2),word(3)),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Un',chat),p(0,est,assis)), lit(s(main))-appl(appl(word(2),word(3)),appl(word(0),word(1))), [
      rule(dr, p(0,'Un',chat), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Un', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, chat, lit(n)-word(1), [])
         ]),
      rule(dr, p(0,est,assis), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),word(3)), [
         rule(axiom, est, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(pass))))-word(2), []),
         rule(axiom, assis, dl(0,lit(np(nom,_,_)),lit(s(pass)))-word(3), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(4), [])
   ])).

% 221. Il y a six chats , trois chats violets , un chat noir et un chat blanc qui courent le long de l' herbe grise . 

proof(221, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))),'.'), lit(txt)-appl(word(25),appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))), lit(s(main))-appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dl, p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))), lit(np(acc,_,_))-appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))))), [
                  rule(dl, p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))), lit(np(acc,_,_))-appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))), [
                     rule(dl, p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))), lit(np(acc,_,_))-appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))), [
                        rule(dr, p(0,six,chats), lit(np(acc,_,_))-appl(word(3),word(4)), [
                           rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                           rule(axiom, chats, lit(n)-word(4), [])
                           ]),
                        rule(dr, p(0,',',p(0,trois,p(0,chats,violets))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(5),appl(word(6),appl(word(8),word(7)))), [
                           rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(5), []),
                           rule(dr, p(0,trois,p(0,chats,violets)), lit(np(_,_,_))-appl(word(6),appl(word(8),word(7))), [
                              rule(axiom, trois, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                              rule(dl, p(0,chats,violets), lit(n)-appl(word(8),word(7)), [
                                 rule(axiom, chats, lit(n)-word(7), []),
                                 rule(axiom, violets, dl(0,lit(n),lit(n))-word(8), [])
                                 ])
                              ])
                           ])
                        ]),
                     rule(dr, p(0,',',p(0,un,p(0,chat,noir))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(9),appl(word(10),appl(word(12),word(11)))), [
                        rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(9), []),
                        rule(dr, p(0,un,p(0,chat,noir)), lit(np(_,_,_))-appl(word(10),appl(word(12),word(11))), [
                           rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(10), []),
                           rule(dl, p(0,chat,noir), lit(n)-appl(word(12),word(11)), [
                              rule(axiom, chat, lit(n)-word(11), []),
                              rule(axiom, noir, dl(0,lit(n),lit(n))-word(12), [])
                              ])
                           ])
                        ])
                     ]),
                  rule(dr, p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))), [
                     rule(axiom, et, dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(13), []),
                     rule(dr, p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))), lit(np(_,_,_))-appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15)))), [
                        rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(14), []),
                        rule(dl, p(0,p(0,chat,blanc),p(0,qui,courent)), lit(n)-appl(appl(word(17),word(18)),appl(word(16),word(15))), [
                           rule(dl, p(0,chat,blanc), lit(n)-appl(word(16),word(15)), [
                              rule(axiom, chat, lit(n)-word(15), []),
                              rule(axiom, blanc, dl(0,lit(n),lit(n))-word(16), [])
                              ]),
                           rule(dr, p(0,qui,courent), dl(0,lit(n),lit(n))-appl(word(17),word(18)), [
                              rule(axiom, qui, dr(0,dl(0,lit(n),lit(n)),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(17), []),
                              rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(18), [])
                              ])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise)), dl(1,lit(s(main)),lit(s(main)))-appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))), [
         rule(axiom, le, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(19), []),
         rule(dl, p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise), lit(n)-appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20))), [
            rule(dl, p(0,long,p(0,de,p(0,'l\'',herbe))), lit(n)-appl(appl(word(21),appl(word(22),word(23))),word(20)), [
               rule(axiom, long, lit(n)-word(20), []),
               rule(dr, p(0,de,p(0,'l\'',herbe)), dl(0,lit(n),lit(n))-appl(word(21),appl(word(22),word(23))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(21), []),
                  rule(dr, p(0,'l\'',herbe), lit(np(_,_,_))-appl(word(22),word(23)), [
                     rule(axiom, 'l\'', dr(0,lit(np(_,_,_)),lit(n))-word(22), []),
                     rule(axiom, herbe, lit(n)-word(23), [])
                     ])
                  ])
               ]),
            rule(axiom, grise, dl(0,lit(n),lit(n))-word(24), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(25), [])
   ])).

% 222. Trois chats courent . 

proof(222, rule(dl, p(0,p(0,p(0,'Trois',chats),courent),'.'), lit(txt)-appl(word(3),appl(word(2),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Trois',chats),courent), lit(s(main))-appl(word(2),appl(word(0),word(1))), [
      rule(dr, p(0,'Trois',chats), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Trois', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, chats, lit(n)-word(1), [])
         ]),
      rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(2), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(3), [])
   ])).

% 223. Il y a six chats , trois chats violets , un chat noir et un chat blanc qui courent le long de l' herbe grise . 

proof(223, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))),'.'), lit(txt)-appl(word(25),appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))), lit(s(main))-appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dl, p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))), lit(np(acc,_,_))-appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))))), [
                  rule(dl, p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))), lit(np(acc,_,_))-appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))), [
                     rule(dl, p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))), lit(np(acc,_,_))-appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))), [
                        rule(dr, p(0,six,chats), lit(np(acc,_,_))-appl(word(3),word(4)), [
                           rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                           rule(axiom, chats, lit(n)-word(4), [])
                           ]),
                        rule(dr, p(0,',',p(0,trois,p(0,chats,violets))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(5),appl(word(6),appl(word(8),word(7)))), [
                           rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(5), []),
                           rule(dr, p(0,trois,p(0,chats,violets)), lit(np(_,_,_))-appl(word(6),appl(word(8),word(7))), [
                              rule(axiom, trois, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                              rule(dl, p(0,chats,violets), lit(n)-appl(word(8),word(7)), [
                                 rule(axiom, chats, lit(n)-word(7), []),
                                 rule(axiom, violets, dl(0,lit(n),lit(n))-word(8), [])
                                 ])
                              ])
                           ])
                        ]),
                     rule(dr, p(0,',',p(0,un,p(0,chat,noir))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(9),appl(word(10),appl(word(12),word(11)))), [
                        rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(9), []),
                        rule(dr, p(0,un,p(0,chat,noir)), lit(np(_,_,_))-appl(word(10),appl(word(12),word(11))), [
                           rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(10), []),
                           rule(dl, p(0,chat,noir), lit(n)-appl(word(12),word(11)), [
                              rule(axiom, chat, lit(n)-word(11), []),
                              rule(axiom, noir, dl(0,lit(n),lit(n))-word(12), [])
                              ])
                           ])
                        ])
                     ]),
                  rule(dr, p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))), [
                     rule(axiom, et, dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(13), []),
                     rule(dr, p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))), lit(np(_,_,_))-appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15)))), [
                        rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(14), []),
                        rule(dl, p(0,p(0,chat,blanc),p(0,qui,courent)), lit(n)-appl(appl(word(17),word(18)),appl(word(16),word(15))), [
                           rule(dl, p(0,chat,blanc), lit(n)-appl(word(16),word(15)), [
                              rule(axiom, chat, lit(n)-word(15), []),
                              rule(axiom, blanc, dl(0,lit(n),lit(n))-word(16), [])
                              ]),
                           rule(dr, p(0,qui,courent), dl(0,lit(n),lit(n))-appl(word(17),word(18)), [
                              rule(axiom, qui, dr(0,dl(0,lit(n),lit(n)),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(17), []),
                              rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(18), [])
                              ])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise)), dl(1,lit(s(main)),lit(s(main)))-appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))), [
         rule(axiom, le, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(19), []),
         rule(dl, p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise), lit(n)-appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20))), [
            rule(dl, p(0,long,p(0,de,p(0,'l\'',herbe))), lit(n)-appl(appl(word(21),appl(word(22),word(23))),word(20)), [
               rule(axiom, long, lit(n)-word(20), []),
               rule(dr, p(0,de,p(0,'l\'',herbe)), dl(0,lit(n),lit(n))-appl(word(21),appl(word(22),word(23))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(21), []),
                  rule(dr, p(0,'l\'',herbe), lit(np(_,_,_))-appl(word(22),word(23)), [
                     rule(axiom, 'l\'', dr(0,lit(np(_,_,_)),lit(n))-word(22), []),
                     rule(axiom, herbe, lit(n)-word(23), [])
                     ])
                  ])
               ]),
            rule(axiom, grise, dl(0,lit(n),lit(n))-word(24), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(25), [])
   ])).

% 224. Entre six et sept chats courent . 

proof(224, rule(dl, p(0,p(0,p(0,'Entre',p(0,p(0,six,p(0,et,sept)),chats)),courent),'.'), lit(txt)-appl(word(6),appl(word(5),appl(word(0),appl(appl(appl(word(2),word(3)),word(1)),word(4))))), [
   rule(dl, p(0,p(0,'Entre',p(0,p(0,six,p(0,et,sept)),chats)),courent), lit(s(main))-appl(word(5),appl(word(0),appl(appl(appl(word(2),word(3)),word(1)),word(4)))), [
      rule(dr, p(0,'Entre',p(0,p(0,six,p(0,et,sept)),chats)), lit(np(nom,_,_))-appl(word(0),appl(appl(appl(word(2),word(3)),word(1)),word(4))), [
         rule(axiom, 'Entre', dr(0,lit(np(nom,_,_)),lit(np(_,_,_)))-word(0), []),
         rule(dr, p(0,p(0,six,p(0,et,sept)),chats), lit(np(_,_,_))-appl(appl(appl(word(2),word(3)),word(1)),word(4)), [
            rule(dl, p(0,six,p(0,et,sept)), dr(0,lit(np(_,_,_)),lit(n))-appl(appl(word(2),word(3)),word(1)), [
               rule(axiom, six, dr(0,lit(np(_,_,_)),lit(n))-word(1), []),
               rule(dr, p(0,et,sept), dl(0,dr(0,lit(np(_,_,_)),lit(n)),dr(0,lit(np(_,_,_)),lit(n)))-appl(word(2),word(3)), [
                  rule(axiom, et, dr(0,dl(0,dr(0,lit(np(_,_,_)),lit(n)),dr(0,lit(np(_,_,_)),lit(n))),dr(0,lit(np(_,_,_)),lit(n)))-word(2), []),
                  rule(axiom, sept, dr(0,lit(np(_,_,_)),lit(n))-word(3), [])
                  ])
               ]),
            rule(axiom, chats, lit(n)-word(4), [])
            ])
         ]),
      rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(5), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(6), [])
   ])).

% 225. Il y a six chats , trois chats violets , un chat noir et un chat blanc qui courent le long de l' herbe grise . 

proof(225, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))),'.'), lit(txt)-appl(word(25),appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))), lit(s(main))-appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dl, p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))), lit(np(acc,_,_))-appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))))), [
                  rule(dl, p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))), lit(np(acc,_,_))-appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))), [
                     rule(dl, p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))), lit(np(acc,_,_))-appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))), [
                        rule(dr, p(0,six,chats), lit(np(acc,_,_))-appl(word(3),word(4)), [
                           rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                           rule(axiom, chats, lit(n)-word(4), [])
                           ]),
                        rule(dr, p(0,',',p(0,trois,p(0,chats,violets))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(5),appl(word(6),appl(word(8),word(7)))), [
                           rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(5), []),
                           rule(dr, p(0,trois,p(0,chats,violets)), lit(np(_,_,_))-appl(word(6),appl(word(8),word(7))), [
                              rule(axiom, trois, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                              rule(dl, p(0,chats,violets), lit(n)-appl(word(8),word(7)), [
                                 rule(axiom, chats, lit(n)-word(7), []),
                                 rule(axiom, violets, dl(0,lit(n),lit(n))-word(8), [])
                                 ])
                              ])
                           ])
                        ]),
                     rule(dr, p(0,',',p(0,un,p(0,chat,noir))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(9),appl(word(10),appl(word(12),word(11)))), [
                        rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(9), []),
                        rule(dr, p(0,un,p(0,chat,noir)), lit(np(_,_,_))-appl(word(10),appl(word(12),word(11))), [
                           rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(10), []),
                           rule(dl, p(0,chat,noir), lit(n)-appl(word(12),word(11)), [
                              rule(axiom, chat, lit(n)-word(11), []),
                              rule(axiom, noir, dl(0,lit(n),lit(n))-word(12), [])
                              ])
                           ])
                        ])
                     ]),
                  rule(dr, p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))), [
                     rule(axiom, et, dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(13), []),
                     rule(dr, p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))), lit(np(_,_,_))-appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15)))), [
                        rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(14), []),
                        rule(dl, p(0,p(0,chat,blanc),p(0,qui,courent)), lit(n)-appl(appl(word(17),word(18)),appl(word(16),word(15))), [
                           rule(dl, p(0,chat,blanc), lit(n)-appl(word(16),word(15)), [
                              rule(axiom, chat, lit(n)-word(15), []),
                              rule(axiom, blanc, dl(0,lit(n),lit(n))-word(16), [])
                              ]),
                           rule(dr, p(0,qui,courent), dl(0,lit(n),lit(n))-appl(word(17),word(18)), [
                              rule(axiom, qui, dr(0,dl(0,lit(n),lit(n)),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(17), []),
                              rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(18), [])
                              ])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise)), dl(1,lit(s(main)),lit(s(main)))-appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))), [
         rule(axiom, le, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(19), []),
         rule(dl, p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise), lit(n)-appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20))), [
            rule(dl, p(0,long,p(0,de,p(0,'l\'',herbe))), lit(n)-appl(appl(word(21),appl(word(22),word(23))),word(20)), [
               rule(axiom, long, lit(n)-word(20), []),
               rule(dr, p(0,de,p(0,'l\'',herbe)), dl(0,lit(n),lit(n))-appl(word(21),appl(word(22),word(23))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(21), []),
                  rule(dr, p(0,'l\'',herbe), lit(np(_,_,_))-appl(word(22),word(23)), [
                     rule(axiom, 'l\'', dr(0,lit(np(_,_,_)),lit(n))-word(22), []),
                     rule(axiom, herbe, lit(n)-word(23), [])
                     ])
                  ])
               ]),
            rule(axiom, grise, dl(0,lit(n),lit(n))-word(24), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(25), [])
   ])).

% 227. Il y a six chats , trois chats violets , un chat noir et un chat blanc qui courent le long de l' herbe grise . 

proof(227, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))),'.'), lit(txt)-appl(word(25),appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))), lit(s(main))-appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dl, p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))), lit(np(acc,_,_))-appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))))), [
                  rule(dl, p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))), lit(np(acc,_,_))-appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))), [
                     rule(dl, p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))), lit(np(acc,_,_))-appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))), [
                        rule(dr, p(0,six,chats), lit(np(acc,_,_))-appl(word(3),word(4)), [
                           rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                           rule(axiom, chats, lit(n)-word(4), [])
                           ]),
                        rule(dr, p(0,',',p(0,trois,p(0,chats,violets))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(5),appl(word(6),appl(word(8),word(7)))), [
                           rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(5), []),
                           rule(dr, p(0,trois,p(0,chats,violets)), lit(np(_,_,_))-appl(word(6),appl(word(8),word(7))), [
                              rule(axiom, trois, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                              rule(dl, p(0,chats,violets), lit(n)-appl(word(8),word(7)), [
                                 rule(axiom, chats, lit(n)-word(7), []),
                                 rule(axiom, violets, dl(0,lit(n),lit(n))-word(8), [])
                                 ])
                              ])
                           ])
                        ]),
                     rule(dr, p(0,',',p(0,un,p(0,chat,noir))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(9),appl(word(10),appl(word(12),word(11)))), [
                        rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(9), []),
                        rule(dr, p(0,un,p(0,chat,noir)), lit(np(_,_,_))-appl(word(10),appl(word(12),word(11))), [
                           rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(10), []),
                           rule(dl, p(0,chat,noir), lit(n)-appl(word(12),word(11)), [
                              rule(axiom, chat, lit(n)-word(11), []),
                              rule(axiom, noir, dl(0,lit(n),lit(n))-word(12), [])
                              ])
                           ])
                        ])
                     ]),
                  rule(dr, p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))), [
                     rule(axiom, et, dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(13), []),
                     rule(dr, p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))), lit(np(_,_,_))-appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15)))), [
                        rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(14), []),
                        rule(dl, p(0,p(0,chat,blanc),p(0,qui,courent)), lit(n)-appl(appl(word(17),word(18)),appl(word(16),word(15))), [
                           rule(dl, p(0,chat,blanc), lit(n)-appl(word(16),word(15)), [
                              rule(axiom, chat, lit(n)-word(15), []),
                              rule(axiom, blanc, dl(0,lit(n),lit(n))-word(16), [])
                              ]),
                           rule(dr, p(0,qui,courent), dl(0,lit(n),lit(n))-appl(word(17),word(18)), [
                              rule(axiom, qui, dr(0,dl(0,lit(n),lit(n)),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(17), []),
                              rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(18), [])
                              ])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise)), dl(1,lit(s(main)),lit(s(main)))-appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))), [
         rule(axiom, le, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(19), []),
         rule(dl, p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise), lit(n)-appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20))), [
            rule(dl, p(0,long,p(0,de,p(0,'l\'',herbe))), lit(n)-appl(appl(word(21),appl(word(22),word(23))),word(20)), [
               rule(axiom, long, lit(n)-word(20), []),
               rule(dr, p(0,de,p(0,'l\'',herbe)), dl(0,lit(n),lit(n))-appl(word(21),appl(word(22),word(23))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(21), []),
                  rule(dr, p(0,'l\'',herbe), lit(np(_,_,_))-appl(word(22),word(23)), [
                     rule(axiom, 'l\'', dr(0,lit(np(_,_,_)),lit(n))-word(22), []),
                     rule(axiom, herbe, lit(n)-word(23), [])
                     ])
                  ])
               ]),
            rule(axiom, grise, dl(0,lit(n),lit(n))-word(24), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(25), [])
   ])).

% 229. Il y a six chats , trois chats violets , un chat noir et un chat blanc qui courent le long de l' herbe grise . 

proof(229, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))),'.'), lit(txt)-appl(word(25),appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))), lit(s(main))-appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dl, p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))), lit(np(acc,_,_))-appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))))), [
                  rule(dl, p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))), lit(np(acc,_,_))-appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))), [
                     rule(dl, p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))), lit(np(acc,_,_))-appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))), [
                        rule(dr, p(0,six,chats), lit(np(acc,_,_))-appl(word(3),word(4)), [
                           rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                           rule(axiom, chats, lit(n)-word(4), [])
                           ]),
                        rule(dr, p(0,',',p(0,trois,p(0,chats,violets))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(5),appl(word(6),appl(word(8),word(7)))), [
                           rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(5), []),
                           rule(dr, p(0,trois,p(0,chats,violets)), lit(np(_,_,_))-appl(word(6),appl(word(8),word(7))), [
                              rule(axiom, trois, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                              rule(dl, p(0,chats,violets), lit(n)-appl(word(8),word(7)), [
                                 rule(axiom, chats, lit(n)-word(7), []),
                                 rule(axiom, violets, dl(0,lit(n),lit(n))-word(8), [])
                                 ])
                              ])
                           ])
                        ]),
                     rule(dr, p(0,',',p(0,un,p(0,chat,noir))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(9),appl(word(10),appl(word(12),word(11)))), [
                        rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(9), []),
                        rule(dr, p(0,un,p(0,chat,noir)), lit(np(_,_,_))-appl(word(10),appl(word(12),word(11))), [
                           rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(10), []),
                           rule(dl, p(0,chat,noir), lit(n)-appl(word(12),word(11)), [
                              rule(axiom, chat, lit(n)-word(11), []),
                              rule(axiom, noir, dl(0,lit(n),lit(n))-word(12), [])
                              ])
                           ])
                        ])
                     ]),
                  rule(dr, p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))), [
                     rule(axiom, et, dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(13), []),
                     rule(dr, p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))), lit(np(_,_,_))-appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15)))), [
                        rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(14), []),
                        rule(dl, p(0,p(0,chat,blanc),p(0,qui,courent)), lit(n)-appl(appl(word(17),word(18)),appl(word(16),word(15))), [
                           rule(dl, p(0,chat,blanc), lit(n)-appl(word(16),word(15)), [
                              rule(axiom, chat, lit(n)-word(15), []),
                              rule(axiom, blanc, dl(0,lit(n),lit(n))-word(16), [])
                              ]),
                           rule(dr, p(0,qui,courent), dl(0,lit(n),lit(n))-appl(word(17),word(18)), [
                              rule(axiom, qui, dr(0,dl(0,lit(n),lit(n)),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(17), []),
                              rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(18), [])
                              ])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise)), dl(1,lit(s(main)),lit(s(main)))-appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))), [
         rule(axiom, le, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(19), []),
         rule(dl, p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise), lit(n)-appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20))), [
            rule(dl, p(0,long,p(0,de,p(0,'l\'',herbe))), lit(n)-appl(appl(word(21),appl(word(22),word(23))),word(20)), [
               rule(axiom, long, lit(n)-word(20), []),
               rule(dr, p(0,de,p(0,'l\'',herbe)), dl(0,lit(n),lit(n))-appl(word(21),appl(word(22),word(23))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(21), []),
                  rule(dr, p(0,'l\'',herbe), lit(np(_,_,_))-appl(word(22),word(23)), [
                     rule(axiom, 'l\'', dr(0,lit(np(_,_,_)),lit(n))-word(22), []),
                     rule(axiom, herbe, lit(n)-word(23), [])
                     ])
                  ])
               ]),
            rule(axiom, grise, dl(0,lit(n),lit(n))-word(24), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(25), [])
   ])).

% 230. Un chat orange court . 

proof(230, rule(dl, p(0,p(0,'Un',p(0,p(0,chat,orange),court)),'.'), lit(txt)-appl(word(4),appl(word(0),appl(word(3),appl(word(2),word(1))))), [
   rule(dr, p(0,'Un',p(0,p(0,chat,orange),court)), lit(np(_,_,_))-appl(word(0),appl(word(3),appl(word(2),word(1)))), [
      rule(axiom, 'Un', dr(0,lit(np(_,_,_)),lit(n))-word(0), []),
      rule(dl, p(0,p(0,chat,orange),court), lit(n)-appl(word(3),appl(word(2),word(1))), [
         rule(dl, p(0,chat,orange), lit(n)-appl(word(2),word(1)), [
            rule(axiom, chat, lit(n)-word(1), []),
            rule(axiom, orange, dl(0,lit(n),lit(n))-word(2), [])
            ]),
         rule(axiom, court, dl(0,lit(n),lit(n))-word(3), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(np(_,_,_)),lit(txt))-word(4), [])
   ])).

% 231. Il y a six chats , trois chats violets , un chat noir et un chat blanc qui courent le long de l' herbe grise . 

proof(231, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))),'.'), lit(txt)-appl(word(25),appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))), lit(s(main))-appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dl, p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))), lit(np(acc,_,_))-appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))))), [
                  rule(dl, p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))), lit(np(acc,_,_))-appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))), [
                     rule(dl, p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))), lit(np(acc,_,_))-appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))), [
                        rule(dr, p(0,six,chats), lit(np(acc,_,_))-appl(word(3),word(4)), [
                           rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                           rule(axiom, chats, lit(n)-word(4), [])
                           ]),
                        rule(dr, p(0,',',p(0,trois,p(0,chats,violets))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(5),appl(word(6),appl(word(8),word(7)))), [
                           rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(5), []),
                           rule(dr, p(0,trois,p(0,chats,violets)), lit(np(_,_,_))-appl(word(6),appl(word(8),word(7))), [
                              rule(axiom, trois, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                              rule(dl, p(0,chats,violets), lit(n)-appl(word(8),word(7)), [
                                 rule(axiom, chats, lit(n)-word(7), []),
                                 rule(axiom, violets, dl(0,lit(n),lit(n))-word(8), [])
                                 ])
                              ])
                           ])
                        ]),
                     rule(dr, p(0,',',p(0,un,p(0,chat,noir))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(9),appl(word(10),appl(word(12),word(11)))), [
                        rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(9), []),
                        rule(dr, p(0,un,p(0,chat,noir)), lit(np(_,_,_))-appl(word(10),appl(word(12),word(11))), [
                           rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(10), []),
                           rule(dl, p(0,chat,noir), lit(n)-appl(word(12),word(11)), [
                              rule(axiom, chat, lit(n)-word(11), []),
                              rule(axiom, noir, dl(0,lit(n),lit(n))-word(12), [])
                              ])
                           ])
                        ])
                     ]),
                  rule(dr, p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))), [
                     rule(axiom, et, dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(13), []),
                     rule(dr, p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))), lit(np(_,_,_))-appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15)))), [
                        rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(14), []),
                        rule(dl, p(0,p(0,chat,blanc),p(0,qui,courent)), lit(n)-appl(appl(word(17),word(18)),appl(word(16),word(15))), [
                           rule(dl, p(0,chat,blanc), lit(n)-appl(word(16),word(15)), [
                              rule(axiom, chat, lit(n)-word(15), []),
                              rule(axiom, blanc, dl(0,lit(n),lit(n))-word(16), [])
                              ]),
                           rule(dr, p(0,qui,courent), dl(0,lit(n),lit(n))-appl(word(17),word(18)), [
                              rule(axiom, qui, dr(0,dl(0,lit(n),lit(n)),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(17), []),
                              rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(18), [])
                              ])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise)), dl(1,lit(s(main)),lit(s(main)))-appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))), [
         rule(axiom, le, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(19), []),
         rule(dl, p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise), lit(n)-appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20))), [
            rule(dl, p(0,long,p(0,de,p(0,'l\'',herbe))), lit(n)-appl(appl(word(21),appl(word(22),word(23))),word(20)), [
               rule(axiom, long, lit(n)-word(20), []),
               rule(dr, p(0,de,p(0,'l\'',herbe)), dl(0,lit(n),lit(n))-appl(word(21),appl(word(22),word(23))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(21), []),
                  rule(dr, p(0,'l\'',herbe), lit(np(_,_,_))-appl(word(22),word(23)), [
                     rule(axiom, 'l\'', dr(0,lit(np(_,_,_)),lit(n))-word(22), []),
                     rule(axiom, herbe, lit(n)-word(23), [])
                     ])
                  ])
               ]),
            rule(axiom, grise, dl(0,lit(n),lit(n))-word(24), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(25), [])
   ])).

% 232. 60 % des chats courent . 

proof(232, rule(dl, p(0,p(0,p(0,60,p(0,'%',p(0,des,chats))),courent),'.'), lit(txt)-appl(word(5),appl(word(4),appl(word(0),appl(appl(word(2),word(3)),word(1))))), [
   rule(dl, p(0,p(0,60,p(0,'%',p(0,des,chats))),courent), lit(s(main))-appl(word(4),appl(word(0),appl(appl(word(2),word(3)),word(1)))), [
      rule(dr, p(0,60,p(0,'%',p(0,des,chats))), lit(np(nom,_,_))-appl(word(0),appl(appl(word(2),word(3)),word(1))), [
         rule(axiom, 60, dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dl, p(0,'%',p(0,des,chats)), lit(n)-appl(appl(word(2),word(3)),word(1)), [
            rule(axiom, '%', lit(n)-word(1), []),
            rule(dr, p(0,des,chats), dl(0,lit(n),lit(n))-appl(word(2),word(3)), [
               rule(axiom, des, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(2), []),
               rule(axiom, chats, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(4), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(5), [])
   ])).

% 233. Il y a six chats , trois chats violets , un chat noir et un chat blanc qui courent le long de l' herbe grise . 

proof(233, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))),'.'), lit(txt)-appl(word(25),appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))), lit(s(main))-appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dl, p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))), lit(np(acc,_,_))-appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))))), [
                  rule(dl, p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))), lit(np(acc,_,_))-appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))), [
                     rule(dl, p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))), lit(np(acc,_,_))-appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))), [
                        rule(dr, p(0,six,chats), lit(np(acc,_,_))-appl(word(3),word(4)), [
                           rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                           rule(axiom, chats, lit(n)-word(4), [])
                           ]),
                        rule(dr, p(0,',',p(0,trois,p(0,chats,violets))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(5),appl(word(6),appl(word(8),word(7)))), [
                           rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(5), []),
                           rule(dr, p(0,trois,p(0,chats,violets)), lit(np(_,_,_))-appl(word(6),appl(word(8),word(7))), [
                              rule(axiom, trois, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                              rule(dl, p(0,chats,violets), lit(n)-appl(word(8),word(7)), [
                                 rule(axiom, chats, lit(n)-word(7), []),
                                 rule(axiom, violets, dl(0,lit(n),lit(n))-word(8), [])
                                 ])
                              ])
                           ])
                        ]),
                     rule(dr, p(0,',',p(0,un,p(0,chat,noir))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(9),appl(word(10),appl(word(12),word(11)))), [
                        rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(9), []),
                        rule(dr, p(0,un,p(0,chat,noir)), lit(np(_,_,_))-appl(word(10),appl(word(12),word(11))), [
                           rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(10), []),
                           rule(dl, p(0,chat,noir), lit(n)-appl(word(12),word(11)), [
                              rule(axiom, chat, lit(n)-word(11), []),
                              rule(axiom, noir, dl(0,lit(n),lit(n))-word(12), [])
                              ])
                           ])
                        ])
                     ]),
                  rule(dr, p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))), [
                     rule(axiom, et, dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(13), []),
                     rule(dr, p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))), lit(np(_,_,_))-appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15)))), [
                        rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(14), []),
                        rule(dl, p(0,p(0,chat,blanc),p(0,qui,courent)), lit(n)-appl(appl(word(17),word(18)),appl(word(16),word(15))), [
                           rule(dl, p(0,chat,blanc), lit(n)-appl(word(16),word(15)), [
                              rule(axiom, chat, lit(n)-word(15), []),
                              rule(axiom, blanc, dl(0,lit(n),lit(n))-word(16), [])
                              ]),
                           rule(dr, p(0,qui,courent), dl(0,lit(n),lit(n))-appl(word(17),word(18)), [
                              rule(axiom, qui, dr(0,dl(0,lit(n),lit(n)),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(17), []),
                              rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(18), [])
                              ])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise)), dl(1,lit(s(main)),lit(s(main)))-appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))), [
         rule(axiom, le, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(19), []),
         rule(dl, p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise), lit(n)-appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20))), [
            rule(dl, p(0,long,p(0,de,p(0,'l\'',herbe))), lit(n)-appl(appl(word(21),appl(word(22),word(23))),word(20)), [
               rule(axiom, long, lit(n)-word(20), []),
               rule(dr, p(0,de,p(0,'l\'',herbe)), dl(0,lit(n),lit(n))-appl(word(21),appl(word(22),word(23))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(21), []),
                  rule(dr, p(0,'l\'',herbe), lit(np(_,_,_))-appl(word(22),word(23)), [
                     rule(axiom, 'l\'', dr(0,lit(np(_,_,_)),lit(n))-word(22), []),
                     rule(axiom, herbe, lit(n)-word(23), [])
                     ])
                  ])
               ]),
            rule(axiom, grise, dl(0,lit(n),lit(n))-word(24), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(25), [])
   ])).

% 234. 40 % des chats sont assis . 

proof(234, rule(dl, p(0,p(0,p(0,40,p(0,'%',p(0,des,chats))),p(0,sont,assis)),'.'), lit(txt)-appl(word(6),appl(appl(word(4),word(5)),appl(word(0),appl(appl(word(2),word(3)),word(1))))), [
   rule(dl, p(0,p(0,40,p(0,'%',p(0,des,chats))),p(0,sont,assis)), lit(s(main))-appl(appl(word(4),word(5)),appl(word(0),appl(appl(word(2),word(3)),word(1)))), [
      rule(dr, p(0,40,p(0,'%',p(0,des,chats))), lit(np(nom,_,_))-appl(word(0),appl(appl(word(2),word(3)),word(1))), [
         rule(axiom, 40, dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dl, p(0,'%',p(0,des,chats)), lit(n)-appl(appl(word(2),word(3)),word(1)), [
            rule(axiom, '%', lit(n)-word(1), []),
            rule(dr, p(0,des,chats), dl(0,lit(n),lit(n))-appl(word(2),word(3)), [
               rule(axiom, des, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(2), []),
               rule(axiom, chats, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(dr, p(0,sont,assis), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),word(5)), [
         rule(axiom, sont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(pass))))-word(4), []),
         rule(axiom, assis, dl(0,lit(np(nom,_,_)),lit(s(pass)))-word(5), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(6), [])
   ])).

% 235. Il y a six chats , trois chats violets , un chat noir et un chat blanc qui courent le long de l' herbe grise . 

proof(235, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))),'.'), lit(txt)-appl(word(25),appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))), lit(s(main))-appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dl, p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))), lit(np(acc,_,_))-appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))))), [
                  rule(dl, p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))), lit(np(acc,_,_))-appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))), [
                     rule(dl, p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))), lit(np(acc,_,_))-appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))), [
                        rule(dr, p(0,six,chats), lit(np(acc,_,_))-appl(word(3),word(4)), [
                           rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                           rule(axiom, chats, lit(n)-word(4), [])
                           ]),
                        rule(dr, p(0,',',p(0,trois,p(0,chats,violets))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(5),appl(word(6),appl(word(8),word(7)))), [
                           rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(5), []),
                           rule(dr, p(0,trois,p(0,chats,violets)), lit(np(_,_,_))-appl(word(6),appl(word(8),word(7))), [
                              rule(axiom, trois, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                              rule(dl, p(0,chats,violets), lit(n)-appl(word(8),word(7)), [
                                 rule(axiom, chats, lit(n)-word(7), []),
                                 rule(axiom, violets, dl(0,lit(n),lit(n))-word(8), [])
                                 ])
                              ])
                           ])
                        ]),
                     rule(dr, p(0,',',p(0,un,p(0,chat,noir))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(9),appl(word(10),appl(word(12),word(11)))), [
                        rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(9), []),
                        rule(dr, p(0,un,p(0,chat,noir)), lit(np(_,_,_))-appl(word(10),appl(word(12),word(11))), [
                           rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(10), []),
                           rule(dl, p(0,chat,noir), lit(n)-appl(word(12),word(11)), [
                              rule(axiom, chat, lit(n)-word(11), []),
                              rule(axiom, noir, dl(0,lit(n),lit(n))-word(12), [])
                              ])
                           ])
                        ])
                     ]),
                  rule(dr, p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))), [
                     rule(axiom, et, dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(13), []),
                     rule(dr, p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))), lit(np(_,_,_))-appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15)))), [
                        rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(14), []),
                        rule(dl, p(0,p(0,chat,blanc),p(0,qui,courent)), lit(n)-appl(appl(word(17),word(18)),appl(word(16),word(15))), [
                           rule(dl, p(0,chat,blanc), lit(n)-appl(word(16),word(15)), [
                              rule(axiom, chat, lit(n)-word(15), []),
                              rule(axiom, blanc, dl(0,lit(n),lit(n))-word(16), [])
                              ]),
                           rule(dr, p(0,qui,courent), dl(0,lit(n),lit(n))-appl(word(17),word(18)), [
                              rule(axiom, qui, dr(0,dl(0,lit(n),lit(n)),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(17), []),
                              rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(18), [])
                              ])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise)), dl(1,lit(s(main)),lit(s(main)))-appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))), [
         rule(axiom, le, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(19), []),
         rule(dl, p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise), lit(n)-appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20))), [
            rule(dl, p(0,long,p(0,de,p(0,'l\'',herbe))), lit(n)-appl(appl(word(21),appl(word(22),word(23))),word(20)), [
               rule(axiom, long, lit(n)-word(20), []),
               rule(dr, p(0,de,p(0,'l\'',herbe)), dl(0,lit(n),lit(n))-appl(word(21),appl(word(22),word(23))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(21), []),
                  rule(dr, p(0,'l\'',herbe), lit(np(_,_,_))-appl(word(22),word(23)), [
                     rule(axiom, 'l\'', dr(0,lit(np(_,_,_)),lit(n))-word(22), []),
                     rule(axiom, herbe, lit(n)-word(23), [])
                     ])
                  ])
               ]),
            rule(axiom, grise, dl(0,lit(n),lit(n))-word(24), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(25), [])
   ])).

% 236. Plus de 40 % des chats courent . 

proof(236, rule(dl, p(0,p(0,p(0,'Plus',p(0,de,p(0,40,p(0,'%',p(0,des,chats))))),courent),'.'), lit(txt)-appl(word(7),appl(word(6),appl(word(0),appl(word(1),appl(word(2),appl(appl(word(4),word(5)),word(3))))))), [
   rule(dl, p(0,p(0,'Plus',p(0,de,p(0,40,p(0,'%',p(0,des,chats))))),courent), lit(s(main))-appl(word(6),appl(word(0),appl(word(1),appl(word(2),appl(appl(word(4),word(5)),word(3)))))), [
      rule(dr, p(0,'Plus',p(0,de,p(0,40,p(0,'%',p(0,des,chats))))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),appl(appl(word(4),word(5)),word(3))))), [
         rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
         rule(dr, p(0,de,p(0,40,p(0,'%',p(0,des,chats)))), lit(pp(de))-appl(word(1),appl(word(2),appl(appl(word(4),word(5)),word(3)))), [
            rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
            rule(dr, p(0,40,p(0,'%',p(0,des,chats))), lit(np(acc,_,_))-appl(word(2),appl(appl(word(4),word(5)),word(3))), [
               rule(axiom, 40, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
               rule(dl, p(0,'%',p(0,des,chats)), lit(n)-appl(appl(word(4),word(5)),word(3)), [
                  rule(axiom, '%', lit(n)-word(3), []),
                  rule(dr, p(0,des,chats), dl(0,lit(n),lit(n))-appl(word(4),word(5)), [
                     rule(axiom, des, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(4), []),
                     rule(axiom, chats, lit(n)-word(5), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(6), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(7), [])
   ])).

% 237. Il y a six chats , trois chats violets , un chat noir et un chat blanc qui courent le long de l' herbe grise . 

proof(237, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))),'.'), lit(txt)-appl(word(25),appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))), lit(s(main))-appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dl, p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))), lit(np(acc,_,_))-appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))))), [
                  rule(dl, p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))), lit(np(acc,_,_))-appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))), [
                     rule(dl, p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))), lit(np(acc,_,_))-appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))), [
                        rule(dr, p(0,six,chats), lit(np(acc,_,_))-appl(word(3),word(4)), [
                           rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                           rule(axiom, chats, lit(n)-word(4), [])
                           ]),
                        rule(dr, p(0,',',p(0,trois,p(0,chats,violets))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(5),appl(word(6),appl(word(8),word(7)))), [
                           rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(5), []),
                           rule(dr, p(0,trois,p(0,chats,violets)), lit(np(_,_,_))-appl(word(6),appl(word(8),word(7))), [
                              rule(axiom, trois, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                              rule(dl, p(0,chats,violets), lit(n)-appl(word(8),word(7)), [
                                 rule(axiom, chats, lit(n)-word(7), []),
                                 rule(axiom, violets, dl(0,lit(n),lit(n))-word(8), [])
                                 ])
                              ])
                           ])
                        ]),
                     rule(dr, p(0,',',p(0,un,p(0,chat,noir))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(9),appl(word(10),appl(word(12),word(11)))), [
                        rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(9), []),
                        rule(dr, p(0,un,p(0,chat,noir)), lit(np(_,_,_))-appl(word(10),appl(word(12),word(11))), [
                           rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(10), []),
                           rule(dl, p(0,chat,noir), lit(n)-appl(word(12),word(11)), [
                              rule(axiom, chat, lit(n)-word(11), []),
                              rule(axiom, noir, dl(0,lit(n),lit(n))-word(12), [])
                              ])
                           ])
                        ])
                     ]),
                  rule(dr, p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))), [
                     rule(axiom, et, dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(13), []),
                     rule(dr, p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))), lit(np(_,_,_))-appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15)))), [
                        rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(14), []),
                        rule(dl, p(0,p(0,chat,blanc),p(0,qui,courent)), lit(n)-appl(appl(word(17),word(18)),appl(word(16),word(15))), [
                           rule(dl, p(0,chat,blanc), lit(n)-appl(word(16),word(15)), [
                              rule(axiom, chat, lit(n)-word(15), []),
                              rule(axiom, blanc, dl(0,lit(n),lit(n))-word(16), [])
                              ]),
                           rule(dr, p(0,qui,courent), dl(0,lit(n),lit(n))-appl(word(17),word(18)), [
                              rule(axiom, qui, dr(0,dl(0,lit(n),lit(n)),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(17), []),
                              rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(18), [])
                              ])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise)), dl(1,lit(s(main)),lit(s(main)))-appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))), [
         rule(axiom, le, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(19), []),
         rule(dl, p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise), lit(n)-appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20))), [
            rule(dl, p(0,long,p(0,de,p(0,'l\'',herbe))), lit(n)-appl(appl(word(21),appl(word(22),word(23))),word(20)), [
               rule(axiom, long, lit(n)-word(20), []),
               rule(dr, p(0,de,p(0,'l\'',herbe)), dl(0,lit(n),lit(n))-appl(word(21),appl(word(22),word(23))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(21), []),
                  rule(dr, p(0,'l\'',herbe), lit(np(_,_,_))-appl(word(22),word(23)), [
                     rule(axiom, 'l\'', dr(0,lit(np(_,_,_)),lit(n))-word(22), []),
                     rule(axiom, herbe, lit(n)-word(23), [])
                     ])
                  ])
               ]),
            rule(axiom, grise, dl(0,lit(n),lit(n))-word(24), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(25), [])
   ])).

% 238. Un chat violet et un chat orange se poursuivent . 

proof(238, rule(dl, p(0,p(0,p(0,p(0,'Un',p(0,chat,violet)),p(0,et,p(0,un,p(0,chat,orange)))),p(0,se,poursuivent)),'.'), lit(txt)-appl(word(9),appl(appl(word(8),word(7)),appl(appl(word(3),appl(word(4),appl(word(6),word(5)))),appl(word(0),appl(word(2),word(1)))))), [
   rule(dl, p(0,p(0,p(0,'Un',p(0,chat,violet)),p(0,et,p(0,un,p(0,chat,orange)))),p(0,se,poursuivent)), lit(s(main))-appl(appl(word(8),word(7)),appl(appl(word(3),appl(word(4),appl(word(6),word(5)))),appl(word(0),appl(word(2),word(1))))), [
      rule(dl, p(0,p(0,'Un',p(0,chat,violet)),p(0,et,p(0,un,p(0,chat,orange)))), lit(np(nom,_,_))-appl(appl(word(3),appl(word(4),appl(word(6),word(5)))),appl(word(0),appl(word(2),word(1)))), [
         rule(dr, p(0,'Un',p(0,chat,violet)), lit(np(nom,_,_))-appl(word(0),appl(word(2),word(1))), [
            rule(axiom, 'Un', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
            rule(dl, p(0,chat,violet), lit(n)-appl(word(2),word(1)), [
               rule(axiom, chat, lit(n)-word(1), []),
               rule(axiom, violet, dl(0,lit(n),lit(n))-word(2), [])
               ])
            ]),
         rule(dr, p(0,et,p(0,un,p(0,chat,orange))), dl(0,lit(np(nom,_,_)),lit(np(nom,_,_)))-appl(word(3),appl(word(4),appl(word(6),word(5)))), [
            rule(axiom, et, dr(0,dl(0,lit(np(nom,_,_)),lit(np(nom,_,_))),lit(np(_,_,_)))-word(3), []),
            rule(dr, p(0,un,p(0,chat,orange)), lit(np(_,_,_))-appl(word(4),appl(word(6),word(5))), [
               rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(4), []),
               rule(dl, p(0,chat,orange), lit(n)-appl(word(6),word(5)), [
                  rule(axiom, chat, lit(n)-word(5), []),
                  rule(axiom, orange, dl(0,lit(n),lit(n))-word(6), [])
                  ])
               ])
            ])
         ]),
      rule(dl, p(0,se,poursuivent), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(8),word(7)), [
         rule(axiom, se, lit(cl_r)-word(7), []),
         rule(axiom, poursuivent, dl(0,lit(cl_r),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(8), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(9), [])
   ])).

% 239. Il y a six chats , trois chats violets , un chat noir et un chat blanc qui courent le long de l' herbe grise . 

proof(239, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))),'.'), lit(txt)-appl(word(25),appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))),p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise))), lit(s(main))-appl(appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))),appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dl, p(0,p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))),p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))))), lit(np(acc,_,_))-appl(appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))),appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))))), [
                  rule(dl, p(0,p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))),p(0,',',p(0,un,p(0,chat,noir)))), lit(np(acc,_,_))-appl(appl(word(9),appl(word(10),appl(word(12),word(11)))),appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4)))), [
                     rule(dl, p(0,p(0,six,chats),p(0,',',p(0,trois,p(0,chats,violets)))), lit(np(acc,_,_))-appl(appl(word(5),appl(word(6),appl(word(8),word(7)))),appl(word(3),word(4))), [
                        rule(dr, p(0,six,chats), lit(np(acc,_,_))-appl(word(3),word(4)), [
                           rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                           rule(axiom, chats, lit(n)-word(4), [])
                           ]),
                        rule(dr, p(0,',',p(0,trois,p(0,chats,violets))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(5),appl(word(6),appl(word(8),word(7)))), [
                           rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(5), []),
                           rule(dr, p(0,trois,p(0,chats,violets)), lit(np(_,_,_))-appl(word(6),appl(word(8),word(7))), [
                              rule(axiom, trois, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                              rule(dl, p(0,chats,violets), lit(n)-appl(word(8),word(7)), [
                                 rule(axiom, chats, lit(n)-word(7), []),
                                 rule(axiom, violets, dl(0,lit(n),lit(n))-word(8), [])
                                 ])
                              ])
                           ])
                        ]),
                     rule(dr, p(0,',',p(0,un,p(0,chat,noir))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(9),appl(word(10),appl(word(12),word(11)))), [
                        rule(axiom, ',', dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(9), []),
                        rule(dr, p(0,un,p(0,chat,noir)), lit(np(_,_,_))-appl(word(10),appl(word(12),word(11))), [
                           rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(10), []),
                           rule(dl, p(0,chat,noir), lit(n)-appl(word(12),word(11)), [
                              rule(axiom, chat, lit(n)-word(11), []),
                              rule(axiom, noir, dl(0,lit(n),lit(n))-word(12), [])
                              ])
                           ])
                        ])
                     ]),
                  rule(dr, p(0,et,p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent)))), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(13),appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15))))), [
                     rule(axiom, et, dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(13), []),
                     rule(dr, p(0,un,p(0,p(0,chat,blanc),p(0,qui,courent))), lit(np(_,_,_))-appl(word(14),appl(appl(word(17),word(18)),appl(word(16),word(15)))), [
                        rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(14), []),
                        rule(dl, p(0,p(0,chat,blanc),p(0,qui,courent)), lit(n)-appl(appl(word(17),word(18)),appl(word(16),word(15))), [
                           rule(dl, p(0,chat,blanc), lit(n)-appl(word(16),word(15)), [
                              rule(axiom, chat, lit(n)-word(15), []),
                              rule(axiom, blanc, dl(0,lit(n),lit(n))-word(16), [])
                              ]),
                           rule(dr, p(0,qui,courent), dl(0,lit(n),lit(n))-appl(word(17),word(18)), [
                              rule(axiom, qui, dr(0,dl(0,lit(n),lit(n)),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(17), []),
                              rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(18), [])
                              ])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,le,p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise)), dl(1,lit(s(main)),lit(s(main)))-appl(word(19),appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20)))), [
         rule(axiom, le, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(19), []),
         rule(dl, p(0,p(0,long,p(0,de,p(0,'l\'',herbe))),grise), lit(n)-appl(word(24),appl(appl(word(21),appl(word(22),word(23))),word(20))), [
            rule(dl, p(0,long,p(0,de,p(0,'l\'',herbe))), lit(n)-appl(appl(word(21),appl(word(22),word(23))),word(20)), [
               rule(axiom, long, lit(n)-word(20), []),
               rule(dr, p(0,de,p(0,'l\'',herbe)), dl(0,lit(n),lit(n))-appl(word(21),appl(word(22),word(23))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(21), []),
                  rule(dr, p(0,'l\'',herbe), lit(np(_,_,_))-appl(word(22),word(23)), [
                     rule(axiom, 'l\'', dr(0,lit(np(_,_,_)),lit(n))-word(22), []),
                     rule(axiom, herbe, lit(n)-word(23), [])
                     ])
                  ])
               ]),
            rule(axiom, grise, dl(0,lit(n),lit(n))-word(24), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(25), [])
   ])).

% 240. Deux chats orange se poursuivent . 

proof(240, rule(dl, p(0,p(0,p(0,'Deux',p(0,chats,orange)),p(0,se,poursuivent)),'.'), lit(txt)-appl(word(5),appl(appl(word(4),word(3)),appl(word(0),appl(word(2),word(1))))), [
   rule(dl, p(0,p(0,'Deux',p(0,chats,orange)),p(0,se,poursuivent)), lit(s(main))-appl(appl(word(4),word(3)),appl(word(0),appl(word(2),word(1)))), [
      rule(dr, p(0,'Deux',p(0,chats,orange)), lit(np(nom,_,_))-appl(word(0),appl(word(2),word(1))), [
         rule(axiom, 'Deux', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dl, p(0,chats,orange), lit(n)-appl(word(2),word(1)), [
            rule(axiom, chats, lit(n)-word(1), []),
            rule(axiom, orange, dl(0,lit(n),lit(n))-word(2), [])
            ])
         ]),
      rule(dl, p(0,se,poursuivent), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),word(3)), [
         rule(axiom, se, lit(cl_r)-word(3), []),
         rule(axiom, poursuivent, dl(0,lit(cl_r),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(4), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(5), [])
   ])).

% 259. Plus de cinq mecs ont poursuivi deux dames dans la salle de classe . 

proof(259, rule(dl, p(0,p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(13),appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))))), [
   rule(dl, p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
      rule(dl, p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))), lit(s(main))-appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
         rule(dr, p(0,'Plus',p(0,de,p(0,cinq,mecs))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
            rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
            rule(dr, p(0,de,p(0,cinq,mecs)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
               rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
               rule(dr, p(0,cinq,mecs), lit(np(acc,_,_))-appl(word(2),word(3)), [
                  rule(axiom, cinq, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
                  rule(axiom, mecs, lit(n)-word(3), [])
                  ])
               ])
            ]),
         rule(dr, p(0,ont,p(0,poursuivi,p(0,deux,dames))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
            rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(4), []),
            rule(dr, p(0,poursuivi,p(0,deux,dames)), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(5),appl(word(6),word(7))), [
               rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(5), []),
               rule(dr, p(0,deux,dames), lit(np(_,_,_))-appl(word(6),word(7)), [
                  rule(axiom, deux, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                  rule(axiom, dames, lit(n)-word(7), [])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(8), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(9),appl(appl(word(11),word(12)),word(10))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(9), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(11),word(12)),word(10)), [
               rule(axiom, salle, lit(n)-word(10), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(11),word(12)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(11), []),
                  rule(axiom, classe, lit(n)-word(12), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(13), [])
   ])).

% 260. La plupart des mecs ont poursuivi deux dames dans la salle de classe . 

proof(260, rule(dl, p(0,p(1,p(0,p(0,'La',p(0,plupart,p(0,des,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(13),appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))))), [
   rule(dl, p(1,p(0,p(0,'La',p(0,plupart,p(0,des,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
      rule(dl, p(0,p(0,'La',p(0,plupart,p(0,des,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))), lit(s(main))-appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
         rule(dr, p(0,'La',p(0,plupart,p(0,des,mecs))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
            rule(axiom, 'La', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
            rule(dr, p(0,plupart,p(0,des,mecs)), lit(n)-appl(word(1),appl(word(2),word(3))), [
               rule(axiom, plupart, dr(0,lit(n),lit(pp(de)))-word(1), []),
               rule(dr, p(0,des,mecs), lit(pp(de))-appl(word(2),word(3)), [
                  rule(axiom, des, dr(0,lit(pp(de)),lit(n))-word(2), []),
                  rule(axiom, mecs, lit(n)-word(3), [])
                  ])
               ])
            ]),
         rule(dr, p(0,ont,p(0,poursuivi,p(0,deux,dames))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
            rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(4), []),
            rule(dr, p(0,poursuivi,p(0,deux,dames)), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(5),appl(word(6),word(7))), [
               rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(5), []),
               rule(dr, p(0,deux,dames), lit(np(_,_,_))-appl(word(6),word(7)), [
                  rule(axiom, deux, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                  rule(axiom, dames, lit(n)-word(7), [])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(8), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(9),appl(appl(word(11),word(12)),word(10))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(9), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(11),word(12)),word(10)), [
               rule(axiom, salle, lit(n)-word(10), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(11),word(12)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(11), []),
                  rule(axiom, classe, lit(n)-word(12), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(13), [])
   ])).

% 261. Plus de cinq mecs ont poursuivi deux dames dans la salle de classe . 

proof(261, rule(dl, p(0,p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(13),appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))))), [
   rule(dl, p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
      rule(dl, p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))), lit(s(main))-appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
         rule(dr, p(0,'Plus',p(0,de,p(0,cinq,mecs))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
            rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
            rule(dr, p(0,de,p(0,cinq,mecs)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
               rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
               rule(dr, p(0,cinq,mecs), lit(np(acc,_,_))-appl(word(2),word(3)), [
                  rule(axiom, cinq, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
                  rule(axiom, mecs, lit(n)-word(3), [])
                  ])
               ])
            ]),
         rule(dr, p(0,ont,p(0,poursuivi,p(0,deux,dames))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
            rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(4), []),
            rule(dr, p(0,poursuivi,p(0,deux,dames)), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(5),appl(word(6),word(7))), [
               rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(5), []),
               rule(dr, p(0,deux,dames), lit(np(_,_,_))-appl(word(6),word(7)), [
                  rule(axiom, deux, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                  rule(axiom, dames, lit(n)-word(7), [])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(8), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(9),appl(appl(word(11),word(12)),word(10))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(9), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(11),word(12)),word(10)), [
               rule(axiom, salle, lit(n)-word(10), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(11),word(12)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(11), []),
                  rule(axiom, classe, lit(n)-word(12), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(13), [])
   ])).

% 262. Certains mecs ont poursuivi la plupart des dames dans la salle de classe . 

proof(262, rule(dl, p(0,p(1,p(0,p(0,'Certains',mecs),p(0,ont,p(0,poursuivi,p(0,la,p(0,plupart,p(0,des,dames)))))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(13),appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(2),appl(word(3),appl(word(4),appl(word(5),appl(word(6),word(7)))))),appl(word(0),word(1))))), [
   rule(dl, p(1,p(0,p(0,'Certains',mecs),p(0,ont,p(0,poursuivi,p(0,la,p(0,plupart,p(0,des,dames)))))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(2),appl(word(3),appl(word(4),appl(word(5),appl(word(6),word(7)))))),appl(word(0),word(1)))), [
      rule(dl, p(0,p(0,'Certains',mecs),p(0,ont,p(0,poursuivi,p(0,la,p(0,plupart,p(0,des,dames)))))), lit(s(main))-appl(appl(word(2),appl(word(3),appl(word(4),appl(word(5),appl(word(6),word(7)))))),appl(word(0),word(1))), [
         rule(dr, p(0,'Certains',mecs), lit(np(nom,_,_))-appl(word(0),word(1)), [
            rule(axiom, 'Certains', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
            rule(axiom, mecs, lit(n)-word(1), [])
            ]),
         rule(dr, p(0,ont,p(0,poursuivi,p(0,la,p(0,plupart,p(0,des,dames))))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),appl(word(3),appl(word(4),appl(word(5),appl(word(6),word(7)))))), [
            rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(2), []),
            rule(dr, p(0,poursuivi,p(0,la,p(0,plupart,p(0,des,dames)))), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(3),appl(word(4),appl(word(5),appl(word(6),word(7))))), [
               rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(3), []),
               rule(dr, p(0,la,p(0,plupart,p(0,des,dames))), lit(np(_,_,_))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
                  rule(axiom, la, dr(0,lit(np(_,_,_)),lit(n))-word(4), []),
                  rule(dr, p(0,plupart,p(0,des,dames)), lit(n)-appl(word(5),appl(word(6),word(7))), [
                     rule(axiom, plupart, dr(0,lit(n),lit(pp(de)))-word(5), []),
                     rule(dr, p(0,des,dames), lit(pp(de))-appl(word(6),word(7)), [
                        rule(axiom, des, dr(0,lit(pp(de)),lit(n))-word(6), []),
                        rule(axiom, dames, lit(n)-word(7), [])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(8), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(9),appl(appl(word(11),word(12)),word(10))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(9), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(11),word(12)),word(10)), [
               rule(axiom, salle, lit(n)-word(10), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(11),word(12)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(11), []),
                  rule(axiom, classe, lit(n)-word(12), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(13), [])
   ])).

% 263. Plus de cinq mecs ont poursuivi deux dames dans la salle de classe . 

proof(263, rule(dl, p(0,p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(13),appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))))), [
   rule(dl, p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
      rule(dl, p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))), lit(s(main))-appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
         rule(dr, p(0,'Plus',p(0,de,p(0,cinq,mecs))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
            rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
            rule(dr, p(0,de,p(0,cinq,mecs)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
               rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
               rule(dr, p(0,cinq,mecs), lit(np(acc,_,_))-appl(word(2),word(3)), [
                  rule(axiom, cinq, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
                  rule(axiom, mecs, lit(n)-word(3), [])
                  ])
               ])
            ]),
         rule(dr, p(0,ont,p(0,poursuivi,p(0,deux,dames))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
            rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(4), []),
            rule(dr, p(0,poursuivi,p(0,deux,dames)), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(5),appl(word(6),word(7))), [
               rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(5), []),
               rule(dr, p(0,deux,dames), lit(np(_,_,_))-appl(word(6),word(7)), [
                  rule(axiom, deux, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                  rule(axiom, dames, lit(n)-word(7), [])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(8), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(9),appl(appl(word(11),word(12)),word(10))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(9), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(11),word(12)),word(10)), [
               rule(axiom, salle, lit(n)-word(10), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(11),word(12)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(11), []),
                  rule(axiom, classe, lit(n)-word(12), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(13), [])
   ])).

% 264. Aucun mec n' a poursuivi la plupart des dames dans la salle de classe . 

proof(264, rule(dl, p(0,p(1,p(0,p(0,'Aucun',mec),p(0,'n\'',p(0,a,p(0,poursuivi,p(0,la,p(0,plupart,p(0,des,dames))))))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(14),appl(appl(word(9),appl(word(10),appl(appl(word(12),word(13)),word(11)))),appl(appl(word(2),appl(word(3),appl(word(4),appl(word(5),appl(word(6),appl(word(7),word(8))))))),appl(word(0),word(1))))), [
   rule(dl, p(1,p(0,p(0,'Aucun',mec),p(0,'n\'',p(0,a,p(0,poursuivi,p(0,la,p(0,plupart,p(0,des,dames))))))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(9),appl(word(10),appl(appl(word(12),word(13)),word(11)))),appl(appl(word(2),appl(word(3),appl(word(4),appl(word(5),appl(word(6),appl(word(7),word(8))))))),appl(word(0),word(1)))), [
      rule(dl, p(0,p(0,'Aucun',mec),p(0,'n\'',p(0,a,p(0,poursuivi,p(0,la,p(0,plupart,p(0,des,dames))))))), lit(s(main))-appl(appl(word(2),appl(word(3),appl(word(4),appl(word(5),appl(word(6),appl(word(7),word(8))))))),appl(word(0),word(1))), [
         rule(dr, p(0,'Aucun',mec), lit(np(nom,_,_))-appl(word(0),word(1)), [
            rule(axiom, 'Aucun', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
            rule(axiom, mec, lit(n)-word(1), [])
            ]),
         rule(dr, p(0,'n\'',p(0,a,p(0,poursuivi,p(0,la,p(0,plupart,p(0,des,dames)))))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),appl(word(3),appl(word(4),appl(word(5),appl(word(6),appl(word(7),word(8))))))), [
            rule(axiom, 'n\'', dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(2), []),
            rule(dr, p(0,a,p(0,poursuivi,p(0,la,p(0,plupart,p(0,des,dames))))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(3),appl(word(4),appl(word(5),appl(word(6),appl(word(7),word(8)))))), [
               rule(axiom, a, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(3), []),
               rule(dr, p(0,poursuivi,p(0,la,p(0,plupart,p(0,des,dames)))), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(4),appl(word(5),appl(word(6),appl(word(7),word(8))))), [
                  rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(4), []),
                  rule(dr, p(0,la,p(0,plupart,p(0,des,dames))), lit(np(_,_,_))-appl(word(5),appl(word(6),appl(word(7),word(8)))), [
                     rule(axiom, la, dr(0,lit(np(_,_,_)),lit(n))-word(5), []),
                     rule(dr, p(0,plupart,p(0,des,dames)), lit(n)-appl(word(6),appl(word(7),word(8))), [
                        rule(axiom, plupart, dr(0,lit(n),lit(pp(de)))-word(6), []),
                        rule(dr, p(0,des,dames), lit(pp(de))-appl(word(7),word(8)), [
                           rule(axiom, des, dr(0,lit(pp(de)),lit(n))-word(7), []),
                           rule(axiom, dames, lit(n)-word(8), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(9),appl(word(10),appl(appl(word(12),word(13)),word(11)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(9), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(10),appl(appl(word(12),word(13)),word(11))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(10), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(12),word(13)),word(11)), [
               rule(axiom, salle, lit(n)-word(11), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(12),word(13)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(12), []),
                  rule(axiom, classe, lit(n)-word(13), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(14), [])
   ])).

% 265. Plus de cinq mecs ont poursuivi deux dames dans la salle de classe . 

proof(265, rule(dl, p(0,p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(13),appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))))), [
   rule(dl, p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
      rule(dl, p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))), lit(s(main))-appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
         rule(dr, p(0,'Plus',p(0,de,p(0,cinq,mecs))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
            rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
            rule(dr, p(0,de,p(0,cinq,mecs)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
               rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
               rule(dr, p(0,cinq,mecs), lit(np(acc,_,_))-appl(word(2),word(3)), [
                  rule(axiom, cinq, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
                  rule(axiom, mecs, lit(n)-word(3), [])
                  ])
               ])
            ]),
         rule(dr, p(0,ont,p(0,poursuivi,p(0,deux,dames))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
            rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(4), []),
            rule(dr, p(0,poursuivi,p(0,deux,dames)), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(5),appl(word(6),word(7))), [
               rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(5), []),
               rule(dr, p(0,deux,dames), lit(np(_,_,_))-appl(word(6),word(7)), [
                  rule(axiom, deux, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                  rule(axiom, dames, lit(n)-word(7), [])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(8), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(9),appl(appl(word(11),word(12)),word(10))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(9), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(11),word(12)),word(10)), [
               rule(axiom, salle, lit(n)-word(10), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(11),word(12)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(11), []),
                  rule(axiom, classe, lit(n)-word(12), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(13), [])
   ])).

% 266. Pas moins de quatre mecs ont poursuivi deux dames dans la salle de classe . 

proof(266, rule(dl, p(0,p(1,p(0,p(0,'Pas',p(0,moins,p(0,de,p(0,quatre,mecs)))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(14),appl(appl(word(9),appl(word(10),appl(appl(word(12),word(13)),word(11)))),appl(appl(word(5),appl(word(6),appl(word(7),word(8)))),appl(word(0),appl(word(1),appl(word(2),appl(word(3),word(4)))))))), [
   rule(dl, p(1,p(0,p(0,'Pas',p(0,moins,p(0,de,p(0,quatre,mecs)))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(9),appl(word(10),appl(appl(word(12),word(13)),word(11)))),appl(appl(word(5),appl(word(6),appl(word(7),word(8)))),appl(word(0),appl(word(1),appl(word(2),appl(word(3),word(4))))))), [
      rule(dl, p(0,p(0,'Pas',p(0,moins,p(0,de,p(0,quatre,mecs)))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))), lit(s(main))-appl(appl(word(5),appl(word(6),appl(word(7),word(8)))),appl(word(0),appl(word(1),appl(word(2),appl(word(3),word(4)))))), [
         rule(dr, p(0,'Pas',p(0,moins,p(0,de,p(0,quatre,mecs)))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),appl(word(3),word(4))))), [
            rule(axiom, 'Pas', dr(0,lit(np(nom,_,_)),lit(np(_,_,_)))-word(0), []),
            rule(dr, p(0,moins,p(0,de,p(0,quatre,mecs))), lit(np(_,_,_))-appl(word(1),appl(word(2),appl(word(3),word(4)))), [
               rule(axiom, moins, dr(0,lit(np(_,_,_)),lit(pp(de)))-word(1), []),
               rule(dr, p(0,de,p(0,quatre,mecs)), lit(pp(de))-appl(word(2),appl(word(3),word(4))), [
                  rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(2), []),
                  rule(dr, p(0,quatre,mecs), lit(np(acc,_,_))-appl(word(3),word(4)), [
                     rule(axiom, quatre, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                     rule(axiom, mecs, lit(n)-word(4), [])
                     ])
                  ])
               ])
            ]),
         rule(dr, p(0,ont,p(0,poursuivi,p(0,deux,dames))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(5),appl(word(6),appl(word(7),word(8)))), [
            rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(5), []),
            rule(dr, p(0,poursuivi,p(0,deux,dames)), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(6),appl(word(7),word(8))), [
               rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(6), []),
               rule(dr, p(0,deux,dames), lit(np(_,_,_))-appl(word(7),word(8)), [
                  rule(axiom, deux, dr(0,lit(np(_,_,_)),lit(n))-word(7), []),
                  rule(axiom, dames, lit(n)-word(8), [])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(9),appl(word(10),appl(appl(word(12),word(13)),word(11)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(9), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(10),appl(appl(word(12),word(13)),word(11))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(10), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(12),word(13)),word(11)), [
               rule(axiom, salle, lit(n)-word(11), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(12),word(13)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(12), []),
                  rule(axiom, classe, lit(n)-word(13), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(14), [])
   ])).

% 267. Plus de cinq mecs ont poursuivi deux dames dans la salle de classe . 

proof(267, rule(dl, p(0,p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(13),appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))))), [
   rule(dl, p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
      rule(dl, p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))), lit(s(main))-appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
         rule(dr, p(0,'Plus',p(0,de,p(0,cinq,mecs))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
            rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
            rule(dr, p(0,de,p(0,cinq,mecs)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
               rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
               rule(dr, p(0,cinq,mecs), lit(np(acc,_,_))-appl(word(2),word(3)), [
                  rule(axiom, cinq, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
                  rule(axiom, mecs, lit(n)-word(3), [])
                  ])
               ])
            ]),
         rule(dr, p(0,ont,p(0,poursuivi,p(0,deux,dames))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
            rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(4), []),
            rule(dr, p(0,poursuivi,p(0,deux,dames)), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(5),appl(word(6),word(7))), [
               rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(5), []),
               rule(dr, p(0,deux,dames), lit(np(_,_,_))-appl(word(6),word(7)), [
                  rule(axiom, deux, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                  rule(axiom, dames, lit(n)-word(7), [])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(8), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(9),appl(appl(word(11),word(12)),word(10))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(9), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(11),word(12)),word(10)), [
               rule(axiom, salle, lit(n)-word(10), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(11),word(12)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(11), []),
                  rule(axiom, classe, lit(n)-word(12), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(13), [])
   ])).

% 268. Plusieurs mecs ont poursuivi deux dames dans la salle de classe . 

proof(268, rule(dl, p(0,p(1,p(0,p(0,'Plusieurs',mecs),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(11),appl(appl(word(6),appl(word(7),appl(appl(word(9),word(10)),word(8)))),appl(appl(word(2),appl(word(3),appl(word(4),word(5)))),appl(word(0),word(1))))), [
   rule(dl, p(1,p(0,p(0,'Plusieurs',mecs),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(6),appl(word(7),appl(appl(word(9),word(10)),word(8)))),appl(appl(word(2),appl(word(3),appl(word(4),word(5)))),appl(word(0),word(1)))), [
      rule(dl, p(0,p(0,'Plusieurs',mecs),p(0,ont,p(0,poursuivi,p(0,deux,dames)))), lit(s(main))-appl(appl(word(2),appl(word(3),appl(word(4),word(5)))),appl(word(0),word(1))), [
         rule(dr, p(0,'Plusieurs',mecs), lit(np(nom,_,_))-appl(word(0),word(1)), [
            rule(axiom, 'Plusieurs', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
            rule(axiom, mecs, lit(n)-word(1), [])
            ]),
         rule(dr, p(0,ont,p(0,poursuivi,p(0,deux,dames))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),appl(word(3),appl(word(4),word(5)))), [
            rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(2), []),
            rule(dr, p(0,poursuivi,p(0,deux,dames)), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(3),appl(word(4),word(5))), [
               rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(3), []),
               rule(dr, p(0,deux,dames), lit(np(_,_,_))-appl(word(4),word(5)), [
                  rule(axiom, deux, dr(0,lit(np(_,_,_)),lit(n))-word(4), []),
                  rule(axiom, dames, lit(n)-word(5), [])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(6),appl(word(7),appl(appl(word(9),word(10)),word(8)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(6), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(7),appl(appl(word(9),word(10)),word(8))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(7), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(9),word(10)),word(8)), [
               rule(axiom, salle, lit(n)-word(8), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(9),word(10)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(9), []),
                  rule(axiom, classe, lit(n)-word(10), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(11), [])
   ])).

% 269. Plus de cinq mecs ont poursuivi deux dames dans la salle de classe . 

proof(269, rule(dl, p(0,p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(13),appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))))), [
   rule(dl, p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
      rule(dl, p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))), lit(s(main))-appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
         rule(dr, p(0,'Plus',p(0,de,p(0,cinq,mecs))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
            rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
            rule(dr, p(0,de,p(0,cinq,mecs)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
               rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
               rule(dr, p(0,cinq,mecs), lit(np(acc,_,_))-appl(word(2),word(3)), [
                  rule(axiom, cinq, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
                  rule(axiom, mecs, lit(n)-word(3), [])
                  ])
               ])
            ]),
         rule(dr, p(0,ont,p(0,poursuivi,p(0,deux,dames))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
            rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(4), []),
            rule(dr, p(0,poursuivi,p(0,deux,dames)), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(5),appl(word(6),word(7))), [
               rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(5), []),
               rule(dr, p(0,deux,dames), lit(np(_,_,_))-appl(word(6),word(7)), [
                  rule(axiom, deux, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                  rule(axiom, dames, lit(n)-word(7), [])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(8), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(9),appl(appl(word(11),word(12)),word(10))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(9), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(11),word(12)),word(10)), [
               rule(axiom, salle, lit(n)-word(10), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(11),word(12)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(11), []),
                  rule(axiom, classe, lit(n)-word(12), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(13), [])
   ])).

% 270. Plusieurs mecs ont poursuivi plus de trois dames dans la salle de classe . 

proof(270, rule(dl, p(0,p(1,p(0,p(0,'Plusieurs',mecs),p(0,ont,p(0,poursuivi,p(0,plus,p(0,de,p(0,trois,dames)))))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(13),appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(2),appl(word(3),appl(word(4),appl(word(5),appl(word(6),word(7)))))),appl(word(0),word(1))))), [
   rule(dl, p(1,p(0,p(0,'Plusieurs',mecs),p(0,ont,p(0,poursuivi,p(0,plus,p(0,de,p(0,trois,dames)))))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(2),appl(word(3),appl(word(4),appl(word(5),appl(word(6),word(7)))))),appl(word(0),word(1)))), [
      rule(dl, p(0,p(0,'Plusieurs',mecs),p(0,ont,p(0,poursuivi,p(0,plus,p(0,de,p(0,trois,dames)))))), lit(s(main))-appl(appl(word(2),appl(word(3),appl(word(4),appl(word(5),appl(word(6),word(7)))))),appl(word(0),word(1))), [
         rule(dr, p(0,'Plusieurs',mecs), lit(np(nom,_,_))-appl(word(0),word(1)), [
            rule(axiom, 'Plusieurs', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
            rule(axiom, mecs, lit(n)-word(1), [])
            ]),
         rule(dr, p(0,ont,p(0,poursuivi,p(0,plus,p(0,de,p(0,trois,dames))))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),appl(word(3),appl(word(4),appl(word(5),appl(word(6),word(7)))))), [
            rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(2), []),
            rule(dr, p(0,poursuivi,p(0,plus,p(0,de,p(0,trois,dames)))), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(3),appl(word(4),appl(word(5),appl(word(6),word(7))))), [
               rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(3), []),
               rule(dr, p(0,plus,p(0,de,p(0,trois,dames))), lit(np(_,_,_))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
                  rule(axiom, plus, dr(0,lit(np(_,_,_)),lit(pp(de)))-word(4), []),
                  rule(dr, p(0,de,p(0,trois,dames)), lit(pp(de))-appl(word(5),appl(word(6),word(7))), [
                     rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(5), []),
                     rule(dr, p(0,trois,dames), lit(np(acc,_,_))-appl(word(6),word(7)), [
                        rule(axiom, trois, dr(0,lit(np(acc,_,_)),lit(n))-word(6), []),
                        rule(axiom, dames, lit(n)-word(7), [])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(8), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(9),appl(appl(word(11),word(12)),word(10))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(9), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(11),word(12)),word(10)), [
               rule(axiom, salle, lit(n)-word(10), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(11),word(12)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(11), []),
                  rule(axiom, classe, lit(n)-word(12), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(13), [])
   ])).

% 271. Plus de cinq mecs ont poursuivi deux dames dans la salle de classe . 

proof(271, rule(dl, p(0,p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(13),appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))))), [
   rule(dl, p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
      rule(dl, p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))), lit(s(main))-appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
         rule(dr, p(0,'Plus',p(0,de,p(0,cinq,mecs))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
            rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
            rule(dr, p(0,de,p(0,cinq,mecs)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
               rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
               rule(dr, p(0,cinq,mecs), lit(np(acc,_,_))-appl(word(2),word(3)), [
                  rule(axiom, cinq, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
                  rule(axiom, mecs, lit(n)-word(3), [])
                  ])
               ])
            ]),
         rule(dr, p(0,ont,p(0,poursuivi,p(0,deux,dames))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
            rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(4), []),
            rule(dr, p(0,poursuivi,p(0,deux,dames)), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(5),appl(word(6),word(7))), [
               rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(5), []),
               rule(dr, p(0,deux,dames), lit(np(_,_,_))-appl(word(6),word(7)), [
                  rule(axiom, deux, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                  rule(axiom, dames, lit(n)-word(7), [])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(8), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(9),appl(appl(word(11),word(12)),word(10))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(9), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(11),word(12)),word(10)), [
               rule(axiom, salle, lit(n)-word(10), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(11),word(12)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(11), []),
                  rule(axiom, classe, lit(n)-word(12), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(13), [])
   ])).

% 272. Plusieurs mecs ont poursuivi moins de trois dames dans la salle de classe . 

proof(272, rule(dl, p(0,p(1,p(0,p(0,'Plusieurs',mecs),p(0,ont,p(0,poursuivi,p(0,moins,p(0,de,p(0,trois,dames)))))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(13),appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(2),appl(word(3),appl(word(4),appl(word(5),appl(word(6),word(7)))))),appl(word(0),word(1))))), [
   rule(dl, p(1,p(0,p(0,'Plusieurs',mecs),p(0,ont,p(0,poursuivi,p(0,moins,p(0,de,p(0,trois,dames)))))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(2),appl(word(3),appl(word(4),appl(word(5),appl(word(6),word(7)))))),appl(word(0),word(1)))), [
      rule(dl, p(0,p(0,'Plusieurs',mecs),p(0,ont,p(0,poursuivi,p(0,moins,p(0,de,p(0,trois,dames)))))), lit(s(main))-appl(appl(word(2),appl(word(3),appl(word(4),appl(word(5),appl(word(6),word(7)))))),appl(word(0),word(1))), [
         rule(dr, p(0,'Plusieurs',mecs), lit(np(nom,_,_))-appl(word(0),word(1)), [
            rule(axiom, 'Plusieurs', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
            rule(axiom, mecs, lit(n)-word(1), [])
            ]),
         rule(dr, p(0,ont,p(0,poursuivi,p(0,moins,p(0,de,p(0,trois,dames))))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),appl(word(3),appl(word(4),appl(word(5),appl(word(6),word(7)))))), [
            rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(2), []),
            rule(dr, p(0,poursuivi,p(0,moins,p(0,de,p(0,trois,dames)))), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(3),appl(word(4),appl(word(5),appl(word(6),word(7))))), [
               rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(3), []),
               rule(dr, p(0,moins,p(0,de,p(0,trois,dames))), lit(np(_,_,_))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
                  rule(axiom, moins, dr(0,lit(np(_,_,_)),lit(pp(de)))-word(4), []),
                  rule(dr, p(0,de,p(0,trois,dames)), lit(pp(de))-appl(word(5),appl(word(6),word(7))), [
                     rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(5), []),
                     rule(dr, p(0,trois,dames), lit(np(acc,_,_))-appl(word(6),word(7)), [
                        rule(axiom, trois, dr(0,lit(np(acc,_,_)),lit(n))-word(6), []),
                        rule(axiom, dames, lit(n)-word(7), [])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(8), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(9),appl(appl(word(11),word(12)),word(10))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(9), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(11),word(12)),word(10)), [
               rule(axiom, salle, lit(n)-word(10), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(11),word(12)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(11), []),
                  rule(axiom, classe, lit(n)-word(12), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(13), [])
   ])).

% 273. Plus de cinq mecs ont poursuivi deux dames dans la salle de classe . 

proof(273, rule(dl, p(0,p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(13),appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))))), [
   rule(dl, p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
      rule(dl, p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))), lit(s(main))-appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
         rule(dr, p(0,'Plus',p(0,de,p(0,cinq,mecs))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
            rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
            rule(dr, p(0,de,p(0,cinq,mecs)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
               rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
               rule(dr, p(0,cinq,mecs), lit(np(acc,_,_))-appl(word(2),word(3)), [
                  rule(axiom, cinq, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
                  rule(axiom, mecs, lit(n)-word(3), [])
                  ])
               ])
            ]),
         rule(dr, p(0,ont,p(0,poursuivi,p(0,deux,dames))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
            rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(4), []),
            rule(dr, p(0,poursuivi,p(0,deux,dames)), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(5),appl(word(6),word(7))), [
               rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(5), []),
               rule(dr, p(0,deux,dames), lit(np(_,_,_))-appl(word(6),word(7)), [
                  rule(axiom, deux, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                  rule(axiom, dames, lit(n)-word(7), [])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(8), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(9),appl(appl(word(11),word(12)),word(10))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(9), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(11),word(12)),word(10)), [
               rule(axiom, salle, lit(n)-word(10), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(11),word(12)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(11), []),
                  rule(axiom, classe, lit(n)-word(12), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(13), [])
   ])).

% 274. Moins de cinq mecs ont poursuivi toutes les dames dans la salle de classe . 

proof(274, rule(dl, p(0,p(1,p(0,p(0,'Moins',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,toutes,p(0,les,dames))))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(14),appl(appl(word(9),appl(word(10),appl(appl(word(12),word(13)),word(11)))),appl(appl(word(4),appl(word(5),appl(word(6),appl(word(7),word(8))))),appl(word(0),appl(word(1),appl(word(2),word(3))))))), [
   rule(dl, p(1,p(0,p(0,'Moins',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,toutes,p(0,les,dames))))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(9),appl(word(10),appl(appl(word(12),word(13)),word(11)))),appl(appl(word(4),appl(word(5),appl(word(6),appl(word(7),word(8))))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
      rule(dl, p(0,p(0,'Moins',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,toutes,p(0,les,dames))))), lit(s(main))-appl(appl(word(4),appl(word(5),appl(word(6),appl(word(7),word(8))))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
         rule(dr, p(0,'Moins',p(0,de,p(0,cinq,mecs))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
            rule(axiom, 'Moins', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
            rule(dr, p(0,de,p(0,cinq,mecs)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
               rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
               rule(dr, p(0,cinq,mecs), lit(np(acc,_,_))-appl(word(2),word(3)), [
                  rule(axiom, cinq, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
                  rule(axiom, mecs, lit(n)-word(3), [])
                  ])
               ])
            ]),
         rule(dr, p(0,ont,p(0,poursuivi,p(0,toutes,p(0,les,dames)))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),appl(word(6),appl(word(7),word(8))))), [
            rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(4), []),
            rule(dr, p(0,poursuivi,p(0,toutes,p(0,les,dames))), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(5),appl(word(6),appl(word(7),word(8)))), [
               rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(5), []),
               rule(dr, p(0,toutes,p(0,les,dames)), lit(np(_,_,_))-appl(word(6),appl(word(7),word(8))), [
                  rule(axiom, toutes, dr(0,lit(np(_,_,_)),lit(np(_,_,_)))-word(6), []),
                  rule(dr, p(0,les,dames), lit(np(_,_,_))-appl(word(7),word(8)), [
                     rule(axiom, les, dr(0,lit(np(_,_,_)),lit(n))-word(7), []),
                     rule(axiom, dames, lit(n)-word(8), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(9),appl(word(10),appl(appl(word(12),word(13)),word(11)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(9), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(10),appl(appl(word(12),word(13)),word(11))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(10), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(12),word(13)),word(11)), [
               rule(axiom, salle, lit(n)-word(11), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(12),word(13)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(12), []),
                  rule(axiom, classe, lit(n)-word(13), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(14), [])
   ])).

% 275. Plus de cinq mecs ont poursuivi deux dames dans la salle de classe . 

proof(275, rule(dl, p(0,p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(13),appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))))), [
   rule(dl, p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
      rule(dl, p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))), lit(s(main))-appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
         rule(dr, p(0,'Plus',p(0,de,p(0,cinq,mecs))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
            rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
            rule(dr, p(0,de,p(0,cinq,mecs)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
               rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
               rule(dr, p(0,cinq,mecs), lit(np(acc,_,_))-appl(word(2),word(3)), [
                  rule(axiom, cinq, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
                  rule(axiom, mecs, lit(n)-word(3), [])
                  ])
               ])
            ]),
         rule(dr, p(0,ont,p(0,poursuivi,p(0,deux,dames))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
            rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(4), []),
            rule(dr, p(0,poursuivi,p(0,deux,dames)), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(5),appl(word(6),word(7))), [
               rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(5), []),
               rule(dr, p(0,deux,dames), lit(np(_,_,_))-appl(word(6),word(7)), [
                  rule(axiom, deux, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                  rule(axiom, dames, lit(n)-word(7), [])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(8), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(9),appl(appl(word(11),word(12)),word(10))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(9), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(11),word(12)),word(10)), [
               rule(axiom, salle, lit(n)-word(10), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(11),word(12)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(11), []),
                  rule(axiom, classe, lit(n)-word(12), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(13), [])
   ])).

% 276. Deux mecs ont poursuivi deux dames dans la salle de classe . 

proof(276, rule(dl, p(0,p(1,p(0,p(0,'Deux',mecs),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(11),appl(appl(word(6),appl(word(7),appl(appl(word(9),word(10)),word(8)))),appl(appl(word(2),appl(word(3),appl(word(4),word(5)))),appl(word(0),word(1))))), [
   rule(dl, p(1,p(0,p(0,'Deux',mecs),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(6),appl(word(7),appl(appl(word(9),word(10)),word(8)))),appl(appl(word(2),appl(word(3),appl(word(4),word(5)))),appl(word(0),word(1)))), [
      rule(dl, p(0,p(0,'Deux',mecs),p(0,ont,p(0,poursuivi,p(0,deux,dames)))), lit(s(main))-appl(appl(word(2),appl(word(3),appl(word(4),word(5)))),appl(word(0),word(1))), [
         rule(dr, p(0,'Deux',mecs), lit(np(nom,_,_))-appl(word(0),word(1)), [
            rule(axiom, 'Deux', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
            rule(axiom, mecs, lit(n)-word(1), [])
            ]),
         rule(dr, p(0,ont,p(0,poursuivi,p(0,deux,dames))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),appl(word(3),appl(word(4),word(5)))), [
            rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(2), []),
            rule(dr, p(0,poursuivi,p(0,deux,dames)), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(3),appl(word(4),word(5))), [
               rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(3), []),
               rule(dr, p(0,deux,dames), lit(np(_,_,_))-appl(word(4),word(5)), [
                  rule(axiom, deux, dr(0,lit(np(_,_,_)),lit(n))-word(4), []),
                  rule(axiom, dames, lit(n)-word(5), [])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(6),appl(word(7),appl(appl(word(9),word(10)),word(8)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(6), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(7),appl(appl(word(9),word(10)),word(8))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(7), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(9),word(10)),word(8)), [
               rule(axiom, salle, lit(n)-word(8), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(9),word(10)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(9), []),
                  rule(axiom, classe, lit(n)-word(10), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(11), [])
   ])).

% 277. Plus de cinq mecs ont poursuivi deux dames dans la salle de classe . 

proof(277, rule(dl, p(0,p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(13),appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))))), [
   rule(dl, p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
      rule(dl, p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))), lit(s(main))-appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
         rule(dr, p(0,'Plus',p(0,de,p(0,cinq,mecs))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
            rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
            rule(dr, p(0,de,p(0,cinq,mecs)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
               rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
               rule(dr, p(0,cinq,mecs), lit(np(acc,_,_))-appl(word(2),word(3)), [
                  rule(axiom, cinq, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
                  rule(axiom, mecs, lit(n)-word(3), [])
                  ])
               ])
            ]),
         rule(dr, p(0,ont,p(0,poursuivi,p(0,deux,dames))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
            rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(4), []),
            rule(dr, p(0,poursuivi,p(0,deux,dames)), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(5),appl(word(6),word(7))), [
               rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(5), []),
               rule(dr, p(0,deux,dames), lit(np(_,_,_))-appl(word(6),word(7)), [
                  rule(axiom, deux, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                  rule(axiom, dames, lit(n)-word(7), [])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(8), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(9),appl(appl(word(11),word(12)),word(10))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(9), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(11),word(12)),word(10)), [
               rule(axiom, salle, lit(n)-word(10), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(11),word(12)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(11), []),
                  rule(axiom, classe, lit(n)-word(12), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(13), [])
   ])).

% 278. 100 % des mecs ont poursuivi deux dames dans la salle de classe . 

proof(278, rule(dl, p(0,p(1,p(0,p(0,100,p(0,'%',p(0,des,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(13),appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(appl(word(2),word(3)),word(1)))))), [
   rule(dl, p(1,p(0,p(0,100,p(0,'%',p(0,des,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(appl(word(2),word(3)),word(1))))), [
      rule(dl, p(0,p(0,100,p(0,'%',p(0,des,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))), lit(s(main))-appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(appl(word(2),word(3)),word(1)))), [
         rule(dr, p(0,100,p(0,'%',p(0,des,mecs))), lit(np(nom,_,_))-appl(word(0),appl(appl(word(2),word(3)),word(1))), [
            rule(axiom, 100, dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
            rule(dl, p(0,'%',p(0,des,mecs)), lit(n)-appl(appl(word(2),word(3)),word(1)), [
               rule(axiom, '%', lit(n)-word(1), []),
               rule(dr, p(0,des,mecs), dl(0,lit(n),lit(n))-appl(word(2),word(3)), [
                  rule(axiom, des, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(2), []),
                  rule(axiom, mecs, lit(n)-word(3), [])
                  ])
               ])
            ]),
         rule(dr, p(0,ont,p(0,poursuivi,p(0,deux,dames))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
            rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(4), []),
            rule(dr, p(0,poursuivi,p(0,deux,dames)), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(5),appl(word(6),word(7))), [
               rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(5), []),
               rule(dr, p(0,deux,dames), lit(np(_,_,_))-appl(word(6),word(7)), [
                  rule(axiom, deux, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                  rule(axiom, dames, lit(n)-word(7), [])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(8), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(9),appl(appl(word(11),word(12)),word(10))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(9), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(11),word(12)),word(10)), [
               rule(axiom, salle, lit(n)-word(10), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(11),word(12)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(11), []),
                  rule(axiom, classe, lit(n)-word(12), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(13), [])
   ])).

% 279. Plus de cinq mecs ont poursuivi deux dames dans la salle de classe . 

proof(279, rule(dl, p(0,p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(13),appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))))), [
   rule(dl, p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
      rule(dl, p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))), lit(s(main))-appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
         rule(dr, p(0,'Plus',p(0,de,p(0,cinq,mecs))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
            rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
            rule(dr, p(0,de,p(0,cinq,mecs)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
               rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
               rule(dr, p(0,cinq,mecs), lit(np(acc,_,_))-appl(word(2),word(3)), [
                  rule(axiom, cinq, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
                  rule(axiom, mecs, lit(n)-word(3), [])
                  ])
               ])
            ]),
         rule(dr, p(0,ont,p(0,poursuivi,p(0,deux,dames))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
            rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(4), []),
            rule(dr, p(0,poursuivi,p(0,deux,dames)), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(5),appl(word(6),word(7))), [
               rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(5), []),
               rule(dr, p(0,deux,dames), lit(np(_,_,_))-appl(word(6),word(7)), [
                  rule(axiom, deux, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                  rule(axiom, dames, lit(n)-word(7), [])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(8), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(9),appl(appl(word(11),word(12)),word(10))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(9), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(11),word(12)),word(10)), [
               rule(axiom, salle, lit(n)-word(10), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(11),word(12)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(11), []),
                  rule(axiom, classe, lit(n)-word(12), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(13), [])
   ])).

% 280. Les deux tiers des mecs ont poursuivi deux dames dans la salle de classe . 

proof(280, rule(dl, p(0,p(1,p(0,p(0,'Les',p(0,p(0,deux,tiers),p(0,des,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(14),appl(appl(word(9),appl(word(10),appl(appl(word(12),word(13)),word(11)))),appl(appl(word(5),appl(word(6),appl(word(7),word(8)))),appl(word(0),appl(appl(word(3),word(4)),appl(word(1),word(2))))))), [
   rule(dl, p(1,p(0,p(0,'Les',p(0,p(0,deux,tiers),p(0,des,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(9),appl(word(10),appl(appl(word(12),word(13)),word(11)))),appl(appl(word(5),appl(word(6),appl(word(7),word(8)))),appl(word(0),appl(appl(word(3),word(4)),appl(word(1),word(2)))))), [
      rule(dl, p(0,p(0,'Les',p(0,p(0,deux,tiers),p(0,des,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))), lit(s(main))-appl(appl(word(5),appl(word(6),appl(word(7),word(8)))),appl(word(0),appl(appl(word(3),word(4)),appl(word(1),word(2))))), [
         rule(dr, p(0,'Les',p(0,p(0,deux,tiers),p(0,des,mecs))), lit(np(nom,_,_))-appl(word(0),appl(appl(word(3),word(4)),appl(word(1),word(2)))), [
            rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
            rule(dl, p(0,p(0,deux,tiers),p(0,des,mecs)), lit(n)-appl(appl(word(3),word(4)),appl(word(1),word(2))), [
               rule(dr, p(0,deux,tiers), lit(n)-appl(word(1),word(2)), [
                  rule(axiom, deux, dr(0,lit(n),lit(n))-word(1), []),
                  rule(axiom, tiers, lit(n)-word(2), [])
                  ]),
               rule(dr, p(0,des,mecs), dl(0,lit(n),lit(n))-appl(word(3),word(4)), [
                  rule(axiom, des, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(3), []),
                  rule(axiom, mecs, lit(n)-word(4), [])
                  ])
               ])
            ]),
         rule(dr, p(0,ont,p(0,poursuivi,p(0,deux,dames))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(5),appl(word(6),appl(word(7),word(8)))), [
            rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(5), []),
            rule(dr, p(0,poursuivi,p(0,deux,dames)), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(6),appl(word(7),word(8))), [
               rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(6), []),
               rule(dr, p(0,deux,dames), lit(np(_,_,_))-appl(word(7),word(8)), [
                  rule(axiom, deux, dr(0,lit(np(_,_,_)),lit(n))-word(7), []),
                  rule(axiom, dames, lit(n)-word(8), [])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(9),appl(word(10),appl(appl(word(12),word(13)),word(11)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(9), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(10),appl(appl(word(12),word(13)),word(11))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(10), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(12),word(13)),word(11)), [
               rule(axiom, salle, lit(n)-word(11), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(12),word(13)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(12), []),
                  rule(axiom, classe, lit(n)-word(13), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(14), [])
   ])).

% 281. Plus de cinq mecs ont poursuivi deux dames dans la salle de classe . 

proof(281, rule(dl, p(0,p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(13),appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))))), [
   rule(dl, p(1,p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
      rule(dl, p(0,p(0,'Plus',p(0,de,p(0,cinq,mecs))),p(0,ont,p(0,poursuivi,p(0,deux,dames)))), lit(s(main))-appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
         rule(dr, p(0,'Plus',p(0,de,p(0,cinq,mecs))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
            rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
            rule(dr, p(0,de,p(0,cinq,mecs)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
               rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
               rule(dr, p(0,cinq,mecs), lit(np(acc,_,_))-appl(word(2),word(3)), [
                  rule(axiom, cinq, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
                  rule(axiom, mecs, lit(n)-word(3), [])
                  ])
               ])
            ]),
         rule(dr, p(0,ont,p(0,poursuivi,p(0,deux,dames))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
            rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(4), []),
            rule(dr, p(0,poursuivi,p(0,deux,dames)), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(5),appl(word(6),word(7))), [
               rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(5), []),
               rule(dr, p(0,deux,dames), lit(np(_,_,_))-appl(word(6),word(7)), [
                  rule(axiom, deux, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                  rule(axiom, dames, lit(n)-word(7), [])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(8), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(9),appl(appl(word(11),word(12)),word(10))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(9), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(11),word(12)),word(10)), [
               rule(axiom, salle, lit(n)-word(10), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(11),word(12)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(11), []),
                  rule(axiom, classe, lit(n)-word(12), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(13), [])
   ])).

% 282. Quelques mecs n' ont pas poursuivi les dames dans la salle de classe . 

proof(282, rule(dl, p(0,p(1,p(0,p(0,'Quelques',mecs),p(0,'n\'',p(0,ont,p(0,pas,p(0,poursuivi,p(0,les,dames)))))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))),'.'), lit(txt)-appl(word(13),appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(2),appl(word(3),appl(word(4),appl(word(5),appl(word(6),word(7)))))),appl(word(0),word(1))))), [
   rule(dl, p(1,p(0,p(0,'Quelques',mecs),p(0,'n\'',p(0,ont,p(0,pas,p(0,poursuivi,p(0,les,dames)))))),p(0,dans,p(0,la,p(0,salle,p(0,de,classe))))), lit(s(main))-appl(appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))),appl(appl(word(2),appl(word(3),appl(word(4),appl(word(5),appl(word(6),word(7)))))),appl(word(0),word(1)))), [
      rule(dl, p(0,p(0,'Quelques',mecs),p(0,'n\'',p(0,ont,p(0,pas,p(0,poursuivi,p(0,les,dames)))))), lit(s(main))-appl(appl(word(2),appl(word(3),appl(word(4),appl(word(5),appl(word(6),word(7)))))),appl(word(0),word(1))), [
         rule(dr, p(0,'Quelques',mecs), lit(np(nom,_,_))-appl(word(0),word(1)), [
            rule(axiom, 'Quelques', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
            rule(axiom, mecs, lit(n)-word(1), [])
            ]),
         rule(dr, p(0,'n\'',p(0,ont,p(0,pas,p(0,poursuivi,p(0,les,dames))))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),appl(word(3),appl(word(4),appl(word(5),appl(word(6),word(7)))))), [
            rule(axiom, 'n\'', dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(2), []),
            rule(dr, p(0,ont,p(0,pas,p(0,poursuivi,p(0,les,dames)))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(3),appl(word(4),appl(word(5),appl(word(6),word(7))))), [
               rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(3), []),
               rule(dr, p(0,pas,p(0,poursuivi,p(0,les,dames))), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
                  rule(axiom, pas, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(4), []),
                  rule(dr, p(0,poursuivi,p(0,les,dames)), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(5),appl(word(6),word(7))), [
                     rule(axiom, poursuivi, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(np(_,_,_)))-word(5), []),
                     rule(dr, p(0,les,dames), lit(np(_,_,_))-appl(word(6),word(7)), [
                        rule(axiom, les, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                        rule(axiom, dames, lit(n)-word(7), [])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,la,p(0,salle,p(0,de,classe)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(8),appl(word(9),appl(appl(word(11),word(12)),word(10)))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(8), []),
         rule(dr, p(0,la,p(0,salle,p(0,de,classe))), lit(np(acc,_,_))-appl(word(9),appl(appl(word(11),word(12)),word(10))), [
            rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(9), []),
            rule(dl, p(0,salle,p(0,de,classe)), lit(n)-appl(appl(word(11),word(12)),word(10)), [
               rule(axiom, salle, lit(n)-word(10), []),
               rule(dr, p(0,de,classe), dl(0,lit(n),lit(n))-appl(word(11),word(12)), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(11), []),
                  rule(axiom, classe, lit(n)-word(12), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(13), [])
   ])).

% 301. Il y a 12 enfants debout au sommet d' une montagne jaune . Un tiers portent des hauts orange , un tiers portent des hauts gris et un tiers portent des hauts noirs . 

proof(301, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,12,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,p(0,'Un',tiers),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,',',p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,noirs)))))))),'.'), lit(txt)-appl(word(33),appl(appl(word(12),appl(appl(word(26),appl(appl(word(29),appl(word(30),appl(word(32),word(31)))),appl(word(27),word(28)))),appl(appl(word(19),appl(appl(word(22),appl(word(23),appl(word(25),word(24)))),appl(word(20),word(21)))),appl(appl(word(15),appl(word(16),appl(word(18),word(17)))),appl(word(13),word(14)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,12,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,p(0,'Un',tiers),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,',',p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,noirs)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(26),appl(appl(word(29),appl(word(30),appl(word(32),word(31)))),appl(word(27),word(28)))),appl(appl(word(19),appl(appl(word(22),appl(word(23),appl(word(25),word(24)))),appl(word(20),word(21)))),appl(appl(word(15),appl(word(16),appl(word(18),word(17)))),appl(word(13),word(14)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,12,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,12,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,12,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,12,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, 12, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,p(0,'Un',tiers),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,',',p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,noirs))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(26),appl(appl(word(29),appl(word(30),appl(word(32),word(31)))),appl(word(27),word(28)))),appl(appl(word(19),appl(appl(word(22),appl(word(23),appl(word(25),word(24)))),appl(word(20),word(21)))),appl(appl(word(15),appl(word(16),appl(word(18),word(17)))),appl(word(13),word(14)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,p(0,'Un',tiers),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,',',p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,noirs)))))), lit(s(main))-appl(appl(word(26),appl(appl(word(29),appl(word(30),appl(word(32),word(31)))),appl(word(27),word(28)))),appl(appl(word(19),appl(appl(word(22),appl(word(23),appl(word(25),word(24)))),appl(word(20),word(21)))),appl(appl(word(15),appl(word(16),appl(word(18),word(17)))),appl(word(13),word(14))))), [
            rule(dl, p(0,p(0,p(0,'Un',tiers),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,',',p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))), lit(s(main))-appl(appl(word(19),appl(appl(word(22),appl(word(23),appl(word(25),word(24)))),appl(word(20),word(21)))),appl(appl(word(15),appl(word(16),appl(word(18),word(17)))),appl(word(13),word(14)))), [
               rule(dl, p(0,p(0,'Un',tiers),p(0,portent,p(0,des,p(0,hauts,orange)))), lit(s(main))-appl(appl(word(15),appl(word(16),appl(word(18),word(17)))),appl(word(13),word(14))), [
                  rule(dr, p(0,'Un',tiers), lit(np(nom,_,_))-appl(word(13),word(14)), [
                     rule(axiom, 'Un', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                     rule(axiom, tiers, lit(n)-word(14), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,orange))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(15),appl(word(16),appl(word(18),word(17)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(15), []),
                     rule(dr, p(0,des,p(0,hauts,orange)), lit(np(acc,_,_))-appl(word(16),appl(word(18),word(17))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(16), []),
                        rule(dl, p(0,hauts,orange), lit(n)-appl(word(18),word(17)), [
                           rule(axiom, hauts, lit(n)-word(17), []),
                           rule(axiom, orange, dl(0,lit(n),lit(n))-word(18), [])
                           ])
                        ])
                     ])
                  ]),
               rule(dr, p(0,',',p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(19),appl(appl(word(22),appl(word(23),appl(word(25),word(24)))),appl(word(20),word(21)))), [
                  rule(axiom, ',', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(19), []),
                  rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))), lit(s(main))-appl(appl(word(22),appl(word(23),appl(word(25),word(24)))),appl(word(20),word(21))), [
                     rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(20),word(21)), [
                        rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(20), []),
                        rule(axiom, tiers, lit(n)-word(21), [])
                        ]),
                     rule(dr, p(0,portent,p(0,des,p(0,hauts,gris))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(22),appl(word(23),appl(word(25),word(24)))), [
                        rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(22), []),
                        rule(dr, p(0,des,p(0,hauts,gris)), lit(np(acc,_,_))-appl(word(23),appl(word(25),word(24))), [
                           rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(23), []),
                           rule(dl, p(0,hauts,gris), lit(n)-appl(word(25),word(24)), [
                              rule(axiom, hauts, lit(n)-word(24), []),
                              rule(axiom, gris, dl(0,lit(n),lit(n))-word(25), [])
                              ])
                           ])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,noirs))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(26),appl(appl(word(29),appl(word(30),appl(word(32),word(31)))),appl(word(27),word(28)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(26), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,noirs)))), lit(s(main))-appl(appl(word(29),appl(word(30),appl(word(32),word(31)))),appl(word(27),word(28))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(27),word(28)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(27), []),
                     rule(axiom, tiers, lit(n)-word(28), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,noirs))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(29),appl(word(30),appl(word(32),word(31)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(29), []),
                     rule(dr, p(0,des,p(0,hauts,noirs)), lit(np(acc,_,_))-appl(word(30),appl(word(32),word(31))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(30), []),
                        rule(dl, p(0,hauts,noirs), lit(n)-appl(word(32),word(31)), [
                           rule(axiom, hauts, lit(n)-word(31), []),
                           rule(axiom, noirs, dl(0,lit(n),lit(n))-word(32), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(33), [])
   ])).

% 302. Six enfants portant des hauts orange se tiennent au sommet d' une montagne . 

proof(302, rule(dl, p(0,p(0,p(0,'Six',p(0,p(0,enfants,p(0,portant,p(0,des,hauts))),orange)),p(0,se,p(0,tiennent,p(0,au,p(0,sommet,p(0,'d\'',p(0,une,montagne))))))),'.'), lit(txt)-appl(word(13),appl(appl(appl(word(7),appl(word(8),appl(appl(word(10),appl(word(11),word(12))),word(9)))),word(6)),appl(word(0),appl(word(5),appl(appl(word(2),appl(word(3),word(4))),word(1)))))), [
   rule(dl, p(0,p(0,'Six',p(0,p(0,enfants,p(0,portant,p(0,des,hauts))),orange)),p(0,se,p(0,tiennent,p(0,au,p(0,sommet,p(0,'d\'',p(0,une,montagne))))))), lit(s(main))-appl(appl(appl(word(7),appl(word(8),appl(appl(word(10),appl(word(11),word(12))),word(9)))),word(6)),appl(word(0),appl(word(5),appl(appl(word(2),appl(word(3),word(4))),word(1))))), [
      rule(dr, p(0,'Six',p(0,p(0,enfants,p(0,portant,p(0,des,hauts))),orange)), lit(np(nom,_,_))-appl(word(0),appl(word(5),appl(appl(word(2),appl(word(3),word(4))),word(1)))), [
         rule(axiom, 'Six', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dl, p(0,p(0,enfants,p(0,portant,p(0,des,hauts))),orange), lit(n)-appl(word(5),appl(appl(word(2),appl(word(3),word(4))),word(1))), [
            rule(dl, p(0,enfants,p(0,portant,p(0,des,hauts))), lit(n)-appl(appl(word(2),appl(word(3),word(4))),word(1)), [
               rule(axiom, enfants, lit(n)-word(1), []),
               rule(dr, p(0,portant,p(0,des,hauts)), dl(0,lit(n),lit(n))-appl(word(2),appl(word(3),word(4))), [
                  rule(axiom, portant, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(2), []),
                  rule(dr, p(0,des,hauts), lit(np(_,_,_))-appl(word(3),word(4)), [
                     rule(axiom, des, dr(0,lit(np(_,_,_)),lit(n))-word(3), []),
                     rule(axiom, hauts, lit(n)-word(4), [])
                     ])
                  ])
               ]),
            rule(axiom, orange, dl(0,lit(n),lit(n))-word(5), [])
            ])
         ]),
      rule(dl, p(0,se,p(0,tiennent,p(0,au,p(0,sommet,p(0,'d\'',p(0,une,montagne)))))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(appl(word(7),appl(word(8),appl(appl(word(10),appl(word(11),word(12))),word(9)))),word(6)), [
         rule(axiom, se, lit(cl_r)-word(6), []),
         rule(dr, p(0,tiennent,p(0,au,p(0,sommet,p(0,'d\'',p(0,une,montagne))))), dl(0,lit(cl_r),dl(0,lit(np(nom,_,_)),lit(s(main))))-appl(word(7),appl(word(8),appl(appl(word(10),appl(word(11),word(12))),word(9)))), [
            rule(axiom, tiennent, dr(0,dl(0,lit(cl_r),dl(0,lit(np(nom,_,_)),lit(s(main)))),lit(pp(à)))-word(7), []),
            rule(dr, p(0,au,p(0,sommet,p(0,'d\'',p(0,une,montagne)))), lit(pp(à))-appl(word(8),appl(appl(word(10),appl(word(11),word(12))),word(9))), [
               rule(axiom, au, dr(0,lit(pp(à)),lit(n))-word(8), []),
               rule(dl, p(0,sommet,p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(10),appl(word(11),word(12))),word(9)), [
                  rule(axiom, sommet, lit(n)-word(9), []),
                  rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(10),appl(word(11),word(12))), [
                     rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(10), []),
                     rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(11),word(12)), [
                        rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(11), []),
                        rule(axiom, montagne, lit(n)-word(12), [])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(13), [])
   ])).

% 303. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts orange et un tiers portent des hauts gris . 

proof(303, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,orange))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,orange)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,orange), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, orange, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,gris))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,gris)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,gris), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, gris, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 305. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts orange et un tiers portent des hauts gris . 

proof(305, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,orange))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,orange)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,orange), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, orange, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,gris))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,gris)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,gris), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, gris, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 307. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts orange et un tiers portent des hauts gris . 

proof(307, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,orange))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,orange)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,orange), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, orange, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,gris))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,gris)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,gris), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, gris, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 308. Quatre enfants portent des hauts orange . 

proof(308, rule(dl, p(0,p(0,p(0,'Quatre',enfants),p(0,portent,p(0,des,p(0,hauts,orange)))),'.'), lit(txt)-appl(word(6),appl(appl(word(2),appl(word(3),appl(word(5),word(4)))),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Quatre',enfants),p(0,portent,p(0,des,p(0,hauts,orange)))), lit(s(main))-appl(appl(word(2),appl(word(3),appl(word(5),word(4)))),appl(word(0),word(1))), [
      rule(dr, p(0,'Quatre',enfants), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Quatre', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, enfants, lit(n)-word(1), [])
         ]),
      rule(dr, p(0,portent,p(0,des,p(0,hauts,orange))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),appl(word(3),appl(word(5),word(4)))), [
         rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(2), []),
         rule(dr, p(0,des,p(0,hauts,orange)), lit(np(acc,_,_))-appl(word(3),appl(word(5),word(4))), [
            rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
            rule(dl, p(0,hauts,orange), lit(n)-appl(word(5),word(4)), [
               rule(axiom, hauts, lit(n)-word(4), []),
               rule(axiom, orange, dl(0,lit(n),lit(n))-word(5), [])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(6), [])
   ])).

% 309. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts orange et un tiers portent des hauts gris . 

proof(309, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,orange))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,orange)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,orange), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, orange, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,gris))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,gris)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,gris), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, gris, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 311. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts orange et un tiers portent des hauts gris . 

proof(311, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,orange))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,orange)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,orange), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, orange, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,gris))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,gris)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,gris), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, gris, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 312. Tous les enfants portent des hauts . 

proof(312, rule(dl, p(0,p(0,p(0,'Tous',p(0,les,enfants)),p(0,portent,p(0,des,hauts))),'.'), lit(txt)-appl(word(6),appl(appl(word(3),appl(word(4),word(5))),appl(word(0),appl(word(1),word(2))))), [
   rule(dl, p(0,p(0,'Tous',p(0,les,enfants)),p(0,portent,p(0,des,hauts))), lit(s(main))-appl(appl(word(3),appl(word(4),word(5))),appl(word(0),appl(word(1),word(2)))), [
      rule(dr, p(0,'Tous',p(0,les,enfants)), lit(np(nom,_,_))-appl(word(0),appl(word(1),word(2))), [
         rule(axiom, 'Tous', dr(0,lit(np(nom,_,_)),lit(np(_,_,_)))-word(0), []),
         rule(dr, p(0,les,enfants), lit(np(_,_,_))-appl(word(1),word(2)), [
            rule(axiom, les, dr(0,lit(np(_,_,_)),lit(n))-word(1), []),
            rule(axiom, enfants, lit(n)-word(2), [])
            ])
         ]),
      rule(dr, p(0,portent,p(0,des,hauts)), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(3),appl(word(4),word(5))), [
         rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(3), []),
         rule(dr, p(0,des,hauts), lit(np(acc,_,_))-appl(word(4),word(5)), [
            rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(4), []),
            rule(axiom, hauts, lit(n)-word(5), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(6), [])
   ])).

% 313. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts orange et un tiers portent des hauts gris . 

proof(313, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,orange))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,orange)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,orange), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, orange, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,gris))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,gris)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,gris), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, gris, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 315. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts orange et un tiers portent des hauts gris . 

proof(315, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,orange))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,orange)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,orange), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, orange, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,gris))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,gris)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,gris), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, gris, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 316. Moins de cinq enfants portent des hauts orange . 

proof(316, rule(dl, p(0,p(0,p(0,'Moins',p(0,de,p(0,cinq,enfants))),p(0,portent,p(0,des,p(0,hauts,orange)))),'.'), lit(txt)-appl(word(8),appl(appl(word(4),appl(word(5),appl(word(7),word(6)))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'Moins',p(0,de,p(0,cinq,enfants))),p(0,portent,p(0,des,p(0,hauts,orange)))), lit(s(main))-appl(appl(word(4),appl(word(5),appl(word(7),word(6)))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'Moins',p(0,de,p(0,cinq,enfants))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'Moins', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
         rule(dr, p(0,de,p(0,cinq,enfants)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
            rule(dr, p(0,cinq,enfants), lit(np(acc,_,_))-appl(word(2),word(3)), [
               rule(axiom, cinq, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
               rule(axiom, enfants, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(dr, p(0,portent,p(0,des,p(0,hauts,orange))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),appl(word(7),word(6)))), [
         rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(4), []),
         rule(dr, p(0,des,p(0,hauts,orange)), lit(np(acc,_,_))-appl(word(5),appl(word(7),word(6))), [
            rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(5), []),
            rule(dl, p(0,hauts,orange), lit(n)-appl(word(7),word(6)), [
               rule(axiom, hauts, lit(n)-word(6), []),
               rule(axiom, orange, dl(0,lit(n),lit(n))-word(7), [])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(8), [])
   ])).

% 317. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts orange et un tiers portent des hauts gris . 

proof(317, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,orange))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,orange)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,orange), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, orange, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,gris))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,gris)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,gris), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, gris, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 319. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts orange et un tiers portent des hauts gris . 

proof(319, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,orange))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,orange)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,orange), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, orange, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,gris))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,gris)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,gris), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, gris, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 321. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts orange et un tiers portent des hauts gris . 

proof(321, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,orange))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,orange)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,orange), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, orange, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,gris))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,gris)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,gris), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, gris, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 323. Il y a six enfants debout au sommet d' une montagne jaune . Les deux tiers portent des hauts orange et un tiers portent des hauts gris . 

proof(323, rule(dl, p(0,p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))))),'.'), lit(txt)-appl(word(27),appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)))), [
   rule(dl, p(0,p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))),p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))))), lit(s(main))-appl(appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))),appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))))), lit(s(main))-appl(appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,a,p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))))), [
               rule(axiom, a, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,six,p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune)), lit(np(acc,_,_))-appl(word(3),appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))))), [
                  rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
                  rule(dl, p(0,p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))),jaune), lit(n)-appl(word(11),appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4))))), [
                     rule(dl, p(0,p(0,p(0,enfants,debout),p(0,au,sommet)),p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(8),appl(word(9),word(10))),appl(appl(word(6),word(7)),appl(word(5),word(4)))), [
                        rule(dl, p(0,p(0,enfants,debout),p(0,au,sommet)), lit(n)-appl(appl(word(6),word(7)),appl(word(5),word(4))), [
                           rule(dl, p(0,enfants,debout), lit(n)-appl(word(5),word(4)), [
                              rule(axiom, enfants, lit(n)-word(4), []),
                              rule(axiom, debout, dl(0,lit(n),lit(n))-word(5), [])
                              ]),
                           rule(dr, p(0,au,sommet), dl(0,lit(n),lit(n))-appl(word(6),word(7)), [
                              rule(axiom, au, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(6), []),
                              rule(axiom, sommet, lit(n)-word(7), [])
                              ])
                           ]),
                        rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(8),appl(word(9),word(10))), [
                           rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(8), []),
                           rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(9),word(10)), [
                              rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(9), []),
                              rule(axiom, montagne, lit(n)-word(10), [])
                              ])
                           ])
                        ]),
                     rule(axiom, jaune, dl(0,lit(n),lit(n))-word(11), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,'.',p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(12),appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))))), [
         rule(axiom, '.', dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(12), []),
         rule(dl, p(0,p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))),p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))))), lit(s(main))-appl(appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))),appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15))))), [
            rule(dl, p(0,p(0,'Les',p(0,deux,tiers)),p(0,portent,p(0,des,p(0,hauts,orange)))), lit(s(main))-appl(appl(word(16),appl(word(17),appl(word(19),word(18)))),appl(word(13),appl(word(14),word(15)))), [
               rule(dr, p(0,'Les',p(0,deux,tiers)), lit(np(nom,_,_))-appl(word(13),appl(word(14),word(15))), [
                  rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(13), []),
                  rule(dr, p(0,deux,tiers), lit(n)-appl(word(14),word(15)), [
                     rule(axiom, deux, dr(0,lit(n),lit(n))-word(14), []),
                     rule(axiom, tiers, lit(n)-word(15), [])
                     ])
                  ]),
               rule(dr, p(0,portent,p(0,des,p(0,hauts,orange))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(16),appl(word(17),appl(word(19),word(18)))), [
                  rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(16), []),
                  rule(dr, p(0,des,p(0,hauts,orange)), lit(np(acc,_,_))-appl(word(17),appl(word(19),word(18))), [
                     rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(17), []),
                     rule(dl, p(0,hauts,orange), lit(n)-appl(word(19),word(18)), [
                        rule(axiom, hauts, lit(n)-word(18), []),
                        rule(axiom, orange, dl(0,lit(n),lit(n))-word(19), [])
                        ])
                     ])
                  ])
               ]),
            rule(dr, p(0,et,p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris))))), dl(0,lit(s(main)),lit(s(main)))-appl(word(20),appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22)))), [
               rule(axiom, et, dr(0,dl(0,lit(s(main)),lit(s(main))),lit(s(main)))-word(20), []),
               rule(dl, p(0,p(0,un,tiers),p(0,portent,p(0,des,p(0,hauts,gris)))), lit(s(main))-appl(appl(word(23),appl(word(24),appl(word(26),word(25)))),appl(word(21),word(22))), [
                  rule(dr, p(0,un,tiers), lit(np(nom,_,_))-appl(word(21),word(22)), [
                     rule(axiom, un, dr(0,lit(np(nom,_,_)),lit(n))-word(21), []),
                     rule(axiom, tiers, lit(n)-word(22), [])
                     ]),
                  rule(dr, p(0,portent,p(0,des,p(0,hauts,gris))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(23),appl(word(24),appl(word(26),word(25)))), [
                     rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(23), []),
                     rule(dr, p(0,des,p(0,hauts,gris)), lit(np(acc,_,_))-appl(word(24),appl(word(26),word(25))), [
                        rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(24), []),
                        rule(dl, p(0,hauts,gris), lit(n)-appl(word(26),word(25)), [
                           rule(axiom, hauts, lit(n)-word(25), []),
                           rule(axiom, gris, dl(0,lit(n),lit(n))-word(26), [])
                           ])
                        ])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(27), [])
   ])).

% 324. Certains enfants ont les cheveux orange . 

proof(324, rule(dl, p(0,p(0,p(0,'Certains',enfants),p(0,ont,p(0,les,p(0,cheveux,orange)))),'.'), lit(txt)-appl(word(6),appl(appl(word(2),appl(word(3),appl(word(5),word(4)))),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Certains',enfants),p(0,ont,p(0,les,p(0,cheveux,orange)))), lit(s(main))-appl(appl(word(2),appl(word(3),appl(word(5),word(4)))),appl(word(0),word(1))), [
      rule(dr, p(0,'Certains',enfants), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Certains', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, enfants, lit(n)-word(1), [])
         ]),
      rule(dr, p(0,ont,p(0,les,p(0,cheveux,orange))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),appl(word(3),appl(word(5),word(4)))), [
         rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(2), []),
         rule(dr, p(0,les,p(0,cheveux,orange)), lit(np(acc,_,_))-appl(word(3),appl(word(5),word(4))), [
            rule(axiom, les, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
            rule(dl, p(0,cheveux,orange), lit(n)-appl(word(5),word(4)), [
               rule(axiom, cheveux, lit(n)-word(4), []),
               rule(axiom, orange, dl(0,lit(n),lit(n))-word(5), [])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(6), [])
   ])).

% 326. Plus de 4 chanteurs sont originaires du Brésil . 

proof(326, rule(dl, p(0,p(0,p(0,'Plus',p(0,de,p(0,4,chanteurs))),p(0,sont,p(0,originaires,p(0,du,'Brésil')))),'.'), lit(txt)-appl(word(8),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'Plus',p(0,de,p(0,4,chanteurs))),p(0,sont,p(0,originaires,p(0,du,'Brésil')))), lit(s(main))-appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'Plus',p(0,de,p(0,4,chanteurs))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
         rule(dr, p(0,de,p(0,4,chanteurs)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
            rule(dr, p(0,4,chanteurs), lit(np(acc,_,_))-appl(word(2),word(3)), [
               rule(axiom, 4, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
               rule(axiom, chanteurs, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(dr, p(0,sont,p(0,originaires,p(0,du,'Brésil'))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
         rule(axiom, sont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(ppart))))-word(4), []),
         rule(dr, p(0,originaires,p(0,du,'Brésil')), dl(0,lit(np(nom,_,_)),lit(s(ppart)))-appl(word(5),appl(word(6),word(7))), [
            rule(axiom, originaires, dr(0,dl(0,lit(np(nom,_,_)),lit(s(ppart))),lit(pp(de)))-word(5), []),
            rule(dr, p(0,du,'Brésil'), lit(pp(de))-appl(word(6),word(7)), [
               rule(axiom, du, dr(0,lit(pp(de)),lit(n))-word(6), []),
               rule(axiom, 'Brésil', lit(n)-word(7), [])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(8), [])
   ])).

% 328. Les deux tiers des chanteurs viennent du Brésil . 

proof(328, rule(dl, p(0,p(0,p(0,'Les',p(0,p(0,deux,tiers),p(0,des,chanteurs))),p(0,viennent,p(0,du,'Brésil'))),'.'), lit(txt)-appl(word(8),appl(appl(word(5),appl(word(6),word(7))),appl(word(0),appl(appl(word(3),word(4)),appl(word(1),word(2)))))), [
   rule(dl, p(0,p(0,'Les',p(0,p(0,deux,tiers),p(0,des,chanteurs))),p(0,viennent,p(0,du,'Brésil'))), lit(s(main))-appl(appl(word(5),appl(word(6),word(7))),appl(word(0),appl(appl(word(3),word(4)),appl(word(1),word(2))))), [
      rule(dr, p(0,'Les',p(0,p(0,deux,tiers),p(0,des,chanteurs))), lit(np(nom,_,_))-appl(word(0),appl(appl(word(3),word(4)),appl(word(1),word(2)))), [
         rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dl, p(0,p(0,deux,tiers),p(0,des,chanteurs)), lit(n)-appl(appl(word(3),word(4)),appl(word(1),word(2))), [
            rule(dr, p(0,deux,tiers), lit(n)-appl(word(1),word(2)), [
               rule(axiom, deux, dr(0,lit(n),lit(n))-word(1), []),
               rule(axiom, tiers, lit(n)-word(2), [])
               ]),
            rule(dr, p(0,des,chanteurs), dl(0,lit(n),lit(n))-appl(word(3),word(4)), [
               rule(axiom, des, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(3), []),
               rule(axiom, chanteurs, lit(n)-word(4), [])
               ])
            ])
         ]),
      rule(dr, p(0,viennent,p(0,du,'Brésil')), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(5),appl(word(6),word(7))), [
         rule(axiom, viennent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(pp(de)))-word(5), []),
         rule(dr, p(0,du,'Brésil'), lit(pp(de))-appl(word(6),word(7)), [
            rule(axiom, du, dr(0,lit(pp(de)),lit(n))-word(6), []),
            rule(axiom, 'Brésil', lit(n)-word(7), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(8), [])
   ])).

% 330. Deux chanteurs viennent du Brésil . 

proof(330, rule(dl, p(0,p(0,p(0,'Deux',chanteurs),p(0,viennent,p(0,du,'Brésil'))),'.'), lit(txt)-appl(word(5),appl(appl(word(2),appl(word(3),word(4))),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Deux',chanteurs),p(0,viennent,p(0,du,'Brésil'))), lit(s(main))-appl(appl(word(2),appl(word(3),word(4))),appl(word(0),word(1))), [
      rule(dr, p(0,'Deux',chanteurs), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Deux', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, chanteurs, lit(n)-word(1), [])
         ]),
      rule(dr, p(0,viennent,p(0,du,'Brésil')), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),appl(word(3),word(4))), [
         rule(axiom, viennent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(pp(de)))-word(2), []),
         rule(dr, p(0,du,'Brésil'), lit(pp(de))-appl(word(3),word(4)), [
            rule(axiom, du, dr(0,lit(pp(de)),lit(n))-word(3), []),
            rule(axiom, 'Brésil', lit(n)-word(4), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(5), [])
   ])).

% 332. La plupart des chanteurs viennent du Brésil . 

proof(332, rule(dl, p(0,p(0,p(0,'La',p(0,plupart,p(0,des,chanteurs))),p(0,viennent,p(0,du,'Brésil'))),'.'), lit(txt)-appl(word(7),appl(appl(word(4),appl(word(5),word(6))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'La',p(0,plupart,p(0,des,chanteurs))),p(0,viennent,p(0,du,'Brésil'))), lit(s(main))-appl(appl(word(4),appl(word(5),word(6))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'La',p(0,plupart,p(0,des,chanteurs))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'La', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dr, p(0,plupart,p(0,des,chanteurs)), lit(n)-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, plupart, dr(0,lit(n),lit(pp(de)))-word(1), []),
            rule(dr, p(0,des,chanteurs), lit(pp(de))-appl(word(2),word(3)), [
               rule(axiom, des, dr(0,lit(pp(de)),lit(n))-word(2), []),
               rule(axiom, chanteurs, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(dr, p(0,viennent,p(0,du,'Brésil')), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),word(6))), [
         rule(axiom, viennent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(pp(de)))-word(4), []),
         rule(dr, p(0,du,'Brésil'), lit(pp(de))-appl(word(5),word(6)), [
            rule(axiom, du, dr(0,lit(pp(de)),lit(n))-word(5), []),
            rule(axiom, 'Brésil', lit(n)-word(6), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(7), [])
   ])).

% 334. Plusieurs chanteurs ne viennent pas du Chili . 

proof(334, rule(dl, p(0,p(0,p(0,'Plusieurs',chanteurs),p(0,ne,p(0,p(1,viennent,pas),p(0,du,'Chili')))),'.'), lit(txt)-appl(word(7),appl(appl(word(2),lambda('$VAR'(0),appl(word(4),appl(appl(word(3),appl(word(5),word(6))),'$VAR'(0))))),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Plusieurs',chanteurs),p(0,ne,p(0,p(1,viennent,pas),p(0,du,'Chili')))), lit(s(main))-appl(appl(word(2),lambda('$VAR'(0),appl(word(4),appl(appl(word(3),appl(word(5),word(6))),'$VAR'(0))))),appl(word(0),word(1))), [
      rule(dr, p(0,'Plusieurs',chanteurs), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Plusieurs', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, chanteurs, lit(n)-word(1), [])
         ]),
      rule(dr, p(0,ne,p(0,p(1,viennent,pas),p(0,du,'Chili'))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),lambda('$VAR'(0),appl(word(4),appl(appl(word(3),appl(word(5),word(6))),'$VAR'(0))))), [
         rule(axiom, ne, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(2), []),
         rule(dli(0), p(0,p(1,viennent,pas),p(0,du,'Chili')), dl(0,lit(np(nom,_,_)),lit(s(main)))-lambda('$VAR'(3),appl(word(4),appl(appl(word(3),appl(word(5),word(6))),'$VAR'(3)))), [
            rule(dl1, p(0,'$VAR'(0),p(0,p(1,viennent,pas),p(0,du,'Chili'))), lit(s(main))-appl(word(4),appl(appl(word(3),appl(word(5),word(6))),'$VAR'(3))), [
               rule(dl, p(0,'$VAR'(0),p(0,viennent,p(0,du,'Chili'))), lit(s(main))-appl(appl(word(3),appl(word(5),word(6))),'$VAR'(3)), [
                  rule(hyp(0), '$VAR'(0), lit(np(nom,_,_))-'$VAR'(3), []),
                  rule(dr, p(0,viennent,p(0,du,'Chili')), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(3),appl(word(5),word(6))), [
                     rule(axiom, viennent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(pp(de)))-word(3), []),
                     rule(dr, p(0,du,'Chili'), lit(pp(de))-appl(word(5),word(6)), [
                        rule(axiom, du, dr(0,lit(pp(de)),lit(n))-word(5), []),
                        rule(axiom, 'Chili', lit(n)-word(6), [])
                        ])
                     ])
                  ]),
               rule(axiom, pas, dl(1,lit(s(main)),lit(s(main)))-word(4), [])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(7), [])
   ])).

% 360. 36 % de la population d' Amérique latine vit dans la richesse . 

proof(360, rule(dl, p(0,p(0,p(0,36,p(0,p(0,'%',p(0,de,p(0,la,population))),p(0,'d\'',p(0,'Amérique',latine)))),p(0,vit,p(0,dans,p(0,la,richesse)))),'.'), lit(txt)-appl(word(12),appl(appl(word(8),appl(word(9),appl(word(10),word(11)))),appl(word(0),appl(appl(word(5),appl(word(7),word(6))),appl(appl(word(2),appl(word(3),word(4))),word(1)))))), [
   rule(dl, p(0,p(0,36,p(0,p(0,'%',p(0,de,p(0,la,population))),p(0,'d\'',p(0,'Amérique',latine)))),p(0,vit,p(0,dans,p(0,la,richesse)))), lit(s(main))-appl(appl(word(8),appl(word(9),appl(word(10),word(11)))),appl(word(0),appl(appl(word(5),appl(word(7),word(6))),appl(appl(word(2),appl(word(3),word(4))),word(1))))), [
      rule(dr, p(0,36,p(0,p(0,'%',p(0,de,p(0,la,population))),p(0,'d\'',p(0,'Amérique',latine)))), lit(np(nom,_,_))-appl(word(0),appl(appl(word(5),appl(word(7),word(6))),appl(appl(word(2),appl(word(3),word(4))),word(1)))), [
         rule(axiom, 36, dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dl, p(0,p(0,'%',p(0,de,p(0,la,population))),p(0,'d\'',p(0,'Amérique',latine))), lit(n)-appl(appl(word(5),appl(word(7),word(6))),appl(appl(word(2),appl(word(3),word(4))),word(1))), [
            rule(dl, p(0,'%',p(0,de,p(0,la,population))), lit(n)-appl(appl(word(2),appl(word(3),word(4))),word(1)), [
               rule(axiom, '%', lit(n)-word(1), []),
               rule(dr, p(0,de,p(0,la,population)), dl(0,lit(n),lit(n))-appl(word(2),appl(word(3),word(4))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(2), []),
                  rule(dr, p(0,la,population), lit(np(_,_,_))-appl(word(3),word(4)), [
                     rule(axiom, la, dr(0,lit(np(_,_,_)),lit(n))-word(3), []),
                     rule(axiom, population, lit(n)-word(4), [])
                     ])
                  ])
               ]),
            rule(dr, p(0,'d\'',p(0,'Amérique',latine)), dl(0,lit(n),lit(n))-appl(word(5),appl(word(7),word(6))), [
               rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(n))-word(5), []),
               rule(dl, p(0,'Amérique',latine), lit(n)-appl(word(7),word(6)), [
                  rule(axiom, 'Amérique', lit(n)-word(6), []),
                  rule(axiom, latine, dl(0,lit(n),lit(n))-word(7), [])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,vit,p(0,dans,p(0,la,richesse))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(8),appl(word(9),appl(word(10),word(11)))), [
         rule(axiom, vit, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(pp(dans)))-word(8), []),
         rule(dr, p(0,dans,p(0,la,richesse)), lit(pp(dans))-appl(word(9),appl(word(10),word(11))), [
            rule(axiom, dans, dr(0,lit(pp(dans)),lit(np(acc,_,_)))-word(9), []),
            rule(dr, p(0,la,richesse), lit(np(acc,_,_))-appl(word(10),word(11)), [
               rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(10), []),
               rule(axiom, richesse, lit(n)-word(11), [])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(12), [])
   ])).

% 374. Certains hommes ne portent pas de bleu . 

proof(374, rule(dl, p(0,p(0,p(0,'Certains',hommes),p(0,ne,p(0,portent,p(0,pas,p(0,de,bleu))))),'.'), lit(txt)-appl(word(7),appl(appl(word(2),appl(word(3),appl(word(4),appl(word(5),word(6))))),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Certains',hommes),p(0,ne,p(0,portent,p(0,pas,p(0,de,bleu))))), lit(s(main))-appl(appl(word(2),appl(word(3),appl(word(4),appl(word(5),word(6))))),appl(word(0),word(1))), [
      rule(dr, p(0,'Certains',hommes), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Certains', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, hommes, lit(n)-word(1), [])
         ]),
      rule(dr, p(0,ne,p(0,portent,p(0,pas,p(0,de,bleu)))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),appl(word(3),appl(word(4),appl(word(5),word(6))))), [
         rule(axiom, ne, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(2), []),
         rule(dr, p(0,portent,p(0,pas,p(0,de,bleu))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(3),appl(word(4),appl(word(5),word(6)))), [
            rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(3), []),
            rule(dr, p(0,pas,p(0,de,bleu)), lit(np(acc,_,_))-appl(word(4),appl(word(5),word(6))), [
               rule(axiom, pas, dr(0,lit(np(acc,_,_)),lit(pp(de)))-word(4), []),
               rule(dr, p(0,de,bleu), lit(pp(de))-appl(word(5),word(6)), [
                  rule(axiom, de, dr(0,lit(pp(de)),lit(n))-word(5), []),
                  rule(axiom, bleu, lit(n)-word(6), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(7), [])
   ])).

% 380. La plupart des hommes portent du bleu . 

proof(380, rule(dl, p(0,p(0,p(0,'La',p(0,plupart,p(0,des,hommes))),p(0,portent,p(0,du,bleu))),'.'), lit(txt)-appl(word(7),appl(appl(word(4),appl(word(5),word(6))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'La',p(0,plupart,p(0,des,hommes))),p(0,portent,p(0,du,bleu))), lit(s(main))-appl(appl(word(4),appl(word(5),word(6))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'La',p(0,plupart,p(0,des,hommes))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'La', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dr, p(0,plupart,p(0,des,hommes)), lit(n)-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, plupart, dr(0,lit(n),lit(pp(de)))-word(1), []),
            rule(dr, p(0,des,hommes), lit(pp(de))-appl(word(2),word(3)), [
               rule(axiom, des, dr(0,lit(pp(de)),lit(n))-word(2), []),
               rule(axiom, hommes, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(dr, p(0,portent,p(0,du,bleu)), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),word(6))), [
         rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(4), []),
         rule(dr, p(0,du,bleu), lit(np(acc,_,_))-appl(word(5),word(6)), [
            rule(axiom, du, dr(0,lit(np(acc,_,_)),lit(n))-word(5), []),
            rule(axiom, bleu, lit(n)-word(6), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(7), [])
   ])).

% 382. Au moins deux hommes portent de l' orange . 

proof(382, rule(dl, p(0,p(0,p(0,p(0,'Au',moins),p(0,deux,hommes)),p(0,portent,p(0,de,p(0,'l\'',orange)))),'.'), lit(txt)-appl(word(8),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(appl(word(0),word(1)),appl(word(2),word(3))))), [
   rule(dl, p(0,p(0,p(0,'Au',moins),p(0,deux,hommes)),p(0,portent,p(0,de,p(0,'l\'',orange)))), lit(s(main))-appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(appl(word(0),word(1)),appl(word(2),word(3)))), [
      rule(dr, p(0,p(0,'Au',moins),p(0,deux,hommes)), lit(np(nom,_,_))-appl(appl(word(0),word(1)),appl(word(2),word(3))), [
         rule(dr, p(0,'Au',moins), dr(0,lit(np(nom,_,_)),lit(np(_,_,_)))-appl(word(0),word(1)), [
            rule(axiom, 'Au', dr(0,dr(0,lit(np(nom,_,_)),lit(np(_,_,_))),lit(n))-word(0), []),
            rule(axiom, moins, lit(n)-word(1), [])
            ]),
         rule(dr, p(0,deux,hommes), lit(np(_,_,_))-appl(word(2),word(3)), [
            rule(axiom, deux, dr(0,lit(np(_,_,_)),lit(n))-word(2), []),
            rule(axiom, hommes, lit(n)-word(3), [])
            ])
         ]),
      rule(dr, p(0,portent,p(0,de,p(0,'l\'',orange))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
         rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(4), []),
         rule(dr, p(0,de,p(0,'l\'',orange)), lit(np(acc,_,_))-appl(word(5),appl(word(6),word(7))), [
            rule(axiom, de, dr(0,lit(np(acc,_,_)),lit(np(_,_,_)))-word(5), []),
            rule(dr, p(0,'l\'',orange), lit(np(_,_,_))-appl(word(6),word(7)), [
               rule(axiom, 'l\'', dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
               rule(axiom, orange, lit(n)-word(7), [])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(8), [])
   ])).

% 402. Certains ours s' assoient . 

proof(402, rule(dl, p(0,p(0,p(0,'Certains',ours),p(0,'s\'',assoient)),'.'), lit(txt)-appl(word(4),appl(appl(word(3),word(2)),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Certains',ours),p(0,'s\'',assoient)), lit(s(main))-appl(appl(word(3),word(2)),appl(word(0),word(1))), [
      rule(dr, p(0,'Certains',ours), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Certains', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, ours, lit(n)-word(1), [])
         ]),
      rule(dl, p(0,'s\'',assoient), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(3),word(2)), [
         rule(axiom, 's\'', lit(cl_r)-word(2), []),
         rule(axiom, assoient, dl(0,lit(cl_r),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(3), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(4), [])
   ])).

% 404. Certains ours ne courent pas . 

proof(404, rule(dl, p(0,p(1,p(0,p(0,'Certains',ours),p(0,ne,courent)),pas),'.'), lit(txt)-appl(word(5),appl(word(4),appl(appl(word(2),word(3)),appl(word(0),word(1))))), [
   rule(dl, p(1,p(0,p(0,'Certains',ours),p(0,ne,courent)),pas), lit(s(main))-appl(word(4),appl(appl(word(2),word(3)),appl(word(0),word(1)))), [
      rule(dl, p(0,p(0,'Certains',ours),p(0,ne,courent)), lit(s(main))-appl(appl(word(2),word(3)),appl(word(0),word(1))), [
         rule(dr, p(0,'Certains',ours), lit(np(nom,_,_))-appl(word(0),word(1)), [
            rule(axiom, 'Certains', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
            rule(axiom, ours, lit(n)-word(1), [])
            ]),
         rule(dr, p(0,ne,courent), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),word(3)), [
            rule(axiom, ne, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(2), []),
            rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(3), [])
            ])
         ]),
      rule(axiom, pas, dl(1,lit(s(main)),lit(s(main)))-word(4), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(5), [])
   ])).

% 406. Tout ours court . 

proof(406, rule(dl, p(0,p(0,p(0,'Tout',ours),court),'.'), lit(txt)-appl(word(3),appl(word(2),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Tout',ours),court), lit(s(main))-appl(word(2),appl(word(0),word(1))), [
      rule(dr, p(0,'Tout',ours), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Tout', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, ours, lit(n)-word(1), [])
         ]),
      rule(axiom, court, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(2), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(3), [])
   ])).

% 408. Plus d' un ours est assis . 

proof(408, rule(dl, p(0,p(0,p(0,'Plus',p(0,'d\'',p(0,un,ours))),p(0,est,assis)),'.'), lit(txt)-appl(word(6),appl(appl(word(4),word(5)),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'Plus',p(0,'d\'',p(0,un,ours))),p(0,est,assis)), lit(s(main))-appl(appl(word(4),word(5)),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'Plus',p(0,'d\'',p(0,un,ours))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
         rule(dr, p(0,'d\'',p(0,un,ours)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, 'd\'', dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
            rule(dr, p(0,un,ours), lit(np(acc,_,_))-appl(word(2),word(3)), [
               rule(axiom, un, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
               rule(axiom, ours, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(dr, p(0,est,assis), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),word(5)), [
         rule(axiom, est, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(pass))))-word(4), []),
         rule(axiom, assis, dl(0,lit(np(nom,_,_)),lit(s(pass)))-word(5), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(6), [])
   ])).

% 410. Tous les ours courent . 

proof(410, rule(dl, p(0,p(0,p(0,'Tous',p(0,les,ours)),courent),'.'), lit(txt)-appl(word(4),appl(word(3),appl(word(0),appl(word(1),word(2))))), [
   rule(dl, p(0,p(0,'Tous',p(0,les,ours)),courent), lit(s(main))-appl(word(3),appl(word(0),appl(word(1),word(2)))), [
      rule(dr, p(0,'Tous',p(0,les,ours)), lit(np(nom,_,_))-appl(word(0),appl(word(1),word(2))), [
         rule(axiom, 'Tous', dr(0,lit(np(nom,_,_)),lit(np(_,_,_)))-word(0), []),
         rule(dr, p(0,les,ours), lit(np(_,_,_))-appl(word(1),word(2)), [
            rule(axiom, les, dr(0,lit(np(_,_,_)),lit(n))-word(1), []),
            rule(axiom, ours, lit(n)-word(2), [])
            ])
         ]),
      rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(3), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(4), [])
   ])).

% 412. Plus de deux ours courent . 

proof(412, rule(dl, p(0,p(0,p(0,'Plus',p(0,de,p(0,deux,ours))),courent),'.'), lit(txt)-appl(word(5),appl(word(4),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'Plus',p(0,de,p(0,deux,ours))),courent), lit(s(main))-appl(word(4),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'Plus',p(0,de,p(0,deux,ours))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
         rule(dr, p(0,de,p(0,deux,ours)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
            rule(dr, p(0,deux,ours), lit(np(acc,_,_))-appl(word(2),word(3)), [
               rule(axiom, deux, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
               rule(axiom, ours, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(4), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(5), [])
   ])).

% 414. Plus de quatre ours sont assis . 

proof(414, rule(dl, p(0,p(0,p(0,'Plus',p(0,de,p(0,quatre,ours))),p(0,sont,assis)),'.'), lit(txt)-appl(word(6),appl(appl(word(4),word(5)),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'Plus',p(0,de,p(0,quatre,ours))),p(0,sont,assis)), lit(s(main))-appl(appl(word(4),word(5)),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'Plus',p(0,de,p(0,quatre,ours))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
         rule(dr, p(0,de,p(0,quatre,ours)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
            rule(dr, p(0,quatre,ours), lit(np(acc,_,_))-appl(word(2),word(3)), [
               rule(axiom, quatre, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
               rule(axiom, ours, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(dr, p(0,sont,assis), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),word(5)), [
         rule(axiom, sont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(pass))))-word(4), []),
         rule(axiom, assis, dl(0,lit(np(nom,_,_)),lit(s(pass)))-word(5), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(6), [])
   ])).

% 416. Plus de 3 ours ne s' assoient pas . 

proof(416, rule(dl, p(0,p(1,p(0,p(0,'Plus',p(0,de,p(0,3,ours))),p(0,ne,p(0,'s\'',assoient))),pas),'.'), lit(txt)-appl(word(8),appl(word(7),appl(appl(word(4),appl(word(6),word(5))),appl(word(0),appl(word(1),appl(word(2),word(3))))))), [
   rule(dl, p(1,p(0,p(0,'Plus',p(0,de,p(0,3,ours))),p(0,ne,p(0,'s\'',assoient))),pas), lit(s(main))-appl(word(7),appl(appl(word(4),appl(word(6),word(5))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
      rule(dl, p(0,p(0,'Plus',p(0,de,p(0,3,ours))),p(0,ne,p(0,'s\'',assoient))), lit(s(main))-appl(appl(word(4),appl(word(6),word(5))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
         rule(dr, p(0,'Plus',p(0,de,p(0,3,ours))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
            rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
            rule(dr, p(0,de,p(0,3,ours)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
               rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
               rule(dr, p(0,3,ours), lit(np(acc,_,_))-appl(word(2),word(3)), [
                  rule(axiom, 3, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
                  rule(axiom, ours, lit(n)-word(3), [])
                  ])
               ])
            ]),
         rule(dr, p(0,ne,p(0,'s\'',assoient)), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(6),word(5))), [
            rule(axiom, ne, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(4), []),
            rule(dl, p(0,'s\'',assoient), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(6),word(5)), [
               rule(axiom, 's\'', lit(cl_r)-word(5), []),
               rule(axiom, assoient, dl(0,lit(cl_r),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(6), [])
               ])
            ])
         ]),
      rule(axiom, pas, dl(1,lit(s(main)),lit(s(main)))-word(7), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(8), [])
   ])).

% 418. Moins de six ours courent . 

proof(418, rule(dl, p(0,p(0,p(0,'Moins',p(0,de,p(0,six,ours))),courent),'.'), lit(txt)-appl(word(5),appl(word(4),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'Moins',p(0,de,p(0,six,ours))),courent), lit(s(main))-appl(word(4),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'Moins',p(0,de,p(0,six,ours))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'Moins', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
         rule(dr, p(0,de,p(0,six,ours)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
            rule(dr, p(0,six,ours), lit(np(acc,_,_))-appl(word(2),word(3)), [
               rule(axiom, six, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
               rule(axiom, ours, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(4), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(5), [])
   ])).

% 420. Un ours est assis . 

proof(420, rule(dl, p(0,p(0,p(0,'Un',ours),p(0,est,assis)),'.'), lit(txt)-appl(word(4),appl(appl(word(2),word(3)),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Un',ours),p(0,est,assis)), lit(s(main))-appl(appl(word(2),word(3)),appl(word(0),word(1))), [
      rule(dr, p(0,'Un',ours), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Un', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, ours, lit(n)-word(1), [])
         ]),
      rule(dr, p(0,est,assis), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),word(3)), [
         rule(axiom, est, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(pass))))-word(2), []),
         rule(axiom, assis, dl(0,lit(np(nom,_,_)),lit(s(pass)))-word(3), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(4), [])
   ])).

% 422. Trois ours courent . 

proof(422, rule(dl, p(0,p(0,p(0,'Trois',ours),courent),'.'), lit(txt)-appl(word(3),appl(word(2),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Trois',ours),courent), lit(s(main))-appl(word(2),appl(word(0),word(1))), [
      rule(dr, p(0,'Trois',ours), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Trois', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, ours, lit(n)-word(1), [])
         ]),
      rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(2), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(3), [])
   ])).

% 430. Un ours beige court . 

proof(430, rule(dl, p(0,p(0,'Un',p(0,p(0,ours,beige),court)),'.'), lit(txt)-appl(word(4),appl(word(0),appl(word(3),appl(word(2),word(1))))), [
   rule(dr, p(0,'Un',p(0,p(0,ours,beige),court)), lit(np(_,_,_))-appl(word(0),appl(word(3),appl(word(2),word(1)))), [
      rule(axiom, 'Un', dr(0,lit(np(_,_,_)),lit(n))-word(0), []),
      rule(dl, p(0,p(0,ours,beige),court), lit(n)-appl(word(3),appl(word(2),word(1))), [
         rule(dl, p(0,ours,beige), lit(n)-appl(word(2),word(1)), [
            rule(axiom, ours, lit(n)-word(1), []),
            rule(axiom, beige, dl(0,lit(n),lit(n))-word(2), [])
            ]),
         rule(axiom, court, dl(0,lit(n),lit(n))-word(3), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(np(_,_,_)),lit(txt))-word(4), [])
   ])).

% 432. 60 % des ours courent . 

proof(432, rule(dl, p(0,p(0,p(0,60,p(0,'%',p(0,des,ours))),courent),'.'), lit(txt)-appl(word(5),appl(word(4),appl(word(0),appl(appl(word(2),word(3)),word(1))))), [
   rule(dl, p(0,p(0,60,p(0,'%',p(0,des,ours))),courent), lit(s(main))-appl(word(4),appl(word(0),appl(appl(word(2),word(3)),word(1)))), [
      rule(dr, p(0,60,p(0,'%',p(0,des,ours))), lit(np(nom,_,_))-appl(word(0),appl(appl(word(2),word(3)),word(1))), [
         rule(axiom, 60, dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dl, p(0,'%',p(0,des,ours)), lit(n)-appl(appl(word(2),word(3)),word(1)), [
            rule(axiom, '%', lit(n)-word(1), []),
            rule(dr, p(0,des,ours), dl(0,lit(n),lit(n))-appl(word(2),word(3)), [
               rule(axiom, des, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(2), []),
               rule(axiom, ours, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(4), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(5), [])
   ])).

% 434. 40 % des ours sont assis . 

proof(434, rule(dl, p(0,p(0,p(0,40,p(0,'%',p(0,des,ours))),p(0,sont,assis)),'.'), lit(txt)-appl(word(6),appl(appl(word(4),word(5)),appl(word(0),appl(appl(word(2),word(3)),word(1))))), [
   rule(dl, p(0,p(0,40,p(0,'%',p(0,des,ours))),p(0,sont,assis)), lit(s(main))-appl(appl(word(4),word(5)),appl(word(0),appl(appl(word(2),word(3)),word(1)))), [
      rule(dr, p(0,40,p(0,'%',p(0,des,ours))), lit(np(nom,_,_))-appl(word(0),appl(appl(word(2),word(3)),word(1))), [
         rule(axiom, 40, dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dl, p(0,'%',p(0,des,ours)), lit(n)-appl(appl(word(2),word(3)),word(1)), [
            rule(axiom, '%', lit(n)-word(1), []),
            rule(dr, p(0,des,ours), dl(0,lit(n),lit(n))-appl(word(2),word(3)), [
               rule(axiom, des, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(2), []),
               rule(axiom, ours, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(dr, p(0,sont,assis), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),word(5)), [
         rule(axiom, sont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(pass))))-word(4), []),
         rule(axiom, assis, dl(0,lit(np(nom,_,_)),lit(s(pass)))-word(5), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(6), [])
   ])).

% 436. Plus de 40 % des ours courent . 

proof(436, rule(dl, p(0,p(0,p(0,'Plus',p(0,de,p(0,40,p(0,'%',p(0,des,ours))))),courent),'.'), lit(txt)-appl(word(7),appl(word(6),appl(word(0),appl(word(1),appl(word(2),appl(appl(word(4),word(5)),word(3))))))), [
   rule(dl, p(0,p(0,'Plus',p(0,de,p(0,40,p(0,'%',p(0,des,ours))))),courent), lit(s(main))-appl(word(6),appl(word(0),appl(word(1),appl(word(2),appl(appl(word(4),word(5)),word(3)))))), [
      rule(dr, p(0,'Plus',p(0,de,p(0,40,p(0,'%',p(0,des,ours))))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),appl(appl(word(4),word(5)),word(3))))), [
         rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
         rule(dr, p(0,de,p(0,40,p(0,'%',p(0,des,ours)))), lit(pp(de))-appl(word(1),appl(word(2),appl(appl(word(4),word(5)),word(3)))), [
            rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
            rule(dr, p(0,40,p(0,'%',p(0,des,ours))), lit(np(acc,_,_))-appl(word(2),appl(appl(word(4),word(5)),word(3))), [
               rule(axiom, 40, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
               rule(dl, p(0,'%',p(0,des,ours)), lit(n)-appl(appl(word(4),word(5)),word(3)), [
                  rule(axiom, '%', lit(n)-word(3), []),
                  rule(dr, p(0,des,ours), dl(0,lit(n),lit(n))-appl(word(4),word(5)), [
                     rule(axiom, des, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(4), []),
                     rule(axiom, ours, lit(n)-word(5), [])
                     ])
                  ])
               ])
            ])
         ]),
      rule(axiom, courent, dl(0,lit(np(nom,_,_)),lit(s(main)))-word(6), [])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(7), [])
   ])).

% 438. Un ours brun et un ours beige se poursuivent . 

proof(438, rule(dl, p(0,p(0,p(0,p(0,'Un',p(0,ours,brun)),p(0,et,p(0,un,p(0,ours,beige)))),p(0,se,poursuivent)),'.'), lit(txt)-appl(word(9),appl(appl(word(8),word(7)),appl(appl(word(3),appl(word(4),appl(word(6),word(5)))),appl(word(0),appl(word(2),word(1)))))), [
   rule(dl, p(0,p(0,p(0,'Un',p(0,ours,brun)),p(0,et,p(0,un,p(0,ours,beige)))),p(0,se,poursuivent)), lit(s(main))-appl(appl(word(8),word(7)),appl(appl(word(3),appl(word(4),appl(word(6),word(5)))),appl(word(0),appl(word(2),word(1))))), [
      rule(dl, p(0,p(0,'Un',p(0,ours,brun)),p(0,et,p(0,un,p(0,ours,beige)))), lit(np(nom,_,_))-appl(appl(word(3),appl(word(4),appl(word(6),word(5)))),appl(word(0),appl(word(2),word(1)))), [
         rule(dr, p(0,'Un',p(0,ours,brun)), lit(np(nom,_,_))-appl(word(0),appl(word(2),word(1))), [
            rule(axiom, 'Un', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
            rule(dl, p(0,ours,brun), lit(n)-appl(word(2),word(1)), [
               rule(axiom, ours, lit(n)-word(1), []),
               rule(axiom, brun, dl(0,lit(n),lit(n))-word(2), [])
               ])
            ]),
         rule(dr, p(0,et,p(0,un,p(0,ours,beige))), dl(0,lit(np(nom,_,_)),lit(np(nom,_,_)))-appl(word(3),appl(word(4),appl(word(6),word(5)))), [
            rule(axiom, et, dr(0,dl(0,lit(np(nom,_,_)),lit(np(nom,_,_))),lit(np(_,_,_)))-word(3), []),
            rule(dr, p(0,un,p(0,ours,beige)), lit(np(_,_,_))-appl(word(4),appl(word(6),word(5))), [
               rule(axiom, un, dr(0,lit(np(_,_,_)),lit(n))-word(4), []),
               rule(dl, p(0,ours,beige), lit(n)-appl(word(6),word(5)), [
                  rule(axiom, ours, lit(n)-word(5), []),
                  rule(axiom, beige, dl(0,lit(n),lit(n))-word(6), [])
                  ])
               ])
            ])
         ]),
      rule(dl, p(0,se,poursuivent), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(8),word(7)), [
         rule(axiom, se, lit(cl_r)-word(7), []),
         rule(axiom, poursuivent, dl(0,lit(cl_r),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(8), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(9), [])
   ])).

% 440. Deux ours beiges se poursuivent . 

proof(440, rule(dl, p(0,p(0,p(0,'Deux',p(0,ours,beiges)),p(0,se,poursuivent)),'.'), lit(txt)-appl(word(5),appl(appl(word(4),word(3)),appl(word(0),appl(word(2),word(1))))), [
   rule(dl, p(0,p(0,'Deux',p(0,ours,beiges)),p(0,se,poursuivent)), lit(s(main))-appl(appl(word(4),word(3)),appl(word(0),appl(word(2),word(1)))), [
      rule(dr, p(0,'Deux',p(0,ours,beiges)), lit(np(nom,_,_))-appl(word(0),appl(word(2),word(1))), [
         rule(axiom, 'Deux', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dl, p(0,ours,beiges), lit(n)-appl(word(2),word(1)), [
            rule(axiom, ours, lit(n)-word(1), []),
            rule(axiom, beiges, dl(0,lit(n),lit(n))-word(2), [])
            ])
         ]),
      rule(dl, p(0,se,poursuivent), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),word(3)), [
         rule(axiom, se, lit(cl_r)-word(3), []),
         rule(axiom, poursuivent, dl(0,lit(cl_r),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(4), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(5), [])
   ])).

% 502. Six enfants portant des hauts beiges sont debout au sommet d' une montagne . 

proof(502, rule(dl, p(0,p(1,p(0,p(0,'Six',p(0,enfants,p(0,portant,p(0,des,p(0,hauts,beiges))))),p(0,sont,debout)),p(0,au,p(0,sommet,p(0,'d\'',p(0,une,montagne))))),'.'), lit(txt)-appl(word(13),appl(appl(word(8),appl(appl(word(10),appl(word(11),word(12))),word(9))),appl(appl(word(6),word(7)),appl(word(0),appl(appl(word(2),appl(word(3),appl(word(4),word(5)))),word(1)))))), [
   rule(dl, p(1,p(0,p(0,'Six',p(0,enfants,p(0,portant,p(0,des,p(0,hauts,beiges))))),p(0,sont,debout)),p(0,au,p(0,sommet,p(0,'d\'',p(0,une,montagne))))), lit(s(main))-appl(appl(word(8),appl(appl(word(10),appl(word(11),word(12))),word(9))),appl(appl(word(6),word(7)),appl(word(0),appl(appl(word(2),appl(word(3),appl(word(4),word(5)))),word(1))))), [
      rule(dl, p(0,p(0,'Six',p(0,enfants,p(0,portant,p(0,des,p(0,hauts,beiges))))),p(0,sont,debout)), lit(s(main))-appl(appl(word(6),word(7)),appl(word(0),appl(appl(word(2),appl(word(3),appl(word(4),word(5)))),word(1)))), [
         rule(dr, p(0,'Six',p(0,enfants,p(0,portant,p(0,des,p(0,hauts,beiges))))), lit(np(nom,_,_))-appl(word(0),appl(appl(word(2),appl(word(3),appl(word(4),word(5)))),word(1))), [
            rule(axiom, 'Six', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
            rule(dl, p(0,enfants,p(0,portant,p(0,des,p(0,hauts,beiges)))), lit(n)-appl(appl(word(2),appl(word(3),appl(word(4),word(5)))),word(1)), [
               rule(axiom, enfants, lit(n)-word(1), []),
               rule(dr, p(0,portant,p(0,des,p(0,hauts,beiges))), dl(0,lit(n),lit(n))-appl(word(2),appl(word(3),appl(word(4),word(5)))), [
                  rule(axiom, portant, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(2), []),
                  rule(dr, p(0,des,p(0,hauts,beiges)), lit(np(_,_,_))-appl(word(3),appl(word(4),word(5))), [
                     rule(axiom, des, dr(0,lit(np(_,_,_)),lit(n))-word(3), []),
                     rule(dr, p(0,hauts,beiges), lit(n)-appl(word(4),word(5)), [
                        rule(axiom, hauts, dr(0,lit(n),lit(n))-word(4), []),
                        rule(axiom, beiges, lit(n)-word(5), [])
                        ])
                     ])
                  ])
               ])
            ]),
         rule(dr, p(0,sont,debout), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(6),word(7)), [
            rule(axiom, sont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(n),lit(n)))-word(6), []),
            rule(axiom, debout, dl(0,lit(n),lit(n))-word(7), [])
            ])
         ]),
      rule(dr, p(0,au,p(0,sommet,p(0,'d\'',p(0,une,montagne)))), dl(1,lit(s(main)),lit(s(main)))-appl(word(8),appl(appl(word(10),appl(word(11),word(12))),word(9))), [
         rule(axiom, au, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(8), []),
         rule(dl, p(0,sommet,p(0,'d\'',p(0,une,montagne))), lit(n)-appl(appl(word(10),appl(word(11),word(12))),word(9)), [
            rule(axiom, sommet, lit(n)-word(9), []),
            rule(dr, p(0,'d\'',p(0,une,montagne)), dl(0,lit(n),lit(n))-appl(word(10),appl(word(11),word(12))), [
               rule(axiom, 'd\'', dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(10), []),
               rule(dr, p(0,une,montagne), lit(np(_,_,_))-appl(word(11),word(12)), [
                  rule(axiom, une, dr(0,lit(np(_,_,_)),lit(n))-word(11), []),
                  rule(axiom, montagne, lit(n)-word(12), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(13), [])
   ])).

% 508. Quatre enfants portent des hauts beiges . 

proof(508, rule(dl, p(0,p(0,p(0,'Quatre',enfants),p(0,portent,p(0,des,p(0,hauts,beiges)))),'.'), lit(txt)-appl(word(6),appl(appl(word(2),appl(word(3),appl(word(4),word(5)))),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Quatre',enfants),p(0,portent,p(0,des,p(0,hauts,beiges)))), lit(s(main))-appl(appl(word(2),appl(word(3),appl(word(4),word(5)))),appl(word(0),word(1))), [
      rule(dr, p(0,'Quatre',enfants), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Quatre', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, enfants, lit(n)-word(1), [])
         ]),
      rule(dr, p(0,portent,p(0,des,p(0,hauts,beiges))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),appl(word(3),appl(word(4),word(5)))), [
         rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(2), []),
         rule(dr, p(0,des,p(0,hauts,beiges)), lit(np(acc,_,_))-appl(word(3),appl(word(4),word(5))), [
            rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
            rule(dr, p(0,hauts,beiges), lit(n)-appl(word(4),word(5)), [
               rule(axiom, hauts, dr(0,lit(n),lit(n))-word(4), []),
               rule(axiom, beiges, lit(n)-word(5), [])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(6), [])
   ])).

% 512. Tous les enfants portent des tops . 

proof(512, rule(dl, p(0,p(0,p(0,'Tous',p(0,les,enfants)),p(0,portent,p(0,des,tops))),'.'), lit(txt)-appl(word(6),appl(appl(word(3),appl(word(4),word(5))),appl(word(0),appl(word(1),word(2))))), [
   rule(dl, p(0,p(0,'Tous',p(0,les,enfants)),p(0,portent,p(0,des,tops))), lit(s(main))-appl(appl(word(3),appl(word(4),word(5))),appl(word(0),appl(word(1),word(2)))), [
      rule(dr, p(0,'Tous',p(0,les,enfants)), lit(np(nom,_,_))-appl(word(0),appl(word(1),word(2))), [
         rule(axiom, 'Tous', dr(0,lit(np(nom,_,_)),lit(np(_,_,_)))-word(0), []),
         rule(dr, p(0,les,enfants), lit(np(_,_,_))-appl(word(1),word(2)), [
            rule(axiom, les, dr(0,lit(np(_,_,_)),lit(n))-word(1), []),
            rule(axiom, enfants, lit(n)-word(2), [])
            ])
         ]),
      rule(dr, p(0,portent,p(0,des,tops)), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(3),appl(word(4),word(5))), [
         rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(3), []),
         rule(dr, p(0,des,tops), lit(np(acc,_,_))-appl(word(4),word(5)), [
            rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(4), []),
            rule(axiom, tops, lit(n)-word(5), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(6), [])
   ])).

% 516. Moins de cinq enfants portent des hauts beiges . 

proof(516, rule(dl, p(0,p(0,p(0,'Moins',p(0,de,p(0,cinq,enfants))),p(0,portent,p(0,des,p(0,hauts,beiges)))),'.'), lit(txt)-appl(word(8),appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'Moins',p(0,de,p(0,cinq,enfants))),p(0,portent,p(0,des,p(0,hauts,beiges)))), lit(s(main))-appl(appl(word(4),appl(word(5),appl(word(6),word(7)))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'Moins',p(0,de,p(0,cinq,enfants))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'Moins', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
         rule(dr, p(0,de,p(0,cinq,enfants)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
            rule(dr, p(0,cinq,enfants), lit(np(acc,_,_))-appl(word(2),word(3)), [
               rule(axiom, cinq, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
               rule(axiom, enfants, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(dr, p(0,portent,p(0,des,p(0,hauts,beiges))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),appl(word(6),word(7)))), [
         rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(4), []),
         rule(dr, p(0,des,p(0,hauts,beiges)), lit(np(acc,_,_))-appl(word(5),appl(word(6),word(7))), [
            rule(axiom, des, dr(0,lit(np(acc,_,_)),lit(n))-word(5), []),
            rule(dr, p(0,hauts,beiges), lit(n)-appl(word(6),word(7)), [
               rule(axiom, hauts, dr(0,lit(n),lit(n))-word(6), []),
               rule(axiom, beiges, lit(n)-word(7), [])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(8), [])
   ])).

% 524. Certains enfants ont les cheveux beiges . 

proof(524, rule(dl, p(0,p(0,p(0,'Certains',enfants),p(0,ont,p(0,les,p(0,cheveux,beiges)))),'.'), lit(txt)-appl(word(6),appl(appl(word(2),appl(word(3),appl(word(5),word(4)))),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Certains',enfants),p(0,ont,p(0,les,p(0,cheveux,beiges)))), lit(s(main))-appl(appl(word(2),appl(word(3),appl(word(5),word(4)))),appl(word(0),word(1))), [
      rule(dr, p(0,'Certains',enfants), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Certains', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, enfants, lit(n)-word(1), [])
         ]),
      rule(dr, p(0,ont,p(0,les,p(0,cheveux,beiges))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),appl(word(3),appl(word(5),word(4)))), [
         rule(axiom, ont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(2), []),
         rule(dr, p(0,les,p(0,cheveux,beiges)), lit(np(acc,_,_))-appl(word(3),appl(word(5),word(4))), [
            rule(axiom, les, dr(0,lit(np(acc,_,_)),lit(n))-word(3), []),
            rule(dl, p(0,cheveux,beiges), lit(n)-appl(word(5),word(4)), [
               rule(axiom, cheveux, lit(n)-word(4), []),
               rule(axiom, beiges, dl(0,lit(n),lit(n))-word(5), [])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(6), [])
   ])).

% 526. Plus de 4 chanteurs sont allemands . 

proof(526, rule(dl, p(0,p(0,p(0,'Plus',p(0,de,p(0,4,chanteurs))),p(0,sont,allemands)),'.'), lit(txt)-appl(word(6),appl(appl(word(4),word(5)),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'Plus',p(0,de,p(0,4,chanteurs))),p(0,sont,allemands)), lit(s(main))-appl(appl(word(4),word(5)),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'Plus',p(0,de,p(0,4,chanteurs))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'Plus', dr(0,lit(np(nom,_,_)),lit(pp(de)))-word(0), []),
         rule(dr, p(0,de,p(0,4,chanteurs)), lit(pp(de))-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, de, dr(0,lit(pp(de)),lit(np(acc,_,_)))-word(1), []),
            rule(dr, p(0,4,chanteurs), lit(np(acc,_,_))-appl(word(2),word(3)), [
               rule(axiom, 4, dr(0,lit(np(acc,_,_)),lit(n))-word(2), []),
               rule(axiom, chanteurs, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(dr, p(0,sont,allemands), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),word(5)), [
         rule(axiom, sont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(n),lit(n)))-word(4), []),
         rule(axiom, allemands, dl(0,lit(n),lit(n))-word(5), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(6), [])
   ])).

% 528. Les deux tiers des chanteurs sont allemands . 

proof(528, rule(dl, p(0,p(0,p(0,'Les',p(0,p(0,deux,tiers),p(0,des,chanteurs))),p(0,sont,allemands)),'.'), lit(txt)-appl(word(7),appl(appl(word(5),word(6)),appl(word(0),appl(appl(word(3),word(4)),appl(word(1),word(2)))))), [
   rule(dl, p(0,p(0,'Les',p(0,p(0,deux,tiers),p(0,des,chanteurs))),p(0,sont,allemands)), lit(s(main))-appl(appl(word(5),word(6)),appl(word(0),appl(appl(word(3),word(4)),appl(word(1),word(2))))), [
      rule(dr, p(0,'Les',p(0,p(0,deux,tiers),p(0,des,chanteurs))), lit(np(nom,_,_))-appl(word(0),appl(appl(word(3),word(4)),appl(word(1),word(2)))), [
         rule(axiom, 'Les', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dl, p(0,p(0,deux,tiers),p(0,des,chanteurs)), lit(n)-appl(appl(word(3),word(4)),appl(word(1),word(2))), [
            rule(dr, p(0,deux,tiers), lit(n)-appl(word(1),word(2)), [
               rule(axiom, deux, dr(0,lit(n),lit(n))-word(1), []),
               rule(axiom, tiers, lit(n)-word(2), [])
               ]),
            rule(dr, p(0,des,chanteurs), dl(0,lit(n),lit(n))-appl(word(3),word(4)), [
               rule(axiom, des, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(3), []),
               rule(axiom, chanteurs, lit(n)-word(4), [])
               ])
            ])
         ]),
      rule(dr, p(0,sont,allemands), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(5),word(6)), [
         rule(axiom, sont, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(n),lit(n)))-word(5), []),
         rule(axiom, allemands, dl(0,lit(n),lit(n))-word(6), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(7), [])
   ])).

% 530. Deux chanteurs viennent d' Allemagne . 

proof(530, rule(dl, p(0,p(0,p(0,'Deux',chanteurs),p(0,viennent,p(0,'d\'','Allemagne'))),'.'), lit(txt)-appl(word(5),appl(appl(word(2),appl(word(3),word(4))),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Deux',chanteurs),p(0,viennent,p(0,'d\'','Allemagne'))), lit(s(main))-appl(appl(word(2),appl(word(3),word(4))),appl(word(0),word(1))), [
      rule(dr, p(0,'Deux',chanteurs), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Deux', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, chanteurs, lit(n)-word(1), [])
         ]),
      rule(dr, p(0,viennent,p(0,'d\'','Allemagne')), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),appl(word(3),word(4))), [
         rule(axiom, viennent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(pp(de)))-word(2), []),
         rule(dr, p(0,'d\'','Allemagne'), lit(pp(de))-appl(word(3),word(4)), [
            rule(axiom, 'd\'', dr(0,lit(pp(de)),lit(n))-word(3), []),
            rule(axiom, 'Allemagne', lit(n)-word(4), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(5), [])
   ])).

% 532. La plupart des chanteurs viennent d' Allemagne . 

proof(532, rule(dl, p(0,p(0,p(0,'La',p(0,plupart,p(0,des,chanteurs))),p(0,viennent,p(0,'d\'','Allemagne'))),'.'), lit(txt)-appl(word(7),appl(appl(word(4),appl(word(5),word(6))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'La',p(0,plupart,p(0,des,chanteurs))),p(0,viennent,p(0,'d\'','Allemagne'))), lit(s(main))-appl(appl(word(4),appl(word(5),word(6))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'La',p(0,plupart,p(0,des,chanteurs))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'La', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dr, p(0,plupart,p(0,des,chanteurs)), lit(n)-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, plupart, dr(0,lit(n),lit(pp(de)))-word(1), []),
            rule(dr, p(0,des,chanteurs), lit(pp(de))-appl(word(2),word(3)), [
               rule(axiom, des, dr(0,lit(pp(de)),lit(n))-word(2), []),
               rule(axiom, chanteurs, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(dr, p(0,viennent,p(0,'d\'','Allemagne')), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),word(6))), [
         rule(axiom, viennent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(pp(de)))-word(4), []),
         rule(dr, p(0,'d\'','Allemagne'), lit(pp(de))-appl(word(5),word(6)), [
            rule(axiom, 'd\'', dr(0,lit(pp(de)),lit(n))-word(5), []),
            rule(axiom, 'Allemagne', lit(n)-word(6), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(7), [])
   ])).

% 534. Plusieurs chanteurs ne viennent pas du Chili . 

proof(534, rule(dl, p(0,p(0,p(0,'Plusieurs',chanteurs),p(0,ne,p(0,p(1,viennent,pas),p(0,du,'Chili')))),'.'), lit(txt)-appl(word(7),appl(appl(word(2),lambda('$VAR'(0),appl(word(4),appl(appl(word(3),appl(word(5),word(6))),'$VAR'(0))))),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Plusieurs',chanteurs),p(0,ne,p(0,p(1,viennent,pas),p(0,du,'Chili')))), lit(s(main))-appl(appl(word(2),lambda('$VAR'(0),appl(word(4),appl(appl(word(3),appl(word(5),word(6))),'$VAR'(0))))),appl(word(0),word(1))), [
      rule(dr, p(0,'Plusieurs',chanteurs), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Plusieurs', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, chanteurs, lit(n)-word(1), [])
         ]),
      rule(dr, p(0,ne,p(0,p(1,viennent,pas),p(0,du,'Chili'))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),lambda('$VAR'(0),appl(word(4),appl(appl(word(3),appl(word(5),word(6))),'$VAR'(0))))), [
         rule(axiom, ne, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(2), []),
         rule(dli(0), p(0,p(1,viennent,pas),p(0,du,'Chili')), dl(0,lit(np(nom,_,_)),lit(s(main)))-lambda('$VAR'(3),appl(word(4),appl(appl(word(3),appl(word(5),word(6))),'$VAR'(3)))), [
            rule(dl1, p(0,'$VAR'(0),p(0,p(1,viennent,pas),p(0,du,'Chili'))), lit(s(main))-appl(word(4),appl(appl(word(3),appl(word(5),word(6))),'$VAR'(3))), [
               rule(dl, p(0,'$VAR'(0),p(0,viennent,p(0,du,'Chili'))), lit(s(main))-appl(appl(word(3),appl(word(5),word(6))),'$VAR'(3)), [
                  rule(hyp(0), '$VAR'(0), lit(np(nom,_,_))-'$VAR'(3), []),
                  rule(dr, p(0,viennent,p(0,du,'Chili')), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(3),appl(word(5),word(6))), [
                     rule(axiom, viennent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(pp(de)))-word(3), []),
                     rule(dr, p(0,du,'Chili'), lit(pp(de))-appl(word(5),word(6)), [
                        rule(axiom, du, dr(0,lit(pp(de)),lit(n))-word(5), []),
                        rule(axiom, 'Chili', lit(n)-word(6), [])
                        ])
                     ])
                  ]),
               rule(axiom, pas, dl(1,lit(s(main)),lit(s(main)))-word(4), [])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(7), [])
   ])).

% 560. 36 % de la population australienne vit dans la richesse . 

proof(560, rule(dl, p(0,p(0,p(0,36,p(0,p(0,'%',p(0,de,p(0,la,population))),australienne)),p(0,vit,p(0,dans,p(0,la,richesse)))),'.'), lit(txt)-appl(word(10),appl(appl(word(6),appl(word(7),appl(word(8),word(9)))),appl(word(0),appl(word(5),appl(appl(word(2),appl(word(3),word(4))),word(1)))))), [
   rule(dl, p(0,p(0,36,p(0,p(0,'%',p(0,de,p(0,la,population))),australienne)),p(0,vit,p(0,dans,p(0,la,richesse)))), lit(s(main))-appl(appl(word(6),appl(word(7),appl(word(8),word(9)))),appl(word(0),appl(word(5),appl(appl(word(2),appl(word(3),word(4))),word(1))))), [
      rule(dr, p(0,36,p(0,p(0,'%',p(0,de,p(0,la,population))),australienne)), lit(np(nom,_,_))-appl(word(0),appl(word(5),appl(appl(word(2),appl(word(3),word(4))),word(1)))), [
         rule(axiom, 36, dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dl, p(0,p(0,'%',p(0,de,p(0,la,population))),australienne), lit(n)-appl(word(5),appl(appl(word(2),appl(word(3),word(4))),word(1))), [
            rule(dl, p(0,'%',p(0,de,p(0,la,population))), lit(n)-appl(appl(word(2),appl(word(3),word(4))),word(1)), [
               rule(axiom, '%', lit(n)-word(1), []),
               rule(dr, p(0,de,p(0,la,population)), dl(0,lit(n),lit(n))-appl(word(2),appl(word(3),word(4))), [
                  rule(axiom, de, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(2), []),
                  rule(dr, p(0,la,population), lit(np(_,_,_))-appl(word(3),word(4)), [
                     rule(axiom, la, dr(0,lit(np(_,_,_)),lit(n))-word(3), []),
                     rule(axiom, population, lit(n)-word(4), [])
                     ])
                  ])
               ]),
            rule(axiom, australienne, dl(0,lit(n),lit(n))-word(5), [])
            ])
         ]),
      rule(dr, p(0,vit,p(0,dans,p(0,la,richesse))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(6),appl(word(7),appl(word(8),word(9)))), [
         rule(axiom, vit, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(pp(dans)))-word(6), []),
         rule(dr, p(0,dans,p(0,la,richesse)), lit(pp(dans))-appl(word(7),appl(word(8),word(9))), [
            rule(axiom, dans, dr(0,lit(pp(dans)),lit(np(acc,_,_)))-word(7), []),
            rule(dr, p(0,la,richesse), lit(np(acc,_,_))-appl(word(8),word(9)), [
               rule(axiom, la, dr(0,lit(np(acc,_,_)),lit(n))-word(8), []),
               rule(axiom, richesse, lit(n)-word(9), [])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(10), [])
   ])).

% 562. Il y avait plus de femmes que d' hommes en Ouzbékistan . 

proof(562, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,avait,p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes)))))),p(0,en,'Ouzbékistan')),'.'), lit(txt)-appl(word(11),appl(appl(word(9),word(10)),appl(appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,avait,p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes)))))),p(0,en,'Ouzbékistan')), lit(s(main))-appl(appl(word(9),word(10)),appl(appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,avait,p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes)))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,avait,p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,avait,p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes)))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))), [
               rule(axiom, avait, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes))), lit(np(acc,_,_))-appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8)))), [
                  rule(dr, p(0,plus,p(0,de,femmes)), dr(0,lit(np(acc,_,_)),lit(s(q)))-appl(word(3),appl(word(4),word(5))), [
                     rule(axiom, plus, dr(0,dr(0,lit(np(acc,_,_)),lit(s(q))),lit(pp(de)))-word(3), []),
                     rule(dr, p(0,de,femmes), lit(pp(de))-appl(word(4),word(5)), [
                        rule(axiom, de, dr(0,lit(pp(de)),lit(n))-word(4), []),
                        rule(axiom, femmes, lit(n)-word(5), [])
                        ])
                     ]),
                  rule(dr, p(0,que,p(0,'d\'',hommes)), lit(s(q))-appl(word(6),appl(word(7),word(8))), [
                     rule(axiom, que, dr(0,lit(s(q)),lit(pp(de)))-word(6), []),
                     rule(dr, p(0,'d\'',hommes), lit(pp(de))-appl(word(7),word(8)), [
                        rule(axiom, 'd\'', dr(0,lit(pp(de)),lit(n))-word(7), []),
                        rule(axiom, hommes, lit(n)-word(8), [])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,en,'Ouzbékistan'), dl(1,lit(s(main)),lit(s(main)))-appl(word(9),word(10)), [
         rule(axiom, en, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(9), []),
         rule(axiom, 'Ouzbékistan', lit(n)-word(10), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(11), [])
   ])).

% 564. Le ratio hommes / femmes pour 100 femmes se situait entre 86 et . 87. 

proof(564, rule(dl, p(0,p(0,p(0,'Le',p(0,p(0,p(0,ratio,hommes),p(0,/,femmes)),p(0,pour,p(0,100,femmes)))),p(0,se,p(0,situait,p(0,entre,p(0,86,p(0,et,'.')))))),'87.'), lit(txt)-appl(word(14),appl(appl(appl(word(9),appl(word(10),appl(appl(word(12),word(13)),word(11)))),word(8)),appl(word(0),appl(appl(word(5),appl(word(6),word(7))),appl(appl(word(3),word(4)),appl(word(2),word(1))))))), [
   rule(dl, p(0,p(0,'Le',p(0,p(0,p(0,ratio,hommes),p(0,/,femmes)),p(0,pour,p(0,100,femmes)))),p(0,se,p(0,situait,p(0,entre,p(0,86,p(0,et,'.')))))), lit(s(main))-appl(appl(appl(word(9),appl(word(10),appl(appl(word(12),word(13)),word(11)))),word(8)),appl(word(0),appl(appl(word(5),appl(word(6),word(7))),appl(appl(word(3),word(4)),appl(word(2),word(1)))))), [
      rule(dr, p(0,'Le',p(0,p(0,p(0,ratio,hommes),p(0,/,femmes)),p(0,pour,p(0,100,femmes)))), lit(np(nom,_,_))-appl(word(0),appl(appl(word(5),appl(word(6),word(7))),appl(appl(word(3),word(4)),appl(word(2),word(1))))), [
         rule(axiom, 'Le', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dl, p(0,p(0,p(0,ratio,hommes),p(0,/,femmes)),p(0,pour,p(0,100,femmes))), lit(n)-appl(appl(word(5),appl(word(6),word(7))),appl(appl(word(3),word(4)),appl(word(2),word(1)))), [
            rule(dl, p(0,p(0,ratio,hommes),p(0,/,femmes)), lit(n)-appl(appl(word(3),word(4)),appl(word(2),word(1))), [
               rule(dl, p(0,ratio,hommes), lit(n)-appl(word(2),word(1)), [
                  rule(axiom, ratio, lit(n)-word(1), []),
                  rule(axiom, hommes, dl(0,lit(n),lit(n))-word(2), [])
                  ]),
               rule(dr, p(0,/,femmes), dl(0,lit(n),lit(n))-appl(word(3),word(4)), [
                  rule(axiom, /, dr(0,dl(0,lit(n),lit(n)),lit(n))-word(3), []),
                  rule(axiom, femmes, lit(n)-word(4), [])
                  ])
               ]),
            rule(dr, p(0,pour,p(0,100,femmes)), dl(0,lit(n),lit(n))-appl(word(5),appl(word(6),word(7))), [
               rule(axiom, pour, dr(0,dl(0,lit(n),lit(n)),lit(np(_,_,_)))-word(5), []),
               rule(dr, p(0,100,femmes), lit(np(_,_,_))-appl(word(6),word(7)), [
                  rule(axiom, 100, dr(0,lit(np(_,_,_)),lit(n))-word(6), []),
                  rule(axiom, femmes, lit(n)-word(7), [])
                  ])
               ])
            ])
         ]),
      rule(dl, p(0,se,p(0,situait,p(0,entre,p(0,86,p(0,et,'.'))))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(appl(word(9),appl(word(10),appl(appl(word(12),word(13)),word(11)))),word(8)), [
         rule(axiom, se, lit(cl_r)-word(8), []),
         rule(dr, p(0,situait,p(0,entre,p(0,86,p(0,et,'.')))), dl(0,lit(cl_r),dl(0,lit(np(nom,_,_)),lit(s(main))))-appl(word(9),appl(word(10),appl(appl(word(12),word(13)),word(11)))), [
            rule(axiom, situait, dr(0,dl(0,lit(cl_r),dl(0,lit(np(nom,_,_)),lit(s(main)))),lit(pp(entre)))-word(9), []),
            rule(dr, p(0,entre,p(0,86,p(0,et,'.'))), lit(pp(entre))-appl(word(10),appl(appl(word(12),word(13)),word(11))), [
               rule(axiom, entre, dr(0,lit(pp(entre)),lit(np(acc,_,_)))-word(10), []),
               rule(dl, p(0,86,p(0,et,'.')), lit(np(acc,_,_))-appl(appl(word(12),word(13)),word(11)), [
                  rule(axiom, 86, lit(np(acc,_,_))-word(11), []),
                  rule(dr, p(0,et,'.'), dl(0,lit(np(acc,_,_)),lit(np(acc,_,_)))-appl(word(12),word(13)), [
                     rule(axiom, et, dr(0,dl(0,lit(np(acc,_,_)),lit(np(acc,_,_))),lit(np(_,_,_)))-word(12), []),
                     rule(axiom, '.', lit(np(_,_,_))-word(13), [])
                     ])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '87.', dl(0,lit(s(main)),lit(txt))-word(14), [])
   ])).

% 566. Il y avait plus de femmes que d' hommes dans le monde . 

proof(566, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,avait,p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes)))))),p(0,dans,p(0,le,monde))),'.'), lit(txt)-appl(word(12),appl(appl(word(9),appl(word(10),word(11))),appl(appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,avait,p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes)))))),p(0,dans,p(0,le,monde))), lit(s(main))-appl(appl(word(9),appl(word(10),word(11))),appl(appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,avait,p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes)))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,avait,p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,avait,p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes)))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))), [
               rule(axiom, avait, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,p(0,plus,p(0,de,femmes)),p(0,que,p(0,'d\'',hommes))), lit(np(acc,_,_))-appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8)))), [
                  rule(dr, p(0,plus,p(0,de,femmes)), dr(0,lit(np(acc,_,_)),lit(s(q)))-appl(word(3),appl(word(4),word(5))), [
                     rule(axiom, plus, dr(0,dr(0,lit(np(acc,_,_)),lit(s(q))),lit(pp(de)))-word(3), []),
                     rule(dr, p(0,de,femmes), lit(pp(de))-appl(word(4),word(5)), [
                        rule(axiom, de, dr(0,lit(pp(de)),lit(n))-word(4), []),
                        rule(axiom, femmes, lit(n)-word(5), [])
                        ])
                     ]),
                  rule(dr, p(0,que,p(0,'d\'',hommes)), lit(s(q))-appl(word(6),appl(word(7),word(8))), [
                     rule(axiom, que, dr(0,lit(s(q)),lit(pp(de)))-word(6), []),
                     rule(dr, p(0,'d\'',hommes), lit(pp(de))-appl(word(7),word(8)), [
                        rule(axiom, 'd\'', dr(0,lit(pp(de)),lit(n))-word(7), []),
                        rule(axiom, hommes, lit(n)-word(8), [])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,dans,p(0,le,monde)), dl(1,lit(s(main)),lit(s(main)))-appl(word(9),appl(word(10),word(11))), [
         rule(axiom, dans, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(np(acc,_,_)))-word(9), []),
         rule(dr, p(0,le,monde), lit(np(acc,_,_))-appl(word(10),word(11)), [
            rule(axiom, le, dr(0,lit(np(acc,_,_)),lit(n))-word(10), []),
            rule(axiom, monde, lit(n)-word(11), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(12), [])
   ])).

% 568. Il y avait plus d' hommes que de femmes en Ouzbékistan . 

proof(568, rule(dl, p(0,p(1,p(0,'Il',p(0,y,p(0,avait,p(0,p(0,plus,p(0,'d\'',hommes)),p(0,que,p(0,de,femmes)))))),p(0,en,'Ouzbékistan')),'.'), lit(txt)-appl(word(11),appl(appl(word(9),word(10)),appl(appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)),word(0)))), [
   rule(dl, p(1,p(0,'Il',p(0,y,p(0,avait,p(0,p(0,plus,p(0,'d\'',hommes)),p(0,que,p(0,de,femmes)))))),p(0,en,'Ouzbékistan')), lit(s(main))-appl(appl(word(9),word(10)),appl(appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)),word(0))), [
      rule(dl, p(0,'Il',p(0,y,p(0,avait,p(0,p(0,plus,p(0,'d\'',hommes)),p(0,que,p(0,de,femmes)))))), lit(s(main))-appl(appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)),word(0)), [
         rule(axiom, 'Il', lit(np(nom,il,3-s))-word(0), []),
         rule(dl, p(0,y,p(0,avait,p(0,p(0,plus,p(0,'d\'',hommes)),p(0,que,p(0,de,femmes))))), dl(0,lit(np(nom,il,3-s)),lit(s(main)))-appl(appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))),word(1)), [
            rule(axiom, y, lit(cl_y)-word(1), []),
            rule(dr, p(0,avait,p(0,p(0,plus,p(0,'d\'',hommes)),p(0,que,p(0,de,femmes)))), dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main))))-appl(word(2),appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8))))), [
               rule(axiom, avait, dr(0,dl(0,lit(cl_y),dl(0,lit(np(nom,il,3-s)),lit(s(main)))),lit(np(acc,_,_)))-word(2), []),
               rule(dr, p(0,p(0,plus,p(0,'d\'',hommes)),p(0,que,p(0,de,femmes))), lit(np(acc,_,_))-appl(appl(word(3),appl(word(4),word(5))),appl(word(6),appl(word(7),word(8)))), [
                  rule(dr, p(0,plus,p(0,'d\'',hommes)), dr(0,lit(np(acc,_,_)),lit(s(q)))-appl(word(3),appl(word(4),word(5))), [
                     rule(axiom, plus, dr(0,dr(0,lit(np(acc,_,_)),lit(s(q))),lit(pp(de)))-word(3), []),
                     rule(dr, p(0,'d\'',hommes), lit(pp(de))-appl(word(4),word(5)), [
                        rule(axiom, 'd\'', dr(0,lit(pp(de)),lit(n))-word(4), []),
                        rule(axiom, hommes, lit(n)-word(5), [])
                        ])
                     ]),
                  rule(dr, p(0,que,p(0,de,femmes)), lit(s(q))-appl(word(6),appl(word(7),word(8))), [
                     rule(axiom, que, dr(0,lit(s(q)),lit(pp(de)))-word(6), []),
                     rule(dr, p(0,de,femmes), lit(pp(de))-appl(word(7),word(8)), [
                        rule(axiom, de, dr(0,lit(pp(de)),lit(n))-word(7), []),
                        rule(axiom, femmes, lit(n)-word(8), [])
                        ])
                     ])
                  ])
               ])
            ])
         ]),
      rule(dr, p(0,en,'Ouzbékistan'), dl(1,lit(s(main)),lit(s(main)))-appl(word(9),word(10)), [
         rule(axiom, en, dr(0,dl(1,lit(s(main)),lit(s(main))),lit(n))-word(9), []),
         rule(axiom, 'Ouzbékistan', lit(n)-word(10), [])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(11), [])
   ])).

% 574. Certains hommes ne portent pas de bleu . 

proof(574, rule(dl, p(0,p(0,p(0,'Certains',hommes),p(0,ne,p(0,portent,p(0,pas,p(0,de,bleu))))),'.'), lit(txt)-appl(word(7),appl(appl(word(2),appl(word(3),appl(word(4),appl(word(5),word(6))))),appl(word(0),word(1)))), [
   rule(dl, p(0,p(0,'Certains',hommes),p(0,ne,p(0,portent,p(0,pas,p(0,de,bleu))))), lit(s(main))-appl(appl(word(2),appl(word(3),appl(word(4),appl(word(5),word(6))))),appl(word(0),word(1))), [
      rule(dr, p(0,'Certains',hommes), lit(np(nom,_,_))-appl(word(0),word(1)), [
         rule(axiom, 'Certains', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(axiom, hommes, lit(n)-word(1), [])
         ]),
      rule(dr, p(0,ne,p(0,portent,p(0,pas,p(0,de,bleu)))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(2),appl(word(3),appl(word(4),appl(word(5),word(6))))), [
         rule(axiom, ne, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),dl(0,lit(np(nom,_,_)),lit(s(main))))-word(2), []),
         rule(dr, p(0,portent,p(0,pas,p(0,de,bleu))), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(3),appl(word(4),appl(word(5),word(6)))), [
            rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(3), []),
            rule(dr, p(0,pas,p(0,de,bleu)), lit(np(acc,_,_))-appl(word(4),appl(word(5),word(6))), [
               rule(axiom, pas, dr(0,lit(np(acc,_,_)),lit(pp(de)))-word(4), []),
               rule(dr, p(0,de,bleu), lit(pp(de))-appl(word(5),word(6)), [
                  rule(axiom, de, dr(0,lit(pp(de)),lit(n))-word(5), []),
                  rule(axiom, bleu, lit(n)-word(6), [])
                  ])
               ])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(7), [])
   ])).

% 580. La plupart des hommes portent du bleu . 

proof(580, rule(dl, p(0,p(0,p(0,'La',p(0,plupart,p(0,des,hommes))),p(0,portent,p(0,du,bleu))),'.'), lit(txt)-appl(word(7),appl(appl(word(4),appl(word(5),word(6))),appl(word(0),appl(word(1),appl(word(2),word(3)))))), [
   rule(dl, p(0,p(0,'La',p(0,plupart,p(0,des,hommes))),p(0,portent,p(0,du,bleu))), lit(s(main))-appl(appl(word(4),appl(word(5),word(6))),appl(word(0),appl(word(1),appl(word(2),word(3))))), [
      rule(dr, p(0,'La',p(0,plupart,p(0,des,hommes))), lit(np(nom,_,_))-appl(word(0),appl(word(1),appl(word(2),word(3)))), [
         rule(axiom, 'La', dr(0,lit(np(nom,_,_)),lit(n))-word(0), []),
         rule(dr, p(0,plupart,p(0,des,hommes)), lit(n)-appl(word(1),appl(word(2),word(3))), [
            rule(axiom, plupart, dr(0,lit(n),lit(pp(de)))-word(1), []),
            rule(dr, p(0,des,hommes), lit(pp(de))-appl(word(2),word(3)), [
               rule(axiom, des, dr(0,lit(pp(de)),lit(n))-word(2), []),
               rule(axiom, hommes, lit(n)-word(3), [])
               ])
            ])
         ]),
      rule(dr, p(0,portent,p(0,du,bleu)), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),word(6))), [
         rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(4), []),
         rule(dr, p(0,du,bleu), lit(np(acc,_,_))-appl(word(5),word(6)), [
            rule(axiom, du, dr(0,lit(np(acc,_,_)),lit(n))-word(5), []),
            rule(axiom, bleu, lit(n)-word(6), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(7), [])
   ])).

% 582. Au moins deux hommes portent du beige . 

proof(582, rule(dl, p(0,p(0,p(0,p(0,'Au',moins),p(0,deux,hommes)),p(0,portent,p(0,du,beige))),'.'), lit(txt)-appl(word(7),appl(appl(word(4),appl(word(5),word(6))),appl(appl(word(0),word(1)),appl(word(2),word(3))))), [
   rule(dl, p(0,p(0,p(0,'Au',moins),p(0,deux,hommes)),p(0,portent,p(0,du,beige))), lit(s(main))-appl(appl(word(4),appl(word(5),word(6))),appl(appl(word(0),word(1)),appl(word(2),word(3)))), [
      rule(dr, p(0,p(0,'Au',moins),p(0,deux,hommes)), lit(np(nom,_,_))-appl(appl(word(0),word(1)),appl(word(2),word(3))), [
         rule(dr, p(0,'Au',moins), dr(0,lit(np(nom,_,_)),lit(np(_,_,_)))-appl(word(0),word(1)), [
            rule(axiom, 'Au', dr(0,dr(0,lit(np(nom,_,_)),lit(np(_,_,_))),lit(n))-word(0), []),
            rule(axiom, moins, lit(n)-word(1), [])
            ]),
         rule(dr, p(0,deux,hommes), lit(np(_,_,_))-appl(word(2),word(3)), [
            rule(axiom, deux, dr(0,lit(np(_,_,_)),lit(n))-word(2), []),
            rule(axiom, hommes, lit(n)-word(3), [])
            ])
         ]),
      rule(dr, p(0,portent,p(0,du,beige)), dl(0,lit(np(nom,_,_)),lit(s(main)))-appl(word(4),appl(word(5),word(6))), [
         rule(axiom, portent, dr(0,dl(0,lit(np(nom,_,_)),lit(s(main))),lit(np(acc,_,_)))-word(4), []),
         rule(dr, p(0,du,beige), lit(np(acc,_,_))-appl(word(5),word(6)), [
            rule(axiom, du, dr(0,lit(np(acc,_,_)),lit(n))-word(5), []),
            rule(axiom, beige, lit(n)-word(6), [])
            ])
         ])
      ]),
   rule(axiom, '.', dl(0,lit(s(main)),lit(txt))-word(7), [])
   ])).

