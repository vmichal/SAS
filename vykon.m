function [out] = vykon(x)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
out = x(:).'*x(:)/length(x);
end

