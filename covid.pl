:- dynamic paciente/3.

covid :- carrega('paciente.bd'),
    format('~n*** Paciente ***~n~n'),
    repeat,
    nome(Nome),
    temperatura(Nome),
    freq_cardiaca(Nome),
    freq_respiratoria(Nome),
    pa_sistolica(Nome),
    saturacao(Nome),
    dispneia(Nome),
    idade(Nome),
    comorbidades(Nome),
    responde(Nome),
    salva(paciente,'paciente.bd'),
    continua(Resposta),
    Resposta = n,
    !.

carrega(Arquivo) :-
    exists_file(Arquivo),
    consult(Arquivo);
    true.

nome(Nome) :-
    format('~nQual o nome do paciente? '),
    gets(Nome).

temperatura(Nome) :-
    format('~nQual a temperatura de ~w? ', [Nome]),
    gets(Temperatura),
    asserta(paciente(Nome, temperatura, Temperatura)).

freq_cardiaca(Nome):-
    format('~nQual a frequência cardíaca de ~w? ', [Nome]),
    gets(FreqCard),
    asserta(paciente(Nome, freq_cardiaca, FreqCard)).


freq_respiratoria(Nome):-
    format('~nQual a frequência respiratória de ~w? ', [Nome]),
    gets(FreqResp),
    asserta(paciente(Nome, freq_respiratoria, FreqResp)).

pa_sistolica(Nome):-
    format('~nQual a PA Sistólica de ~w? ', [Nome]),
    gets(PaSis),
    asserta(paciente(Nome, pa_sistolica, PaSis)).

saturacao(Nome):-
    format('~nQual a saturação de ~w? ', [Nome]),
    gets(Saturacao),
    asserta(paciente(Nome, saturacao, Saturacao)).

dispneia(Nome):-
    format('~n~w tem dispnéia? ', [Nome]),
    gets(TemDispneia),
    asserta(paciente(Nome, dispneia, TemDispneia)).

idade(Nome):-
    format('~nQual a idade de ~w? ', [Nome]),
    gets(Idade),
    asserta(paciente(Nome, idade, Idade)).

comorbidades(Nome):-
    format('~n~w possui quantas comorbidades? ', [Nome]),
    gets(NumComorb),
    asserta(paciente(Nome, comorbidades, NumComorb)).


responde(Nome):-
    gravidade(Nome, Char),
    !,
    format('A condição de ~w é ~w',[Nome,Char]).
continua(Resposta) :-
    format('~nContinua? [s/n] '),
    get_char(Resposta),
    get_char('\n').

gets(String) :-
    read_line_to_codes(user_input,Char),
    name(String,Char).



salva(Paciente,Arquivo):-
    tell(Arquivo),
    listing(Paciente),
    told.

gravidade(Nome, grave):-
    paciente(Nome, freq_respiratoria,FreqResp), FreqResp > 30;
    paciente(Nome, pa_sistolica,PaSis),PaSis < 90;
    paciente(Nome, saturacao,Saturacao), Saturacao < 95;
    paciente(Nome, dispneia,TemDispneia), TemDispneia = "sim".

gravidade(Nome, medio):-
    paciente(Nome, temperatura,Temperatura), Temperatura > 39;
    paciente(Nome, pa_sistolica,PaSis),PaSis >=90,PaSis =< 100;
    paciente(Nome, idade,Idade), Idade > 80;
    paciente(Nome, comorbidades,NumComorb), NumComorb > 1.

gravidade(Nome, leve):-
    paciente(Nome, temperatura,Temperatura), (Temperatura < 35, (Temperatura >= 37, Temperatura =< 39));
    paciente(Nome, freq_cardiaca,FreqCard),FreqCard > 100;
    paciente(Nome, freq_respiratoria,FreqResp),FreqResp >= 19, FreqResp =< 30;
    paciente(Nome, idade,Idade), Idade >= 60, Idade =< 79;
    paciente(Nome, comorbidades,NumComorb), NumComorb = 1.