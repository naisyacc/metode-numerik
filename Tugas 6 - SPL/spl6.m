clc; clear;

%% ============ DATA SISTEM PERSAMAAN LINEAR ============
% Urutan variabel: [p; q; r; s; t]
A = [ 5 -1 -1  0  0;
     -1  5 -1 -1  0;
     -1 -1  4 -1 -1;
      0  0  1  4 -2;
      0  1 -1  1  4];
b = [-1; 2; 6; 2; -1];
n = 5;
maxIter = 20;
tol = 0.001;

%% ============ METODE 1: ELIMINASI GAUSS ============
tic;
Ab = [A b];
for i = 1:n-1
    for j = i+1:n
        m = Ab(j,i)/Ab(i,i);
        Ab(j,:) = Ab(j,:) - m*Ab(i,:);
    end
end
x_gauss = zeros(n,1);
x_gauss(n) = Ab(n,n+1)/Ab(n,n);
for i = n-1:-1:1
    x_gauss(i) = (Ab(i,n+1) - Ab(i,i+1:n)*x_gauss(i+1:n)) / Ab(i,i);
end
t_gauss = toc;

%% ============ METODE 2: ELIMINASI GAUSS-JORDAN ============
tic;
Ab_gj = [A b];
for i = 1:n-1                       % forward elimination
    for j = i+1:n
        m = Ab_gj(j,i)/Ab_gj(i,i);
        Ab_gj(j,:) = Ab_gj(j,:) - m*Ab_gj(i,:);
    end
end
for i = n:-1:2                      % backward elimination
    for j = i-1:-1:1
        m = Ab_gj(j,i)/Ab_gj(i,i);
        Ab_gj(j,:) = Ab_gj(j,:) - m*Ab_gj(i,:);
    end
end
for i = 1:n                         % normalisasi diagonal
    Ab_gj(i,:) = Ab_gj(i,:)/Ab_gj(i,i);
end
x_gj = Ab_gj(:,n+1);
t_gj = toc;

%% ============ METODE 3: DEKOMPOSISI LU ============
tic;
L = eye(n);
U = A;
for i = 1:n-1
    for j = i+1:n
        m = U(j,i)/U(i,i);
        L(j,i) = m;
        U(j,:) = U(j,:) - m*U(i,:);
    end
end
y = zeros(n,1);                    % Ly = b
for i = 1:n
    y(i) = (b(i) - L(i,1:i-1)*y(1:i-1)) / L(i,i);
end
x_lu = zeros(n,1);                 % Ux = y
for i = n:-1:1
    x_lu(i) = (y(i) - U(i,i+1:n)*x_lu(i+1:n)) / U(i,i);
end
t_lu = toc;

%% ============ METODE 4: JACOBI ============
tic;
x = zeros(n,1);
iter_jacobi = 0;
for k = 1:maxIter
    x_baru = zeros(n,1);
    for i = 1:n
        jumlah = A(i,:)*x - A(i,i)*x(i);
        x_baru(i) = (b(i) - jumlah)/A(i,i);
    end
    galat_iter = max(abs(x_baru - x));
    x = x_baru;
    iter_jacobi = k;
    if galat_iter < tol
        break
    end
end
x_jacobi = x;
t_jacobi = toc;

%% ============ METODE 5: GAUSS-SEIDEL ============
tic;
x = zeros(n,1);
iter_seidel = 0;
for k = 1:maxIter
    x_lama = x;
    for i = 1:n
        jumlah = A(i,:)*x - A(i,i)*x(i);
        x(i) = (b(i) - jumlah)/A(i,i);
    end
    galat_iter = max(abs(x - x_lama));
    iter_seidel = k;
    if galat_iter < tol
        break
    end
end
x_seidel = x;
t_seidel = toc;

%% ============ DISPLAY HASIL (DILUAR PEMBACAAN TIC TOC) ============
disp('Matriks segitiga atas [A|b] (Gauss):'); disp(Ab);
disp('Matriks [A|b] setelah Gauss-Jordan:'); disp(Ab_gj);
disp('Matriks L:'); disp(L);
disp('Matriks U:'); disp(U);

fprintf('\n=== SOLUSI [p q r s t] ===\n');
fprintf('Gauss        : %10.6f %10.6f %10.6f %10.6f %10.6f\n', x_gauss');
fprintf('Gauss-Jordan : %10.6f %10.6f %10.6f %10.6f %10.6f\n', x_gj');
fprintf('LU           : %10.6f %10.6f %10.6f %10.6f %10.6f\n', x_lu');
fprintf('Jacobi       : %10.6f %10.6f %10.6f %10.6f %10.6f  (iterasi = %d)\n', x_jacobi', iter_jacobi);
fprintf('Gauss-Seidel : %10.6f %10.6f %10.6f %10.6f %10.6f  (iterasi = %d)\n', x_seidel', iter_seidel);

%% ============ SOAL 2: GALAT ABSTRAK |eksak - hampiran| ============
eksak = x_gauss;
galat_jacobi = abs(eksak - x_jacobi);
galat_seidel = abs(eksak - x_seidel);
fprintf('\n=== GALAT ABSTRAK [p q r s t] ===\n');
fprintf('Jacobi       : %.6f %.6f %.6f %.6f %.6f\n', galat_jacobi');
fprintf('Gauss-Seidel : %.6f %.6f %.6f %.6f %.6f\n', galat_seidel');

%% ============ SOAL 3: RUNNING TIME ============
fprintf('\n=== RUNNING TIME (detik) ===\n');
fprintf('Gauss        : %.8f\n', t_gauss);
fprintf('Gauss-Jordan : %.8f\n', t_gj);
fprintf('LU           : %.8f\n', t_lu);
fprintf('Jacobi       : %.8f\n', t_jacobi);
fprintf('Gauss-Seidel : %.8f\n', t_seidel);
