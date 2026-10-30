clc;
clear;
close all;

%% INPUT

% Urutan kolom:
% 1 = beras
% 2 = telur
% 3 = tepung
% 4 = ayam
%
% Semua massa sudah dalam kilogram.

A = [
    2.5  1.5   5.0  0.5;
    4.0  0.75  1.0  2.0;
    2.0  1.5   0.5  6.0;
    1.0  4.25  2.0  0.9
];

b = [
    161000;
    149000;
    251500;
    173000
];

fprintf('KASUS 2: SISTEM PERSAMAAN LINEAR\n\n');

%% ANALISIS MATRIKS AWAL

D0 = diag(diag(A));
L0 = tril(A, -1);
U0 = triu(A, 1);

T0 = -((D0 + L0) \ U0);

rhoAwal = max(abs(eig(T0)));

fprintf('Radius spektral urutan awal = %.10f\n', ...
    rhoAwal);

%% PENATAAN ULANG PERSAMAAN

% Urutan baru:
% Briza, Dinda, Adel, Caca.

urutan = [2 4 1 3];

Ags = A(urutan, :);
bgs = b(urutan);

fprintf('\nMatriks setelah penataan ulang:\n');
disp(Ags);

fprintf('Ruas kanan setelah penataan ulang:\n');
disp(bgs);

%% PEMERIKSAAN DOMINANSI DIAGONAL

nilaiDiagonal = abs(diag(Ags));

jumlahLuarDiagonal = ...
    sum(abs(Ags), 2) - nilaiDiagonal;

dominanKetat = nilaiDiagonal > jumlahLuarDiagonal;

fprintf('\nPemeriksaan dominansi diagonal:\n\n');

fprintf('%6s %14s %22s %18s\n', ...
    'Baris', 'Diagonal', 'Jumlah luar diagonal', 'Dominan ketat');

for i = 1:4
    if dominanKetat(i)
        status = 'Ya';
    else
        status = 'Tidak';
    end

    fprintf('%6d %14.4f %22.4f %18s\n', ...
        i, nilaiDiagonal(i), jumlahLuarDiagonal(i), status);
end

%% PEMERIKSAAN RADIUS SPEKTRAL SUSUNAN BARU

D = diag(diag(Ags));
L = tril(Ags, -1);
U = triu(Ags, 1);

T = -((D + L) \ U);

rhoBaru = max(abs(eig(T)));

fprintf('\nRadius spektral setelah penataan = %.10f\n', ...
    rhoBaru);

if rhoBaru >= 1
    error('Susunan matriks belum menjamin konvergensi.');
end

fprintf('Susunan baru memenuhi kriteria konvergensi.\n');

%% PENGATURAN ITERASI

harga = zeros(4, 1);

toleransi = 1e-8;
maksIterasi = 1000;

riwayat = zeros(maksIterasi, 7);

konvergen = false;

%% PROSES GAUSS-SEIDEL

for k = 1:maksIterasi
    hargaLama = harga;

    for i = 1:4
        % Menggunakan nilai yang telah diperbarui
        jumlahBaru = ...
            Ags(i, 1:i-1) * harga(1:i-1);

        % Menggunakan nilai dari iterasi sebelumnya
        jumlahLama = ...
            Ags(i, i+1:4) * hargaLama(i+1:4);

        harga(i) = ...
            (bgs(i) - jumlahBaru - jumlahLama) / Ags(i, i);
    end

    perubahan = norm(harga - hargaLama, inf);

    residual = norm(A * harga - b, inf);

    riwayat(k, :) = ...
        [k, harga', perubahan, residual];

    if perubahan < toleransi
        konvergen = true;
        break;
    end
end

if ~konvergen
    error('Iterasi belum konvergen sampai batas maksimum.');
end

riwayat = riwayat(1:k, :);

%% OUTPUT RIWAYAT ITERASI

fprintf('\nRIWAYAT ITERASI\n\n');

fprintf('%4s %14s %14s %14s %14s %14s %14s\n', ...
    'Iter', 'Beras', 'Telur', 'Tepung', 'Ayam', ...
    'Perubahan', 'Residual');

for j = 1:k
    fprintf('%4d %14.6f %14.6f %14.6f %14.6f %14.4e %14.4e\n', ...
        riwayat(j, 1), ...
        riwayat(j, 2), ...
        riwayat(j, 3), ...
        riwayat(j, 4), ...
        riwayat(j, 5), ...
        riwayat(j, 6), ...
        riwayat(j, 7));
end

%% OUTPUT HASIL AKHIR

fprintf('\nHASIL AKHIR\n\n');

fprintf('Beras  = Rp %.2f per kg\n', harga(1));
fprintf('Telur  = Rp %.2f per kg\n', harga(2));
fprintf('Tepung = Rp %.2f per kg\n', harga(3));
fprintf('Ayam   = Rp %.2f per kg\n', harga(4));

fprintf('\nJumlah iterasi = %d\n', k);

fprintf('Perubahan terakhir = %.12e\n', perubahan);

fprintf('Residual maksimum = %.12e\n', ...
    norm(A * harga - b, inf));

%% VALIDASI TOTAL BELANJA

namaPembeli = {'Adel', 'Briza', 'Caca', 'Dinda'};

totalHitung = A * harga;

selisih = totalHitung - b;

fprintf('\nVALIDASI TOTAL BELANJA\n\n');

fprintf('%10s %20s %20s %16s\n', ...
    'Pembeli', 'Total perhitungan', 'Total soal', 'Selisih');

for i = 1:4
    fprintf('%10s %20.2f %20.2f %16.6e\n', ...
        namaPembeli{i}, totalHitung(i), b(i), selisih(i));
end
