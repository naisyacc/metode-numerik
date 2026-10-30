clc;
clear;
close all;

%% 1. INPUT DAN PEMBENTUKAN FUNGSI

% Volume bola diketahui sebesar 300 cm^3.
% Penulisan cm^2 pada soal dianggap sebagai salah ketik satuan.
volumeBolaDiketahui = 300;

% Persamaan nonlinear:
% (4/3) * pi * r^3 = 300
% f(r) = (4/3) * pi * r^3 - 300
f = @(r) (4/3) * pi .* r.^3 - volumeBolaDiketahui;

fprintf('KASUS 3: PENCARIAN AKAR DENGAN BISEKSI\n\n');

%% 2. GRAFIK UNTUK MENENTUKAN INTERVAL AWAL

rGrafik = linspace(0, 6, 601);

figure;

plot(rGrafik, f(rGrafik), 'b-', 'LineWidth', 1.5);
hold on;

plot(rGrafik, zeros(size(rGrafik)), ...
    'k--', 'LineWidth', 1);

xlabel('Jari-jari r (cm)');
ylabel('f(r)');

title('Penentuan Interval Akar Persamaan Volume Bola');

legend('f(r) = (4/3) pi r^3 - 300', 'f(r) = 0', ...
    'Location', 'northeast');

grid on;

%% 3. PENENTUAN DAN PEMERIKSAAN INTERVAL AWAL

% Berdasarkan grafik, akar berada di antara 4 dan 5 cm.
a = 4;
b = 5;

fa = f(a);
fb = f(b);

fprintf('Interval awal = [%.2f, %.2f]\n', a, b);
fprintf('f(a) = %.10f\n', fa);
fprintf('f(b) = %.10f\n', fb);

if fa * fb >= 0
    error('Interval awal harus memiliki perubahan tanda.');
end

fprintf('Interval awal memenuhi syarat perubahan tanda.\n');

%% 4. PENGATURAN ITERASI

% Toleransi ini digunakan untuk batas galat jari-jari,
% bukan untuk residual persamaan.
toleransi = 1e-8;

maksIterasi = 1000;

% Kolom riwayat:
% 1 = nomor iterasi
% 2 = batas bawah a
% 3 = batas atas b
% 4 = titik tengah c
% 5 = nilai f(c)
% 6 = batas galat jari-jari
riwayat = zeros(maksIterasi, 6);

konvergen = false;

%% 5. PROSES ITERASI BISEKSI

for k = 1:maksIterasi

    % Menghitung titik tengah interval
    c = (a + b) / 2;

    % Menghitung nilai fungsi pada titik tengah
    fc = f(c);

    % Batas galat posisi titik tengah
    batasGalat = (b - a) / 2;

    % Menyimpan hasil iterasi
    riwayat(k, :) = ...
        [k, a, b, c, fc, batasGalat];

    % Memeriksa kriteria penghentian
    if batasGalat < toleransi || fc == 0
        konvergen = true;
        break;
    end

    % Memilih separuh interval yang memiliki perubahan tanda
    if fa * fc < 0
        b = c;
        fb = fc;
    else
        a = c;
        fa = fc;
    end
end

if ~konvergen
    error('Biseksi belum mencapai toleransi sampai batas iterasi.');
end

%% 6. MENAMPILKAN RIWAYAT ITERASI

% Hanya mengambil baris yang digunakan
riwayat = riwayat(1:k, :);

fprintf('\nRIWAYAT ITERASI BISEKSI\n\n');

fprintf('%4s %15s %15s %15s %16s %16s\n', ...
    'Iter', 'a', 'b', 'c', 'f(c)', 'Batas galat');

for j = 1:k
    fprintf('%4d %15.10f %15.10f %15.10f %16.6e %16.6e\n', ...
        riwayat(j, 1), ...
        riwayat(j, 2), ...
        riwayat(j, 3), ...
        riwayat(j, 4), ...
        riwayat(j, 5), ...
        riwayat(j, 6));
end

%% 7. PERHITUNGAN JARI-JARI, TINGGI, DAN VOLUME

% Hasil pendekatan jari-jari
r = c;

% Bola tepat berada di dalam tabung:
% jari-jari tabung = jari-jari bola
% tinggi tabung = diameter bola
tinggiTabung = 2 * r;

volumeBola = (4/3) * pi * r^3;

volumeTabung = pi * r^2 * tinggiTabung;

volumeLuarBola = volumeTabung - volumeBola;

%% 8. MENAMPILKAN HASIL AKHIR

fprintf('\nHASIL AKHIR\n\n');

fprintf('Jari-jari bola = %.10f cm\n', r);
fprintf('Jari-jari tabung = %.10f cm\n', r);

fprintf('Tinggi tabung = %.10f cm\n', tinggiTabung);

fprintf('\nVolume bola = %.10f cm^3\n', volumeBola);

fprintf('Volume tabung = %.10f cm^3\n', volumeTabung);

fprintf('Volume tabung di luar bola = %.10f cm^3\n', ...
    volumeLuarBola);

fprintf('\nJumlah iterasi = %d\n', k);

fprintf('Batas galat jari-jari = %.12e cm\n', ...
    batasGalat);

fprintf('Residual persamaan = %.12e\n', abs(f(r)));

%% 9. VALIDASI MENGGUNAKAN PERBANDINGAN VOLUME

% V_tabung = (3/2) * V_bola
% V_luar = (1/2) * V_bola
volumeTabungPembanding = (3/2) * volumeBolaDiketahui;

volumeLuarPembanding = (1/2) * volumeBolaDiketahui;

fprintf('\nVALIDASI HASIL\n\n');

fprintf('Volume tabung berdasarkan perbandingan = %.2f cm^3\n', ...
    volumeTabungPembanding);

fprintf('Volume luar berdasarkan perbandingan = %.2f cm^3\n', ...
    volumeLuarPembanding);

fprintf('Selisih volume tabung = %.12e cm^3\n', ...
    abs(volumeTabung - volumeTabungPembanding));

fprintf('Selisih volume luar = %.12e cm^3\n', ...
    abs(volumeLuarBola - volumeLuarPembanding));
