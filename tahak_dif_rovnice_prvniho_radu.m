% øešení diferenciálních rovnic 1. øádu
 
reseni1 = dsolve('Dx = (x^2 - 4)/t', 'x(1) = 0', 't')
% vèetnì poèáteèní podmínky, x je derivováno podle t
% Dx znamená první derivace x
 
osa_t = 0:0.1:10;
y1 = subs(reseni1, 't', osa_t);  % dosazení hodnot za 't' ve vzorci
plot(osa_t, y1) % vykreslení
 
% vliv poèáteèních podmínek...
 
reseni2 = dsolve('Dx = (x^2 - 4)/t', 'x(1) = 1', 't')
hold on
y2 = subs(reseni2, 't', osa_t);  % dosazení hodnot za 't' ve vzorci
plot(osa_t, y2, 'r') % vykreslení
hold off
 
grid
 
reseni3 = dsolve('Dx = (x^2 - 4)/t', 'x(0) = -4', 't')
% øešení neexistuje
 
reseni4 = dsolve('Dx = (x^2 - 4)/t', 'x(1) = 2', 't')
% øešení je konstanta