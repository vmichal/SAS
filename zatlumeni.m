function [zatlumeny_signal] = zatlumeni(signal, db)
%UNTITLED [zatlumeny_signal] = zatlumeni(signal, db)
%   Detailed explanation goes here

zatlumeny_signal = signal * 10^(db/20);
end

