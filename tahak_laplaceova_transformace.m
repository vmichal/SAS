% v�po�et posunut� exponenci�ly - viz p��klad na tabuli
clear all  % Pozor! P�i pou�it� Symbolic Math Toolbox je nutn� pou��vat clear all,
% jinak se nevyma�ou r�zn� nastaven� uvnit� symbolic modulu.
 
syms t t0 s a
 
% Pokus 1
laplace(exp(-a*(t-t0)), t, s)
 
% Dostali jsme spr�vn� v�sledek? Ne. V �em je chyba? Aha, my jsme to �patn�
% zadali. Exponenci�lu nesta�� posunout, je nutno ji vyn�sobit posunut�m
% jednotkov�m skokem. Zad�n� obr�zkem je jasn�, nicm�n� Matlabu mus�me
% obr�zek matematicky interpretovat.
 
% Pokus 2
laplace(exp(-a*(t-t0)) * heaviside(t-t0), t, s)
 
% Hm, Matlab to neum� spo��tat? Takov�ch pen�z to st�lo...
 
% Ne, chyba je op�t na na�� stran�. Matematika nejsou po�ty. Matlabu do�lo,
% �e t0 m��e b�t jak kladn�, tak ale i z�porn�. Pro ka�d� p��pad pak vyjdou
% �pln� jin� �e�en�, proto rad�i na na�i ot�zku neodpov�d�l.
 
% �e�en� 1: natvrdo dosadit za t0 kladnou hodnotu.
% �e�en� 2: ��ct Matlabu, �e t0 je kladn�.
 
assume(t0 > 0) % a nebo takto: t0 = sym('t0', 'positive');
laplace(exp(-a*(t-t0)) * heaviside(t-t0), t, s)
 
% Sl�va, sl�va, sl�va, d�d n�m rady d�v�.
 
% Toto je mysl�m siln� argument pro to, abychom si p�r p��klad� v ruce
% spo��tali a z�skali t�m tak zku�enost, kter� n�m umo�n� kriticky hodnotit
% v�sledky z�skan� po��ta�em, a chybu hledat a) na jeho stran� (dokonal�
% software neexistuje a b) na na�� stran� (i kdy� jen velmi z��dka, tak i my
% m��eme ud�lat chybu, nap��klad hned v zad�n�).
Pom��e i kontrola - prov�st zp�tnou transformaci v�sledku a vykreslit si, zda jsme obdr�eli opravdu to, co jsme cht�li.

clear all
syms t t0 s a
 
t0 = sym('t0', 'positive');
Ys = laplace(exp(-a*(t-t0)) * heaviside(t-t0), t, s)
 
Yt = ilaplace(Ys)
 
y1 = subs(Yt, [a t0], [1 2])
 
t_axis = 0:0.01:5;
y = subs(y1, t, t_axis);
plot(t_axis, double(y));