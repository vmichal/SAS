close all
clear all
clc

[signal, fs] = audioread('C:\Users\vomi\Downloads\SAS_zvuky\fletna.wav');
duration = length(signal)/fs;
time = (0 : length(signal)-1)/fs;

subplot(3,1,1)
plot(time, signal);
xlabel("�as (s)");
ylabel("Amplituda");
grid;

%sound(signal, fs);

subplot(3,1,2);
S = fft(signal) / length(signal);


%Z pohledu na amplitudov� spektrum zjist�me, �e z�kladn� frekvence bude
%121Hz a v�echny dal�� vy��� harmonick� jsou n�sobek tohoto ��sla. 
frequencies = (0: length(S)-1)/duration;
plot(frequencies, 20*log10(abs(S)));
xlim([0 4000])
xlabel("Frekvence (Hz)");
ylabel("Amplituda [dB]");

subplot(3,1,3);
plot(frequencies, angle(S));
xlabel("Frekvence (Hz)");
ylabel("F�ze");
