clc;
clear;
close all;

%% INPUT

lambda = 12;
v = 36;
x = 10;
h0 = 5;

t = 0:0.01:5;
daftarN = [23 24 25];

% Definisi:
% n merupakan indeks akhir penjumlahan.
% Deret dihitung dari k = 0 sampai k = n.

%% FUNGSI ACUAN

z = (t .* v) ./ lambda;

hEksak = h0 .* (cos(z) + exp(x));

%% PENDEKATAN DAN PERHITUNGAN GALAT

jumlahMetode = length(daftarN);
jumlahTitik = length(t);

hPendekatan = zeros(jumlahMetode, jumlahTitik);

MAE = zeros(jumlahMetode, 1);
MAPE = zeros(jumlahMetode, 1);
galatRelatifMaks = zeros(jumlahMetode, 1);

for i = 1:jumlahMetode
    n = daftarN(i);

    jumlahCos = ones(size(z));
    sukuCos = ones(size(z));

    jumlahExp = 1;
    sukuExp = 1;

    for k = 1:n
        sukuCos = sukuCos .* (-z.^2) ...
            ./ ((2*k - 1) * (2*k));

        jumlahCos = jumlahCos + sukuCos;

        sukuExp = sukuExp * x / k;
        jumlahExp = jumlahExp + sukuExp;
    end

    hPendekatan(i, :) = h0 .* (jumlahCos + jumlahExp);

    galatMutlak = abs(hEksak - hPendekatan(i, :));

    galatRelatifPersen = ...
        (galatMutlak ./ abs(hEksak)) * 100;

    MAE(i) = mean(galatMutlak);
    MAPE(i) = mean(galatRelatifPersen);
    galatRelatifMaks(i) = max(galatRelatifPersen);
end

%% OUTPUT

fprintf('KASUS 1: GALAT PENDEKATAN MACLAURIN\n');
fprintf('Jumlah titik pengamatan = %d\n', jumlahTitik);
fprintf('Langkah waktu = 0.01\n');
fprintf('Penjumlahan deret dari k = 0 sampai k = n.\n\n');

fprintf('%5s %18s %18s %20s\n', ...
    'n', 'MAE', 'MAPE (%)', 'Maks. Relatif (%)');

for i = 1:jumlahMetode
    fprintf('%5d %18.9f %18.9f %20.9f\n', ...
        daftarN(i), MAE(i), MAPE(i), galatRelatifMaks(i));
end

fprintf('\nEvaluasi toleransi 1%%:\n');

for i = 1:jumlahMetode
    if galatRelatifMaks(i) <= 1
        fprintf(['n = %d memenuhi toleransi 1%% ', ...
            'pada seluruh titik sampel.\n'], daftarN(i));
    else
        fprintf('n = %d tidak memenuhi toleransi 1%%.\n', ...
            daftarN(i));
    end
end

%% GRAFIK PERBANDINGAN FUNGSI

figure;

plot(t, hEksak, 'k-', 'LineWidth', 1.8);
hold on;

plot(t, hPendekatan(1, :), 'r--', 'LineWidth', 1.2);
plot(t, hPendekatan(2, :), 'b-.', 'LineWidth', 1.2);
plot(t, hPendekatan(3, :), 'g:', 'LineWidth', 1.5);

xlabel('Waktu t');
ylabel('h(t)');

title('Perbandingan Fungsi Acuan dan Pendekatan Maclaurin');

legend('Acuan', 'n = 23', 'n = 24', 'n = 25', ...
    'Location', 'best');

grid on;

%% GRAFIK GALAT MUTLAK

figure;

plot(t, abs(hEksak - hPendekatan(1, :)), ...
    'r-', 'LineWidth', 1.2);

hold on;

plot(t, abs(hEksak - hPendekatan(2, :)), ...
    'b--', 'LineWidth', 1.2);

plot(t, abs(hEksak - hPendekatan(3, :)), ...
    'g-.', 'LineWidth', 1.2);

xlabel('Waktu t');
ylabel('Galat mutlak');

title('Galat Mutlak Pendekatan Maclaurin');

legend('n = 23', 'n = 24', 'n = 25', ...
    'Location', 'best');

grid on;
