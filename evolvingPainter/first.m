clc; close all; clear all; 

c = 4;
e = zeros(20,40);

[perf, trajectory] =  OneChromePerf(e, c);

perf

imagesc(trajectory)