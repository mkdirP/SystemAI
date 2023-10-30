:- discontiguous
    place/2,male/1,female/1,friend/2,enemy/2,spouse/2, force/2,
    teacher/2, subordinate/2, which_subordinate_enemies/2,sister/2,all_friends/2,all_person/2,is_classmate/2,sub_friends/2,fri_friends/2,
    war/2, who_win/2, output/2.

female("Sun Shangxiang").
male("Liu Bei").
male("Zhao Yun").
male("ZhuGe liang").
male("Guan Yu").
male("Zhang Fei").
force("Sun Shangxiang", 100).
force("Liu Bei", 60).
force("Zhao Yun", 75 ).
force("ZhuGe Liang", 70).
force("Guan Yu", 78).
force("Zhang Fei", 50).


place("Da Qiao", "Wuguo").
female("Da Qiao").
place("Xiao Qiao", "Wuguo").
female("Xiao Qiao").
male("Sun Ce").
male("Zhou Yu").
force("Da Qiao", 30).
force("Xiao Qiao", 58).
force("Sun Ce", 95).
force("Zhou Yu", 69).

male("Cao Cao").
male("Dian Wei").
male("XiaHou Dun").
male("SiMa Yi").
force("Cao Cao", 80).
force("Dian Wei", 82).
force("XiaHou Dun", 77).
force("SiMa Yi", 87).

male("Zhuang Zhou").
male("Lao Fuzi").

teacher("Zhuang Zhou", "SiMa Yi").
teacher("Lao Fuzi", "ZhuGe Liang").
teacher("Lao Fuzi", "Zhou Yu").
spouse("Sun Shangxiang", "Liu Bei").
spouse("Da Qiao", "Sun Ce").
spouse("Xiao Qiao", "Zhou Yu").
subordinate("Zhao Yun", "Liu Bei").
subordinate("ZhuGe Liang", "Liu Bei").
subordinate("Dian Wei", "Cao Cao").
subordinate("XiaHou Dun", "Cao Cao").
subordinate("SiMa Yi", "Cao Cao").
subordinate("Zhou Yu", "Sun Ce").
enemy("Cao Cao", "Liu Bei").
enemy("Sun Ce", "Liu Bei").
enemy("Cao Cao", "Sun Ce").
friend("Guan Yu", "Liu Bei").
friend("Zhang Fei", "Liu Bei").


/* Три партии являются врагами друг друга.*/
is_enemy(A, B):-
    enemy(B, A);
    enemy(A, B).

/* Дружить друг с другом */
is_friend(A, B):- 
    friend(B, A);
    friend(A, B).

/* Двое, находящиеся под командованием одного человека, также являются друзьями.*/
sub_friends(A,B):-
    subordinate(A, C), subordinate(B, C), A \= B.
fri_friends(A, B):-
    (is_friend(A, C), is_friend(B, C), A \= B); 
    is_friend(A, B).
/* Поиск всех своих друзей.*/
all_friends(A, B):-
    sub_friends(A, B); fri_friends(A, B), A \= B.

/* Если два человека в одной команде и оба - девушки, то они - сестры.*/
sister(A, B):-
    place(A, C),
    place(B, C),
    female(A),
    female(B),
    A \= B.
/* subordinate врага - это и враги вождя.*/
which_subordinate_enemies(A, B):-
    is_enemy(A, C),
    subordinate(B, C),
    A \= B.
/* Все лица, принадлежащие к лидеру, находящиеся в одном лагере */
all_person(A, B):-
    spouse(B, A); subordinate(B, A); is_friend(B, A).

/* Определить, находятся ли два человека в одном классе, и если да, то вывести, кто является преподавателем*/
is_classmate(A, B):-
    teacher(C, A),
    teacher(C, B),
    A \= B,
    write("teacher is: "), write(C).


war(A, B):-
    is_enemy(A, B)->(
        write(A), write(" attck "), write(B),nl,
        write(A), write(" dispatch: "), read(X),
        write(B), write(" dispatch: "), read(Y),
        who_win(X, Y)
    ); write("They are not enemies.").
    

who_win(A, B):-
    force(A, C),
    force(B, D),
    (C > D, output(A, B)); output(B, A).

output(A, B):-
    write(A), write(" win "), write(B).



