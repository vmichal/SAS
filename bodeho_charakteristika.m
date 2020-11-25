
%s = tf('s'); %smbolické s
%H = -0.01 * (s+1000)/(s+10); %

%bode(H);
%step(H);

H = tf([2 5 1],[1 2 3])
bode(H)
figure
nyqopt = nyquistplot(H);
setoptions(nyqopt, 'ShowFullContour','off')

BodePlotGui(H)
