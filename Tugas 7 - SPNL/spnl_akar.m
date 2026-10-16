clc; clear;
n = 20;
tol = 10^-4;

%% ===== PERSAMAAN 1: 3x^3 - 5x^2 + 4x - 8 = 0, interval [1,2] =====
f1 = @(x) 3*x.^3 - 5*x.^2 + 4*x - 8;
disp('===== PERSAMAAN 1 - BISEKSI =====')
c1_bis = Biseksi(f1,1,2,n,tol)
disp('===== PERSAMAAN 1 - REGULA FALSI =====')
c1_rf = RegulaFalsi(f1,1,2,n,tol)

%% ===== PERSAMAAN 2: e^x - x^2 = 0, interval [-1,0] =====
f2 = @(x) exp(x) - x.^2;
disp('===== PERSAMAAN 2 - BISEKSI =====')
c2_bis = Biseksi(f2,-1,0,n,tol)
disp('===== PERSAMAAN 2 - REGULA FALSI =====')
c2_rf = RegulaFalsi(f2,-1,0,n,tol)

%% ===== PERSAMAAN 3: log(x+2) + 2x - 3 = 0, interval [0,1] =====
f3 = @(x) log(x+2) + 2*x - 3;
disp('===== PERSAMAAN 3 - BISEKSI =====')
c3_bis = Biseksi(f3,0,1,n,tol)
disp('===== PERSAMAAN 3 - REGULA FALSI =====')
c3_rf = RegulaFalsi(f3,0,1,n,tol)

%% ===== RINGKASAN f(c) =====
fprintf('\n=== RINGKASAN f(c) ===\n');
fprintf('Persamaan 1 | Biseksi: %.4f (f=%.6f) | Regula-Falsi: %.4f (f=%.6f)\n', c1_bis, f1(c1_bis), c1_rf, f1(c1_rf));
fprintf('Persamaan 2 | Biseksi: %.4f (f=%.6f) | Regula-Falsi: %.4f (f=%.6f)\n', c2_bis, f2(c2_bis), c2_rf, f2(c2_rf));
fprintf('Persamaan 3 | Biseksi: %.4f (f=%.6f) | Regula-Falsi: %.4f (f=%.6f)\n', c3_bis, f3(c3_bis), c3_rf, f3(c3_rf));
