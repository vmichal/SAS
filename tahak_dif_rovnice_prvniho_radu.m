% �e�en� diferenci�ln�ch rovnic 1. ��du
 
reseni1 = dsolve('Dx = (x^2 - 4)/t', 'x(1) = 0', 't')
% v�etn� po��te�n� podm�nky, x je derivov�no podle t
% Dx znamen� prvn� derivace x
 
osa_t = 0:0.1:10;
y1 = subs(reseni1, 't', osa_t);  % dosazen� hodnot za 't' ve vzorci
plot(osa_t, y1) % vykreslen�
 
% vliv po��te�n�ch podm�nek...
 
reseni2 = dsolve('Dx = (x^2 - 4)/t', 'x(1) = 1', 't')
hold on
y2 = subs(reseni2, 't', osa_t);  % dosazen� hodnot za 't' ve vzorci
plot(osa_t, y2, 'r') % vykreslen�
hold off
 
grid
 
reseni3 = dsolve('Dx = (x^2 - 4)/t', 'x(0) = -4', 't')
% �e�en� neexistuje
 
reseni4 = dsolve('Dx = (x^2 - 4)/t', 'x(1) = 2', 't')
% �e�en� je konstanta