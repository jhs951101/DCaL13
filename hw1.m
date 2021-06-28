clear all; close all;

Rb = 1000;  fs = 40*Rb;
Tb = 1/Rb;  ts = 1/fs;

fc = 5*Rb;
% -------------------------------------------------------------------------
bit = [1, 0, 0, 1, 0, 1, randi([0,1], 1, 10^4)];
bitlen = length(bit);

% -------------------------------------------------------------------------
% ASK
[xt,time,pulse_shape] = Function_Linecode_Gen(bit, 'unipolar_nrz', Rb, fs);
carrier = cos(2*pi*fc*time);
x_ask = xt.*carrier;
% -------------------------------------------------------------------------
M = 2^13;
[Pxt, Fxt] = PSD_DB(xt, fs, M);
[Pask, Fask] = PSD_DB(x_ask, fs, M);

Fxt = Fxt./1000;    % Frequency vector in KHz;
Fask = Fask./1000;  % Frequency vector in KHz;
% -------------------------------------------------------------------------
AXIS_TIME = [0, 6*Tb, -1.25 1.25];
figure
subplot(211), stairs(time, xt);
grid on; axis(AXIS_TIME);
xlabel('time [sec]'); ylabel('Signal waveform');
title('Baseband and ASK waveform');
subplot(212), plot(time, x_ask);
grid on; axis(AXIS_TIME);
xlabel('time [sec]'); ylabel('Signal waveform');

AXIS_FREQ = [0 10 -80 0];
figure
subplot(211), plot(Fxt, 10*log10(Pxt));
grid on; axis(AXIS_FREQ);
xlabel('Frequency [KHz]'); ylabel('Power Spectral Density [dB]');
title('Spectra of baseband signal and bandpass signal');
subplot(212), plot(Fask, 10*log10(Pask));
grid on; axis(AXIS_FREQ);
xlabel('Frequency [KHz]'); ylabel('Power Spectral Density [dB]');

% -------------------------------------------------------------------------
% FSK
[xt, time, pulse_shape] = Function_Linecode_Gen(bit, 'polar_nrz', Rb, fs);
xt1 = (1-xt)/2;     xt2 = (1+xt)/2;

fc1 = 2*Rb;     fc2 = 5*Rb;
carrier1 = cos(2*pi*fc1*time);
carrier2 = cos(2*pi*fc2*time);

x_fsk = xt1.*carrier1 + xt2.*carrier2;
% -------------------------------------------------------------------------
[Pxt, Fxt] = PSD_DB(xt, fs, M);
[Pfsk, Ffsk] = PSD_DB(x_fsk, fs, M);

Fxt = Fxt./1000;    % Frequency vector in KHz;
Ffsk = Ffsk./1000;  % Frequency vector in KHz;
% -------------------------------------------------------------------------
figure
subplot(211), stairs(time, xt);
grid on; axis(AXIS_TIME);
xlabel('time [sec]'); ylabel('Signal waveform');
title('Baseband and FSK waveform');
subplot(212), plot(time, x_fsk);
grid on; axis(AXIS_TIME);
xlabel('time [sec]'); ylabel('Signal waveform');

figure
subplot(211), plot(Fxt, 10*log10(Pxt));
grid on; axis(AXIS_FREQ);
xlabel('Frequency [KHz]'); ylabel('Power Spectral Density [dB]');
title('Spectra of baseband signal and bandpass signal');
subplot(212), plot(Ffsk, 10*log10(Pfsk));
grid on; axis(AXIS_FREQ);
xlabel('Frequency [KHz]'); ylabel('Power Spectral Density [dB]');

% -------------------------------------------------------------------------
% PSK
[xt, time, pulse_shape] = Function_Linecode_Gen(bit, 'polar_nrz', Rb, fs);
carrier = cos(2*pi*fc*time);
x_psk = xt.*carrier;

% -------------------------------------------------------------------------
[Pxt, Fxt] = PSD_DB(xt, fs, M);
[Ppsk, Fpsk] = PSD_DB(x_psk, fs, M);

Fxt = Fxt./1000;    % Frequency vector in KHz;
Fpsk = Fpsk./1000;  % Frequency vector in KHz;
% -------------------------------------------------------------------------
figure
subplot(211), stairs(time, xt);
grid on; axis(AXIS_TIME);
xlabel('time [sec]'); ylabel('Signal waveform');
title('Baseband and PSK waveform');
subplot(212), plot(time, x_psk);
grid on; axis(AXIS_TIME);
xlabel('time [sec]'); ylabel('Signal waveform');

figure
subplot(211), plot(Fxt, 10*log10(Pxt));
grid on; axis(AXIS_FREQ);
xlabel('Frequency [KHz]'); ylabel('Power Spectral Density [dB]');
title('Spectra of baseband signal and bandpass signal');
subplot(212), plot(Fpsk, 10*log10(Ppsk));
grid on; axis(AXIS_FREQ);
xlabel('Frequency [KHz]'); ylabel('Power Spectral Density [dB]');
