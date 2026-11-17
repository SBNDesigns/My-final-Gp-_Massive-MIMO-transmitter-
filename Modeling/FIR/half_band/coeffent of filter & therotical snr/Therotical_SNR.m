tone_freq= 100e3;  % tone frequency
Fs_in = 3.125e6; 
L = 2;
Fs1 = Fs_in * L;
Astop1 = 60;
Fpass1 = 1.2e6;
Fstop1 = Fs1/2 - Fpass1;
TW1    = Fstop1 - Fpass1;
spec_obj1 = fdesign.halfband('TW,Ast', TW1, Astop1, Fs1);
fir_obj1 = design(spec_obj1, 'equiripple');

h1 = fir_obj1.Numerator;
N1 = length(h1) - 1;

% input_signal
num_samples_in = 2^16;
t_in = (0:num_samples_in-1)' / Fs_in;
s_in = sin(2*pi*tone_freq*t_in);

 %actual out from the block
group_delay_samples = N1 / 2;
num_samples_out = 2^16 * L;
t_out = (0:num_samples_out-1)' / Fs1;

% convert the samples into delay in seconds
delay = group_delay_samples / Fs_in;

% ideal out
s_ideal_out = sin(2*pi*tone_freq*(t_out - delay));

% actual out
interp1 = dsp.FIRInterpolator(L, h1);
s_actual_out = interp1(s_in);


% neglect first samples & last samples due to transients
start_id = round(num_samples_out / 2);
end_id   = num_samples_out;

actual_stable = s_actual_out(start_id:end_id);

%calculation snr in time domain

SINAD = sinad(actual_stable, Fs1);

% calculation of ENOB
ENOB = (SINAD - 1.76) / 6.02;

fprintf('SINAD : %.2f dB\n', SINAD);
fprintf('ENOB: %.2f bits\n', ENOB);

