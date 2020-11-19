close all; %close windows
clc; % clear command window


% CTRL+R zakomentuje øádek, CTRL+T odkomentuje øádek
freq = 440; % [Hz]
samplingFreq = 1024; % number of samples per second
amplitude = 0.1;
duration = 2; % [s]
phase = pi/4; % sin, cos take arguments in radians

%time_axis = 0: 1 /samplingFreq : duration - 1/samplingFreq; % generate vector of values from 0 to duration with step equal to sampling period
time_axis  = (0 : samplingFreq*duration-1) / samplingFreq; % safer float arithmetic, not necessary in matlab

%create the signal
x = amplitude * sin(2*pi* freq * time_axis + phase);

stem(time_axis(1:100), x(1:100), '.');
xlabel('time [s]');
ylabel('signal');

sound(x, samplingFreq);