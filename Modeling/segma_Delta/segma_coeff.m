% --- Step 1: Define Modulator Specifications ---
order =2;      % The order of the modulator (Third-Order)
osr = 32;       % The oversampling ratio
H_inf = 1.7;    % Maximum out-of-band gain (a standard, safe value for stability)
opt = 1;        % Optimize the NTF zero locations for best SNR (Chebyshev NTF)

% --- Step 2: Synthesize the Noise Transfer Function (NTF) ---
fprintf('Synthesizing the Noise Transfer Function (NTF)...\n');
H = synthesizeNTF(order, osr, opt, H_inf);

% --- Step 3: Realize the NTF for a CIFB Architecture ---
fprintf('Calculating coefficients for the CIFB architecture...\n');
[a, g, b, c] = realizeNTF(H, 'CIFB');

% --- Step 4: Display the Calculated Coefficients ---
fprintf('\n--- Calculated Coefficients (3rd-Order CIFB) ---\n');
fprintf('Use these values in the Gain blocks of your Simulink model:\n\n');

% Display feedback coefficients (a)
fprintf('Feedback Coefficients (a):\n');
for i = 1:length(a)
    fprintf('a%d = %f\n', i, a(i));
end

fprintf('\n');

% Display feed-in coefficients (b)
fprintf('Feed-in Coefficients (b):\n');
for i = 1:length(b)
    fprintf('b%d = %f\n', i, b(i));
end

fprintf('\n--- Calculation Complete ---\n');

% --- Optional: Plot the NTF poles and zeros to verify ---
figure;
plotPZ(H);
title('Poles and Zeros of the Synthesized NTF');
