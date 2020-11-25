% Úvod do Symbolic Math Toolbox
 
syms x y   % zavedení symbolických promìnných
 
x + x + y  % obdržíme 2*x + y
 
 
sqrt(2)    % obdržíme 1.4142
 
sqrt(str2sym('2'))  % z konstanty se udìlá symbolický výraz,
                % jako výsledek obdržíme 2^(1/2)
  % Pozn. nebo ve starém Matlabu: sqrt(sym('2'))
double(ans)   % závìreèný pøevod symbolického výrazu na desetinné èíslo
 
 
vyraz = str2sym('a^3 + 3*a^2 + 3*a + 1');
factor(vyraz)     % rozklad na souèin

factor(x^2 + 1, 'FactorMode', 'complex')
 
% nebo
syms b
expand((b-2)^5)  % roznásobení
 
% dosazení - substituce
c = str2sym('2*x + 3');
subs(c, x, 5) % dosadíme do c: x=5
 
% derivace
diff(cos(x), x)
 
% integrace
int(sin(x), x)  % neurèitý integrál nepøièítá konstantu!
int(sin(x), x, 0, pi/2) % urèitý integrál
 
% øešení rovnic
solve(x^4 == 1, x)  % rovnice se píše jako øetìzec. 4 øešení
 
% øešení soustav rovnic
syms x y z
[x,y,z] = solve(z == 4*x, x == y, z == x^2 + y^2, x, y, z)
 
% vpa - výpoèty na libovolný poèet míst
vpa(str2sym('sin(3)'), 600)  % pozor na apostrofy. Hodnota na 600 míst.
 
% zjednodušování výrazù
syms x
f = cos(x) + i*sin(x);
simple(f) % v nových verzích Matlabu již nefunguje

rewrite(cos(x) + 1i*sin(x), 'exp') % toto jde, když tedy víme, co po nìm chceme

syms w t
simplify(cos(w*t) + 1i*sin(w*t), 'Steps', 10)  % toto také pøekvapivì jde,
simplify(cos(x) + 1i*sin(x), 'Steps', 300) % ale toto mu nedojde ani po 300 krocích...