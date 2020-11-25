% výpoèet posunuté exponenciály - viz pøíklad na tabuli
clear all  % Pozor! Pøi použití Symbolic Math Toolbox je nutné používat clear all,
% jinak se nevymažou rùzná nastavení uvnitø symbolic modulu.
 
syms t t0 s a
 
% Pokus 1
laplace(exp(-a*(t-t0)), t, s)
 
% Dostali jsme správný výsledek? Ne. V èem je chyba? Aha, my jsme to špatnì
% zadali. Exponenciálu nestaèí posunout, je nutno ji vynásobit posunutým
% jednotkovým skokem. Zadání obrázkem je jasné, nicménì Matlabu musíme
% obrázek matematicky interpretovat.
 
% Pokus 2
laplace(exp(-a*(t-t0)) * heaviside(t-t0), t, s)
 
% Hm, Matlab to neumí spoèítat? Takových penìz to stálo...
 
% Ne, chyba je opìt na naší stranì. Matematika nejsou poèty. Matlabu došlo,
% že t0 mùže být jak kladné, tak ale i záporné. Pro každý pøípad pak vyjdou
% úplnì jiná øešení, proto radši na naši otázku neodpovìdìl.
 
% Øešení 1: natvrdo dosadit za t0 kladnou hodnotu.
% Øešení 2: øíct Matlabu, že t0 je kladné.
 
assume(t0 > 0) % a nebo takto: t0 = sym('t0', 'positive');
laplace(exp(-a*(t-t0)) * heaviside(t-t0), t, s)
 
% Sláva, sláva, sláva, dìd nám rady dává.
 
% Toto je myslím silný argument pro to, abychom si pár pøíkladù v ruce
% spoèítali a získali tím tak zkušenost, která nám umožní kriticky hodnotit
% výsledky získané poèítaèem, a chybu hledat a) na jeho stranì (dokonalý
% software neexistuje a b) na naší stranì (i když jen velmi zøídka, tak i my
% mùžeme udìlat chybu, napøíklad hned v zadání).
Pomùže i kontrola - provést zpìtnou transformaci výsledku a vykreslit si, zda jsme obdrželi opravdu to, co jsme chtìli.

clear all
syms t t0 s a
 
t0 = sym('t0', 'positive');
Ys = laplace(exp(-a*(t-t0)) * heaviside(t-t0), t, s)
 
Yt = ilaplace(Ys)
 
y1 = subs(Yt, [a t0], [1 2])
 
t_axis = 0:0.01:5;
y = subs(y1, t, t_axis);
plot(t_axis, double(y));