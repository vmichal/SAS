[u, fs] = audioread("C:\Users\vomi\Downloads\impulsni_odezva\shrek.wav");
 
% filtr simuluj�c� p�enos analogov�m telefonem
Wp = [300 3400]/(fs/2); Ws = [50 3800]/(fs/2); Rp = 1; Rs = 30;
[n, Wp] = ellipord(Wp, Ws, Rp, Rs); [b, a] = ellip(n,Rp,Rs,Wp);
 
freqz(b, a, 1000, fs)  % vykreslen� frekven�n� charakteristiky
[H, f] = freqz(b, a, length(u), 'whole', fs);  % z�sk�n� frekven�n� charakteristiky H
 
figure
plot(f, abs(H))  % vykreslen� bez dB
 
U = fft(u);   % spektrum vstupu
Y = U .* H;   % n�soben� spektra s frekven�n� charakteristikou
y = ifft(Y);  % p�evod do �asov� oblasti
 
soundsc(y, fs);