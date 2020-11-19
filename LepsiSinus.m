close all   % zav��t okna v�ech obr�zk�
clear all   % smazat v�echny prom�nn�
clc         % smazat v�stup v Command window
 
% Kreslen� sinu, 4 zp�soby
 
% 1. sinus se vztahem k �asu
fs = 8000;  % (Hz)   vzorkovac� frekvence
 
f = 440;    % (Hz)   frekvence generovan� sinusovky
doba = .02; % (s) trv�n� sign�lu v sekund�ch
 
t1 = (0: doba*fs-1) / fs;   % �asov� osa
         % Mus�me ode��st posledn� vzorek, proto�e za��n�me od nuly.
         % Krok je 1/fs, proto�e kdyby bylo nap�. fs = 10 vzork� za sekundu,
         % tak �asov� krok bude 1 sekunda / 10 d�lk� = 0.1 sekundy.
 
x1 = sin(2*pi*f*t1);   % 2*pi je perioda sin, vyn�sobeno frekvenc�
                       % = kolikr�t za sekundu se to oto�� dokola,
                       % kr�t �as v sekund�ch - v jak� ��sti zrovna jsme
 
figure;        % nov� obr�zek
subplot(4,1,1) % rozd�l�me na panely: 4 ��dky, 1 sloupec, nyn� kreslit do 1. panelu
plot(t1, x1)   % a� zobrazen� vypad� spojit�, sign�l je diskr�tn�: pro diskr�tn� zobrazen� pou��t stem()
xlabel('---> t [s]')         % popis osy
ylabel('---> sin(\omegat)')  % psan� �eck�ch p�smen
title('Harmonick� pr�b�h')   % titulek
grid                         % m��ka
 
 
% 2. zadan� po�et vzork� sign�lu
vzorku = 25;
t2 = (0: vzorku - 1)/fs;
x2 = sin(2*pi*f*t2);
 
subplot 412          % zkr�cen� zp�sob z�pisu subplot
stem(t2, x2)         % diskr�tn� vykreslen�
axis([0 0.02 -1 1])  % ru�n� nastaven� os
 
 
% 3. po�et period sign�lu
period = 4;
t3 = (0: period/f*fs - 1)/fs;
x3 = sin(2*pi*f*t3);
% Pozn.: pozor, zde jsme si vymysleli po�adavek,
% kter� nevede na cel� po�et vzork�: period/f*fs = 72.727.
% Ve skute�nosti ani p�edchoz� dv� sinusoidy nejsou periodick� ve smyslu,
% jak� zn�me ve spojit�m �ase: nevych�z� cel� po�et vzork� na periodu,
% proto je ka�d� perioda trochu jin�. P�i rekonstrukci sign�lu do spojit�
% oblasti se v�ak jedn� o klasick� periodick� sign�l. Toto je b�n� chov�n�
% diskr�tn�ch sign�l�, na kter� si mus�me zvyknout.
 
subplot 413
plot(t3, x3, '-or', 'LineWidth', 2)  % spojit� ��ra, kole�ka v bodech,
                                     % �erven�, tlou��ka ��ry 2
axis tight % automatick� nastaven� os
 
 
% 4. diskr�tn� sinusovka bez vztahu k �asu
N = 20;   % po�et vzork� na periodu
P = 2;    % po�et period
NN = P*N; % celkov� po�et vzork�
n = 0: NN - 1;   % n jsou indexy vzork� - nen� to �as
                 % vzorek ��slo NN by pat�il u� do 3. periody
x4 = sin(2*pi*n/N);
 
subplot 414
stem(n, x4)
xlabel('---> n [index vzorku]')
title('Diskr�tn� harmonick� pr�b�h')