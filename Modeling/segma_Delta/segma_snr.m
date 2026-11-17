
% الكود المعدل: رسم الطيف باستخدام التردد المطبع (Normalized Frequency)
% =========================================================================

clearvars -except out;

signal_data = out.output_signal.Data;

fs = 100e6;       % Sampling frequency (Hz)
OSR = 32;
N = length(signal_data);

% --- PSD ---
[psd, f] = pwelch(signal_data, hann(N), 0, N, fs, 'power');

% --- Signal and Noise ---
BW_bins = floor(N / (2 * OSR)); 
[signal_power, signal_bin_index] = max(psd(1:BW_bins));

noise_bins = [2:signal_bin_index-5, signal_bin_index+5:BW_bins];
noise_power = sum(psd(noise_bins));

% --- SNR ---
SNR = 10 * log10(signal_power / noise_power);

fprintf('--- SNR Calculation Results ---\n');
fprintf('Calculated SNR = %.2f dB\n', SNR);
fprintf('---------------------------------\n');

% --- Plot Normalized Frequency ---
figure;
f_normalized = f / fs;
semilogx(f_normalized, 10*log10(psd));

ax = gca;
ax.YLim = [-140 10];
ax.XLim = [1e-5 1e0];
grid on;

title('Spectrum CIFB 1st order (Simulation)');
xlabel('Normalized Frequency (f/fs)');
ylabel('Power/Frequency (dB/Hz)');
xlabel('Normalized Frequency (f/fs)');
ylabel('Power/Frequency (dB/Hz)');

