% diferenci�ln� rovnice 2. ��du
 
% a) nekmitav� pr�b�h - aperiodick� (nadkritick� tlumen�)
res1 = dsolve('D2y + 3e3*Dy + 1e6*y=0', 'Dy(0) = 10', 'y(0) = 0');
% p�esn�, ale t�ko �iteln� v�sledek
vpa(res1, 3) % ��teln�j�� v�sledek
solve(str2sym('lambda^2 + 3e3*lambda + 1e6 = 0')) % charakteristick� rovnice
% 2 re�ln� ko�eny
 
% b) nekmitav� pr�b�h - aperiodick� (kritick� tlumen�)
res2 = dsolve('D2y + 2e3*Dy + 1e6*y=0', 'Dy(0) = 10', 'y(0) = 0');
vpa(res2, 3) % ��teln�j�� v�sledek
solve(str2sym('lambda^2 + 2e3*lambda + 1e6 = 0')) % charakteristick� rovnice
% dvojn�sobn� re�ln� ko�en
 
% c) tlumen� kmity (podkritick� tlumen�)
res3 = dsolve('D2y + 1e3*Dy + 1e6*y=0', 'Dy(0) = 10', 'y(0) = 0');
vpa(res3, 3) % ��teln�j�� v�sledek
solve(str2sym('lambda^2 + 1e3*lambda + 1e6 = 0')) % charakteristick� rovnice
% 2 komplexn� sdru�en� ko�eny
 
figure
osa_t = 0: 0.0001: 0.02;
plot(osa_t, [subs(res1, 't', osa_t); subs(res2, 't', osa_t); subs(res3, 't', osa_t)])
legend('nekmitav�', 'mez', 'tlumen� kmity')
grid