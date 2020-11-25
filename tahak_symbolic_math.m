% �vod do Symbolic Math Toolbox
 
syms x y   % zaveden� symbolick�ch prom�nn�ch
 
x + x + y  % obdr��me 2*x + y
 
 
sqrt(2)    % obdr��me 1.4142
 
sqrt(str2sym('2'))  % z konstanty se ud�l� symbolick� v�raz,
                % jako v�sledek obdr��me 2^(1/2)
  % Pozn. nebo ve star�m Matlabu: sqrt(sym('2'))
double(ans)   % z�v�re�n� p�evod symbolick�ho v�razu na desetinn� ��slo
 
 
vyraz = str2sym('a^3 + 3*a^2 + 3*a + 1');
factor(vyraz)     % rozklad na sou�in

factor(x^2 + 1, 'FactorMode', 'complex')
 
% nebo
syms b
expand((b-2)^5)  % rozn�soben�
 
% dosazen� - substituce
c = str2sym('2*x + 3');
subs(c, x, 5) % dosad�me do c: x=5
 
% derivace
diff(cos(x), x)
 
% integrace
int(sin(x), x)  % neur�it� integr�l nep�i��t� konstantu!
int(sin(x), x, 0, pi/2) % ur�it� integr�l
 
% �e�en� rovnic
solve(x^4 == 1, x)  % rovnice se p�e jako �et�zec. 4 �e�en�
 
% �e�en� soustav rovnic
syms x y z
[x,y,z] = solve(z == 4*x, x == y, z == x^2 + y^2, x, y, z)
 
% vpa - v�po�ty na libovoln� po�et m�st
vpa(str2sym('sin(3)'), 600)  % pozor na apostrofy. Hodnota na 600 m�st.
 
% zjednodu�ov�n� v�raz�
syms x
f = cos(x) + i*sin(x);
simple(f) % v nov�ch verz�ch Matlabu ji� nefunguje

rewrite(cos(x) + 1i*sin(x), 'exp') % toto jde, kdy� tedy v�me, co po n�m chceme

syms w t
simplify(cos(w*t) + 1i*sin(w*t), 'Steps', 10)  % toto tak� p�ekvapiv� jde,
simplify(cos(x) + 1i*sin(x), 'Steps', 300) % ale toto mu nedojde ani po 300 kroc�ch...