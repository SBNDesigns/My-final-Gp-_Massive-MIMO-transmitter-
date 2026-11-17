Fs1 = 6.25e6;
Fpass1 = 1.2e6;
Astop1 = 50;

% حساب transition width
Fc = Fs1 / 4;
TW1 = 2 * (Fc - Fpass1);

% تصميم halfband الصحيح
spec_obj_orig = fdesign.halfband('TW,Ast', TW1, Astop1, Fs1);
fir_obj_orig = design(spec_obj_orig, 'equiripple');

% القياسات
measurements = measure(fir_obj_orig);

Apass_actual_dB = measurements.Apass;

fprintf('--- قياس التصميم الأصلي ---\n');
fprintf('قيمة Apass الفعلية التي نتجت هي: %.5f dB\n', Apass_actual_dB);
