%% How to use FFT in Matlab to analyze the spectrum of a signal: some simple examples

clear all
close all
fs = 1/150; % Sampling frequency
t = 0:fs:1; % Time vector of 1 second
f = 10*2*pi; % Create a sin/cos/square wave of angular frequency of f rad/sec.

%% Some signals:
x = sin(t*f);
%x = cos(t*f);
%x = square(t*f);
%x = 2*exp(-5*t);
%x = chirp(t,0,1,50);

%x=rectpuls(t, 0.2);
%x = 1/(sqrt(2*pi*0.01))*(exp(-t.^2/(2*0.01)));


%nfft = length of FFT. If nfft=2^p, FFT complexity= N*log2(N) instead of N^2
nfft = 1024; 

% Take FFT, padding with zeros so that length(X) is equal to nfft
X = fft(x,nfft);


% FFT is symmetric, throw away second half
X = X(1:nfft/2);

% Take the magnitude of FFT of x
mx = abs(X);

% Frequency vector
fv = 2*pi*(0:nfft/2-1)/(fs*nfft);
% Generate the plot, title and labels.
figure(1);
plot(t,x);
xlabel('Time (sec)');
ylabel('Signal');
figure(2);
plot(fv,mx);
xlabel('Angular frequency (rad/sec)');
ylabel('Amplitude spectrum');
