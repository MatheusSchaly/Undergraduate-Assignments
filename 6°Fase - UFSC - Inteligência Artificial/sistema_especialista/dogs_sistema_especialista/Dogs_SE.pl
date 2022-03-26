% Dupla: Matheus Henrique Schaly e Pedro Alonso Condessa

energia(baixa).
energia(media).
energia(alta).

obediencia(baixa).
obediencia(media).
obediencia(alta).

inteligencia(baixa).
inteligencia(media).
inteligencia(alta).

territorialista(baixa).
territorialista(media).
territorialista(alta).

amizade_com_criancas(baixa).
amizade_com_criancas(media).
amizade_com_criancas(alta).

amizade_com_outros_animais(baixa).
amizade_com_outros_animais(media).
amizade_com_outros_animais(alta).

raca(rw, E, O, I, T, A, C) :- (E = alta), (O = alta), (I = alta), (T = alta), (A = alta), (C = baixa).
raca(pa, E, O, I, T, A, C) :- (E = alta), (O = alta), (I = alta), (T = alta), (A = alta), (C = baixa).
raca(dh, E, O, I, T, A, C) :- (E = alta), (O = baixa), (I = alta), (T = media), (A = alta), (C = alta).
raca(fb, E, O, I, T, A, C) :- (E = alta), (O = baixa), (I = baixa), (T = alta), (A = media), (C = media).
raca(ch, E, O, I, T, A, C) :- (E = media), (O = media), (I = alta), (T = baixa), (A = alta), (C = alta).
raca(hs, E, O, I, T, A, C) :- (E = alta), (O = baixa), (I = alta), (T = baixa), (A = alta), (C = alta).
raca(pu, E, O, I, T, A, C) :- (E = alta), (O = media), (I = alta), (T = alta), (A = alta), (C = alta).
raca(sa, E, O, I, T, A, C) :- (E = alta), (O = baixa), (I = alta), (T = media), (A = alta), (C = media).
raca(gh, E, O, I, T, A, C) :- (E = alta), (O = alta), (I = alta), (T = baixa), (A = alta), (C = alta).
raca(bo, E, O, I, T, A, C) :- (E = alta), (O = media), (I = alta), (T = baixa), (A = alta), (C = alta).
raca(st, E, O, I, T, A, C) :- (E = media), (O = media), (I = alta), (T = baixa), (A = alta), (C = media).
raca(bc, E, O, I, T, A, C) :- (E = alta), (O = alta), (I = alta), (T = alta), (A = alta), (C = media).
raca(cc, E, O, I, T, A, C) :- (E = media), (O = media), (I = media), (T = alta), (A = baixa), (C = baixa).
raca(be, E, O, I, T, A, C) :- (E = alta), (O = alta), (I = alta), (T = baixa), (A = alta), (C = alta).
raca(po, E, O, I, T, A, C) :- (E = alta), (O = alta), (I = alta), (T = alta), (A = alta), (C = alta).
raca(gr, E, O, I, T, A, C) :- (E = alta), (O = alta), (I = alta), (T = baixa), (A = alta), (C = alta).
raca(lr, E, O, I, T, A, C) :- (E = alta), (O = alta), (I = alta), (T = media), (A = alta), (C = alta).
raca(ma, E, O, I, T, A, C) :- (E = media), (O = alta), (I = alta), (T = media), (A = media), (C = alta).
raca(sb, E, O, I, T, A, C) :- (E = baixa), (O = media), (I = media), (T = baixa), (A = alta), (C = alta).
raca(mt, E, O, I, T, A, C) :- (E = baixa), (O = alta), (I = alta), (T = media), (A = alta), (C = alta).
raca(pn, E, O, I, T, A, C) :- (E = alta), (O = baixa), (I = alta), (T = alta), (A = baixa), (C = baixa).
raca(pc, E, O, I, T, A, C) :- (E = baixa), (O = alta), (I = alta), (T = alta), (A = alta), (C = media).
raca(pe, E, O, I, T, A, C) :- (E = baixa), (O = media), (I = media), (T = alta), (A = baixa), (C = alta).
raca(bh, E, O, I, T, A, C) :- (E = baixa), (O = media), (I = media), (T = baixa), (A = media), (C = alta).
raca(ck, E, O, I, T, A, C) :- (E = baixa), (O = alta), (I = alta), (T = baixa), (A = alta), (C = alta).

nome(pa, 'Pastor Alemao').
nome(dh, 'Dachshund').
nome(fb, 'French Bulldog').
nome(ch, 'Chihuahua').
nome(hs, 'Husky Siberiano').
nome(pu, 'Pug').
nome(rw, 'Rottweiler').
nome(sa, 'Spitz Alemao').
nome(gh, 'Greyhound').
nome(bo, 'Boxer').
nome(st, 'Shih Tzu').
nome(bc, 'Border Collie').
nome(cc, 'Chow Chow').
nome(be, 'Beagle').
nome(po, 'Poodle').
nome(gr, 'Golden Retriever').
nome(lr, 'Labrador Retriever').
nome(ma, 'Maltes').
nome(sb, 'Sao Bernardo').
nome(mt, 'Mastiff').
nome(pn, 'Pastor da Anatolia').
nome(pc, 'Pastor do Caucaso').
nome(pe, 'Pequines').
nome(bh, 'Pastor do Caucaso').
nome(ck, 'Cavalier King Charles Spaniel').

meu_dog(X) :- writeln("Vamos achar o seu tipo de cachorro ideal! Opcoes: baixa, media, alta."),
              writeln('Qual o nivel de energia do seu cachorro?'), read(E),
          	  writeln('Qual o nivel de obediencia do seu cachorro?'), read(O),
          	  writeln('Quao inteligente o cachorro e?'), read(I),
          	  writeln('O quao territorialista o seu cachorro e?'), read(T),
          	  writeln('O quao amigo o seu cachorro e das criancas?'), read(A),
	  	  	  writeln('O quao amigo o seu cachorro e dos outros animais?'), read(C),
          	  raca(N, E, O, I, T, A, C), nome(N, X).
