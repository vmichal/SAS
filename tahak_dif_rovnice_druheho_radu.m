% diferenciální rovnice 2. øádu
 
% a) nekmitavý prùbìh - aperiodický (nadkritické tlumení)
res1 = dsolve('D2y + 3e3*Dy + 1e6*y=0', 'Dy(0) = 10', 'y(0) = 0');
% pøesný, ale tìžko èitelný výsledek
vpa(res1, 3) % èítelnìjší výsledek
solve(str2sym('lambda^2 + 3e3*lambda + 1e6 = 0')) % charakteristická rovnice
% 2 reálné koøeny
 
% b) nekmitavý prùbìh - aperiodický (kritické tlumení)
res2 = dsolve('D2y + 2e3*Dy + 1e6*y=0', 'Dy(0) = 10', 'y(0) = 0');
vpa(res2, 3) % èítelnìjší výsledek
solve(str2sym('lambda^2 + 2e3*lambda + 1e6 = 0')) % charakteristická rovnice
% dvojnásobný reálný koøen
 
% c) tlumené kmity (podkritické tlumení)
res3 = dsolve('D2y + 1e3*Dy + 1e6*y=0', 'Dy(0) = 10', 'y(0) = 0');
vpa(res3, 3) % èítelnìjší výsledek
solve(str2sym('lambda^2 + 1e3*lambda + 1e6 = 0')) % charakteristická rovnice
% 2 komplexnì sdružené koøeny
 
figure
osa_t = 0: 0.0001: 0.02;
plot(osa_t, [subs(res1, 't', osa_t); subs(res2, 't', osa_t); subs(res3, 't', osa_t)])
legend('nekmitavý', 'mez', 'tlumené kmity')
grid