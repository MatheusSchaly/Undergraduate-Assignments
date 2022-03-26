%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Construção de Sistema Especialista para recomendar vinhos. %%
%%  Dupla: Lucas Verdade e Lucas Zacchi.                       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 


acidez(baixa).
acidez(media).
acidez(alta).

corpo(leve).
corpo(medio_encorpado).
corpo(encorpado).

aroma(frutado).
aroma(nao_frutado).

tipo(seco).
tipo(demi_seco).

cor(rose).
cor(tinto).
cor(branco).


nome_vinho(bb, "Bordeaux Blanc").
nome_vinho(sb, "Sauvignon Blanc").
nome_vinho(rs, "Riesling").
nome_vinho(rp, "Rosé de Provence").
nome_vinho(pn, "Pinot Noir").
nome_vinho(cn, "Chianti Novo").
nome_vinho(ch, "Chianti Reserva").
nome_vinho(cs, "Cabernet Sauvignon").
nome_vinho(mr, "Merlot").
nome_vinho(cr, "Champagne Rosé").

atributos_vinho(bb, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = branco), (Tipo = seco), (Corpo = leve), (Acidez = media), (Aroma = nao_frutado),!.
atributos_vinho(sb, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = branco), (Tipo = seco), (Corpo = leve), (Acidez = alta), (Aroma = nao_frutado), !.
atributos_vinho(rs, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = branco), (Tipo = demi_seco), (Corpo = leve), (Acidez = baixa), (Aroma = frutado), !.
atributos_vinho(rp, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = rose), (Tipo = demi_seco), (Corpo = leve), (Acidez = baixa), (Aroma = frutado), !.
atributos_vinho(pn, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = tinto), (Tipo = seco), (Corpo = encorpado), (Acidez = media), (Aroma = nao_frutado), !.
atributos_vinho(cn, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = tinto), (Tipo = seco), (Corpo = medio_encorpado), (Acidez = media), (Aroma = nao_frutado), !.
atributos_vinho(ch, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = tinto), (Tipo = seco), (Corpo = encorpado), (Acidez = baixa), (Aroma = nao_frutado), !.
atributos_vinho(cs, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = tinto), (Tipo = seco), (Corpo = encorpado), (Acidez = alta), (Aroma = nao_frutado), !.
atributos_vinho(mr, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = tinto), (Tipo = seco), (Corpo = medio_encorpado), (Acidez = media), (Aroma = nao_frutado), !.
atributos_vinho(cr, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = rose), (Tipo = seco), (Corpo = leve), (Acidez = baixa), (Aroma = frutado), !.


carne_branca(porco).
carne_branca(aves).

carne_vermelha(grelhada).
carne_vermelha(assada).
carne_vermelha(com_molho).

legume(beringela_abobrinha).
legume(molho_delicado).

massa(mais_gorduroso).
massa(tomato).
massa(aglio_olio).

peixe(defumado).
peixe(frito_assado).
peixe(vapor).

sobremesa(chocolate).
sobremesa(fruta).


prato(carne_branca).
prato(carne_vermelha).
prato(peixe).
prato(massa).
prato(sobremesa).
prato(legumes).



% REGRAS

%   Regra 1
%     SE tipo prato = Peixes e frutos do Mar
%     E  Tipo Peixe = Peixe no vapor
%     ENTÃO cor vinho = Branco CNF 100%
%           tipo vinho = Seco CNF 100%
%           corpo do vinho = leve CNF 100%
sugestao_vinho(Vinho, peixes, vapor) :-  melhor_vinho(Vinho_cod, branco, seco , leve, _ , _), nome_vinho(Vinho_cod, Vinho).

%   Regra 2
%     SE tipo prato = Peixes e frutos do Mar
%     E  Tipo Peixe = Peixe fritos ou grelhado
%     ENTÃO aroma vinho = frutado CNF 100%
%           cor vinho = Rosé CNF 100%
%           acidez do vinho = pouco ácido CNF 100%
sugestao_vinho(Vinho, peixes, frito_assado) :-  melhor_vinho(Vinho_cod, rose , _ , _, baixa , frutado ), nome_vinho(Vinho_cod, Vinho).

%   Regra 3
%     SE tipo prato = Peixes e frutos do Mar
%     E  Tipo Peixe = Peixe defumado
%     ENTÃO tipo vinho = Seco CNF 100%
%           cor vinho = Branco CNF 100%
%           acidez do vinho = ácido  CNF 100%
sugestao_vinho(Vinho, peixe, defumado) :-  melhor_vinho(Vinho_cod, branco, seco , _, alta , _ ), nome_vinho(Vinho_cod, Vinho).

%   Regra 4
%     SE tipo prato = Legumes
%     E  Tipo Legume = Acompanha molho delicado
%     ENTÃO cor vinho = Branco CNF 100%
%           aroma vinho = frutado CNF 100%
%           acidez do vinho = pouco ácido CNF 100%
sugestao_vinho(Vinho, legumes, molho_delicado) :-  melhor_vinho(Vinho_cod, branco, _ , _, baixa , frutado ), nome_vinho(Vinho_cod, Vinho).

%   Regra 5
%     SE tipo prato = Legumes
%     E  Tipo Legume = beringela ou abobrinha
%     ENTÃO cor vinho = Tinto CNF 100%
%           tipo vinho = Seco CNF 100%
%           corpo do vinho = encorpado CNF 100%
sugestao_vinho(Vinho, legumes, beringela_abobrinha) :-  melhor_vinho(Vinho_cod, tinto, seco , encorpado, _ , _ ), nome_vinho(Vinho_cod, Vinho).

%   Regra 6
%     SE tipo prato = Massas
%     E  Tipo Massa = com molho de tomates
%     ENTÃO cor vinho = Tinto CNF 100%
%           tipo vinho = Seco CNF 100%
%           acidez do vinho = médio ácido CNF 80%
sugestao_vinho(Vinho, massa, tomato) :-  melhor_vinho(Vinho_cod, tinto, seco , _,  media , _ ), nome_vinho(Vinho_cod, Vinho).

%   Regra 7
%     SE tipo prato = Massas
%     E  Tipo Massa = com molho mais gorduroso (carne ou creme de leite)
%     ENTÃO cor vinho = Tinto CNF 100%
%           corpo do vinho = encorpado CNF 100%
%           acidez do vinho = ácido  CNF 100%
%           tipo vinho = Seco CNF 100%
sugestao_vinho(Vinho, massa, gorduroso) :-  melhor_vinho(Vinho_cod, tinto, seco , encorpado, alta , _ ), nome_vinho(Vinho_cod, Vinho).

%   Regra 8
%     SE tipo prato = Massas
%     E  Tipo Massa = ao alho e óleo
%     ENTÃO cor vinho = Tinto CNF 100%
%           tipo vinho = Seco CNF 100%
%           corpo do vinho = leve CNF 100%
sugestao_vinho(Vinho, massa, aglio_olio) :-  melhor_vinho(Vinho_cod, tinto, seco , leve, _ , _ ), nome_vinho(Vinho_cod, Vinho).

%   Regra 9
%     SE tipo prato = Carne branca
%     E  Tipo Carne Branca = Porco
%     OU Tipo Carne Branca = Aves
%     ENTÃO cor vinho = Branco CNF 60%
%           cor vinho = Tinto CNF 100%
%           acidez do vinho = médio ácido CNF 100%
sugestao_vinho(Vinho, carne_branca, porco) :-  melhor_vinho(Vinho_cod, tinto, _ , _, media, _ ), nome_vinho(Vinho_cod, Vinho).
sugestao_vinho(Vinho, carne_branca, porco) :-  melhor_vinho(Vinho_cod, branco, _ , _, media, _ ), nome_vinho(Vinho_cod, Vinho).
sugestao_vinho(Vinho, carne_branca, aves) :-  melhor_vinho(Vinho_cod, tinto, _ , _, media, _ ), nome_vinho(Vinho_cod, Vinho).
sugestao_vinho(Vinho, carne_branca, aves) :-  melhor_vinho(Vinho_cod, branco, _ , _, media, _ ), nome_vinho(Vinho_cod, Vinho).

%   Regra 10
%     SE tipo prato = Carne vermelha
%     E  Tipo Carne Vermelha = grellhada
%     ENTÃO cor vinho = Tinto CNF 100%
%           acidez do vinho = médio ácido CNF 100%
sugestao_vinho(Vinho, carne_vermelha, grelhada) :-  melhor_vinho(Vinho_cod, tinto, _ , _, media, _ ), nome_vinho(Vinho_cod, Vinho).


%   Regra 11
%     SE tipo prato = Carne vermelha
%     E  Tipo Carne Vermelha = com molho
%     OU Tipo Carne Vermelha = assada
%     ENTÃO tipo vinho = Seco CNF 100%
%           cor vinho = Tinto CNF 100%
%           corpo do vinho = encorpado CNF 100%
sugestao_vinho(Vinho, carne_vermelha, com_molho) :- melhor_vinho(Vinho_cod, tinto, seco, encorpado, _ ,_), nome_vinho(Vinho_cod, Vinho).
sugestao_vinho(Vinho, carne_vermelha, assada) :- melhor_vinho(Vinho_cod, tinto, seco, encorpado, _ ,_), nome_vinho(Vinho_cod, Vinho).

%   Regra 12
%     SE tipo prato = Sobremesas
%     E  Tipo Sobremesa = Frutas
%     ENTÃO cor vinho = Branco CNF 100%
%           cor vinho = Rosé CNF 80%
%           aroma vinho = frutado CNF 100%
sugestao_vinho(Vinho, sobremesa, fruta) :-  melhor_vinho(Vinho_cod, branco, _ , _, _, frutado ), nome_vinho(Vinho_cod, Vinho).
sugestao_vinho(Vinho, sobremesa, fruta) :-  melhor_vinho(Vinho_cod, rose, _ , _, _, frutado ), nome_vinho(Vinho_cod, Vinho).


%   Regra 13
%     SE cor vinho = Branco
%     E  tipo vinho = Seco
%     E  corpo do vinho = leve
%     ENTÃO Sugestão de vinho = Bordeaux blanc  CNF 100%
melhor_vinho(bb, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = branco), (Tipo = seco), (Corpo = leve),!.

%   Regra 14
%     SE cor vinho = Tinto
%     E  tipo vinho = Seco
%     E  corpo do vinho = leve
%     ENTÃO Sugestão de vinho = Merlot CNF 100%
melhor_vinho(mr, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = tinto), (Tipo = seco), (Corpo = leve),!.

%   Regra 15
%     SE cor vinho = Branco
%     E  tipo vinho = Seco
%     E  corpo do vinho = médio encorpado
%     ENTÃO Sugestão de vinho = Sauvignon Blanc CNF 100%
melhor_vinho(sb, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = branco), (Tipo = seco), (Corpo = medio_encorpado),!.

%   Regra 16
%     SE cor vinho = Tinto
%     E  tipo vinho = Seco
%     E  corpo do vinho = médio encorpado
%     ENTÃO Sugestão de vinho = Chianti novo CNF 100%
%           Sugestão de vinho = Merlot CNF 100%
melhor_vinho(cn, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = tinto), (Tipo = seco), (Corpo = medio_encorpado).
melhor_vinho(mr, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = tinto), (Tipo = seco), (Corpo = medio_encorpado),!.

%   Regra 17
%     SE cor vinho = Tinto
%     E  tipo vinho = Seco
%     E  corpo do vinho = encorpado
%     ENTÃO Sugestão de vinho = Cabernet Sauvignon  CNF 100%
%           Sugestão de vinho = Chianti Reserva  CNF 100%
%           Sugestão de vinho = Pinot Noir  CNF 100%
melhor_vinho(cs, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = tinto), (Tipo = seco), (Corpo = encorpado).
melhor_vinho(ch, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = tinto), (Tipo = seco), (Corpo = encorpado).
melhor_vinho(pn, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = tinto), (Tipo = seco), (Corpo = encorpado),!.


%   Regra 18
%     SE cor vinho = Tinto
%     E  acidez do vinho = ácido
%     ENTÃO Sugestão de vinho = Pinot Noir  CNF 100%
%           Sugestão de vinho = Chianti Reserva  CNF 100%
%           Sugestão de vinho = Cabernet Sauvignon  CNF 100%
melhor_vinho(pn, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = tinto), (Acidez = alta).
melhor_vinho(ch, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = tinto), (Acidez = alta).
melhor_vinho(cs, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = tinto), (Acidez = alta),!.

%   Regra 19
%     SE cor vinho = Branco
%     E  tipo vinho = Seco
%     E  acidez do vinho = ácido
%     ENTÃO Sugestão de vinho = Sauvignon Blanc CNF 100%
melhor_vinho(sb, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = branco), (Tipo = seco), (Acidez = alta),!.

%   Regra 20
%     SE cor vinho = Tinto
%     E  acidez do vinho = médio ácido
%     ENTÃO Sugestão de vinho = Chianti novo CNF 100%
%           Sugestão de vinho = Merlot CNF 100%
melhor_vinho(cn, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = tinto), (Acidez = media).
melhor_vinho(mr, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = tinto), (Acidez = media),!.


%   Regra 21
%     SE cor vinho = Branco
%     E  tipo vinho = Seco
%     E  acidez do vinho = médio ácido
%     ENTÃO Sugestão de vinho = Bordeaux blanc  CNF 100%
melhor_vinho(bb, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = branco), (Tipo = seco), (Acidez = media),!.

%   Regra 22
%     SE cor vinho = Rosé
%     E  aroma vinho = frutado
%     ENTÃO Sugestão de vinho = Rosé de Provence  CNF 100%
melhor_vinho(rp, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = rose), (Aroma = frutado),!.

%   Regra 23
%     SE cor vinho = Branco
%     E  aroma vinho = frutado
%     ENTÃO Sugestão de vinho = Riesling CNF 100%
melhor_vinho(rs, Cor, Tipo, Corpo, Acidez, Aroma) :- (Cor = branco), (Aroma = frutado),!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                      %%    
%%    %%   %%    %%%%%%%%    %%%%%%%    %%
%%    %%   %%    %%          %%   %%    %%
%%    %%   %%    %%%%%%%%    %%   %%    %%
%%    %%   %%          %%    %%   %%    %%
%%    %%%%%%%    %%%%%%%%    %%%%%%%    %%
%%                                      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Para pedir uma recomendação de vinho de acordo com seu prato de comida use o comando:
% sugestao_vinho(Vinho, <SEU PRATO>, <SUBTIPO DO PRATO>).
% Para receber mais de uma recomendação (se houver) aperte o botão ";" para que o programa
% continue sugerindo. 

% Sendo que SEU PRATO pode ser: carne_branca, carne_vermelha, peixe, massa, sobremesa ou legumes.
% E para cada prato existe um subtipo.

% Para carne_branca existe os seguintes subtipos:
%  - porco
%  - aves

% Para carne_vermelha existe os seguintes subtipos:
%  - grelhada
%  - assada
%  - com_molho

% Para peixe existe os seguintes subtipos:
%  - defumado
%  - frito_assado
%  - vapor

% Para massa existe os seguintes subtipos:
%  - aglio_olio
%  - mais_gorduroso
%  - tomato

% Para sobremesa existe os seguintes subtipos:
%  - fruta
%  - chocolate

% Para legumes existe os seguintes subtipos:
%  - beringela_abobrinha
%  - molho_delicado



% Exemplo de execução:
% Comando para pedir sugestão de vinho ao comer massa com molho de tomate:
sugestao_vinho(Vinho, massa, tomato).
% Output:
%   Vinho = "Merlot" ;
%   true.
