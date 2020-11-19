close all   % zavøít okna všech obrázkù
clear all   % smazat všechny promìnné
clc         % smazat výstup v Command window
 
% Kreslení sinu, 4 zpùsoby
 
% 1. sinus se vztahem k èasu
fs = 8000;  % (Hz)   vzorkovací frekvence
 
f = 440;    % (Hz)   frekvence generované sinusovky
doba = .02; % (s) trvání signálu v sekundách
 
t1 = (0: doba*fs-1) / fs;   % èasová osa
         % Musíme odeèíst poslední vzorek, protože zaèínáme od nuly.
         % Krok je 1/fs, protože kdyby bylo napø. fs = 10 vzorkù za sekundu,
         % tak èasový krok bude 1 sekunda / 10 dílkù = 0.1 sekundy.
 
x1 = sin(2*pi*f*t1);   % 2*pi je perioda sin, vynásobeno frekvencí
                       % = kolikrát za sekundu se to otoèí dokola,
                       % krát èas v sekundách - v jaké èásti zrovna jsme
 
figure;        % nový obrázek
subplot(4,1,1) % rozdìlíme na panely: 4 øádky, 1 sloupec, nyní kreslit do 1. panelu
plot(t1, x1)   % aè zobrazení vypadá spojitì, signál je diskrétní: pro diskrétní zobrazení použít stem()
xlabel('---> t [s]')         % popis osy
ylabel('---> sin(\omegat)')  % psaní øeckých písmen
title('Harmonický prùbìh')   % titulek
grid                         % møížka
 
 
% 2. zadaný poèet vzorkù signálu
vzorku = 25;
t2 = (0: vzorku - 1)/fs;
x2 = sin(2*pi*f*t2);
 
subplot 412          % zkrácený zpùsob zápisu subplot
stem(t2, x2)         % diskrétní vykreslení
axis([0 0.02 -1 1])  % ruèní nastavení os
 
 
% 3. poèet period signálu
period = 4;
t3 = (0: period/f*fs - 1)/fs;
x3 = sin(2*pi*f*t3);
% Pozn.: pozor, zde jsme si vymysleli požadavek,
% který nevede na celý poèet vzorkù: period/f*fs = 72.727.
% Ve skuteènosti ani pøedchozí dvì sinusoidy nejsou periodické ve smyslu,
% jaký známe ve spojitém èase: nevychází celý poèet vzorkù na periodu,
% proto je každá perioda trochu jiná. Pøi rekonstrukci signálu do spojité
% oblasti se však jedná o klasický periodický signál. Toto je bìžné chování
% diskrétních signálù, na které si musíme zvyknout.
 
subplot 413
plot(t3, x3, '-or', 'LineWidth', 2)  % spojitá èára, koleèka v bodech,
                                     % èervenì, tlouška èáry 2
axis tight % automatické nastavení os
 
 
% 4. diskrétní sinusovka bez vztahu k èasu
N = 20;   % poèet vzorkù na periodu
P = 2;    % poèet period
NN = P*N; % celkový poèet vzorkù
n = 0: NN - 1;   % n jsou indexy vzorkù - není to èas
                 % vzorek èíslo NN by patøil už do 3. periody
x4 = sin(2*pi*n/N);
 
subplot 414
stem(n, x4)
xlabel('---> n [index vzorku]')
title('Diskrétní harmonický prùbìh')