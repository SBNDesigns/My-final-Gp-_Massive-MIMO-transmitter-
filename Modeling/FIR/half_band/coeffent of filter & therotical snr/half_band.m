Fs_in = 3.125e6; 
L1 = 2;
Fs1 = Fs_in * L1;       
Fpass1 = 1.2e6;        
Fstop1 = Fs1/2 - Fpass1;
TW1 = Fstop1 - Fpass1;
Astop1 = 60;

spec_obj1 = fdesign.halfband('TW,Ast', TW1,Astop1, Fs1);
fir_obj1 = design(spec_obj1, 'equiripple');

h1 = fir_obj1.Numerator;
N1 = length(h1) - 1;

fprintf('  - i/p frequency: %.3f MHz\n', Fs_in/1e6);
fprintf('  - o/p frequency: %.3f MHz\n', Fs1/1e6);
fprintf('  - Order: %d\n', N1);
fprintf('  - Coefficients (Taps):\n');
disp(h1');

nfft = 31250; 
[H1, f1] = freqz(h1, 1, nfft, Fs1);

Fhb = Fs1/4;
F1_stop = Fhb + TW1/2;

[~, idx1] = min(abs(f1 - F1_stop));
att1 = -max(20 * log10(abs(H1(idx1:end)) + eps));

fprintf('--- Achieved Attenuation ---\n');
fprintf('Achieved attenuation for H1 (Stopband): %.2f dB\n', att1);

figure;
[H,f] = freqz(h1,1,4096,Fs1);
plot(f/1e6, 20*log10(abs(H)));
grid on;
xlabel('Frequency (MHz)');
ylabel('Magnitude (dB)');
title('Frequency Response of Half-band Filter');

figure;
fvtool(h1,1,'Fs',Fs1);




