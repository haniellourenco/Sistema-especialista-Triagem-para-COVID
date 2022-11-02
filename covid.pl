:- dynamic triagem/2.

covid :- carrega('pacientes.bd'),
    format('~n*** Triagem ***~n~n'),
    repeat,
    pergunta(Paciente),
    pergunta(Paciente, Temperatura),
    responde(Paciente),
    continua(Resposta),
    Resposta = n,
    !,
    salva(capital,'pacientes.bd').

carrega(Arquivo) :-
    exists_file(Arquivo),
    consult(Arquivo);
    true.

pergunta(Paciente) :-
    format('~nQual o nome do paciente? '),
    gets(Paciente).

pergunta(Temperatura, Paciente) :-
    format('~nQual a temperatura do paciente ~w? ',[Paciente]),
    gets(Temperatura),
    asserta(triagem(Paciente,Temperatura)).


responde(Paciente) :-
    triagem(Paciente),
    !,
    format('A paciente de ~w tem  de temperatura ', [Paciente]).

responde(Idade) :-
    format('Qual � a idade de ~w? ', [Paciente]),
    gets(Idade),
    asserta(triagem(Paciente, Idade)).

continua(Resposta) :-
    format('~nContinua? [s/n] '),
    get_char(Resposta),
    get_char('\n').

gets(String) :-
    read_line_to_codes(user_input,Char),
    name(String,Char).

