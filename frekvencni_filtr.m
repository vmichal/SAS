[u, fs] = audioread("C:\Users\vomi\Downloads\impulsni_odezva\shrek.wav");
 
% filtr simulující pøenos analogovým telefonem
Wp = [300 3400]/(fs/2); Ws = [50 3800]/(fs/2); Rp = 1; Rs = 30;
[n, Wp] = ellipord(Wp, Ws, Rp, Rs); [b, a] = ellip(n,Rp,Rs,Wp);
 
freqz(b, a, 1000, fs)  % vykreslení frekvenèní charakteristiky
[H, f] = freqz(b, a, length(u), 'whole', fs);  % získání frekvenèní charakteristiky H
 
figure
plot(f, abs(H))  % vykreslení bez dB
 
U = fft(u);   % spektrum vstupu
Y = U .* H;   % násobení spektra s frekvenèní charakteristikou
y = ifft(Y);  % pøevod do èasové oblasti
 
soundsc(y, fs);