%% ================= METODE A: ELIMINASI GAUSS =================
A = [2 1 -1; 4 3 1; -2 1 2];
b = [3; 9; 4];

Ab = [A b];   % matriks augmented [A|b]
[n, ~] = size(A);

% Forward Elimination
for i = 1:n-1
    for j = i+1:n
        m = Ab(j,i)/Ab(i,i);
        Ab(j,:) = Ab(j,:) - m*Ab(i,:);
    end
end

disp('Matriks segitiga atas [A|b] setelah forward elimination:')
disp(Ab)

% Backward Substitution
x = zeros(n,1);
x(n) = Ab(n,n+1)/Ab(n,n);
for i = n-1:-1:1
    x(i) = (Ab(i,n+1) - Ab(i,i+1:n)*x(i+1:n)) / Ab(i,i);
end

disp('Solusi x dengan Eliminasi Gauss:')
disp(x)


%% ================= METODE B: ELIMINASI GAUSS-JORDAN =================
A = [2 1 -1; 4 3 1; -2 1 2];
b = [3; 9; 4];

Ab = [A b];
[n, ~] = size(A);

% Forward Elimination (sama seperti Gauss biasa)
for i = 1:n-1
    for j = i+1:n
        m = Ab(j,i)/Ab(i,i);
        Ab(j,:) = Ab(j,:) - m*Ab(i,:);
    end
end

% Backward Elimination sampai bentuk diagonal
for i = n:-1:2
    for j = i-1:-1:1
        m = Ab(j,i)/Ab(i,i);
        Ab(j,:) = Ab(j,:) - m*Ab(i,:);
    end
end

% Normalisasi diagonal menjadi 1
for i = 1:n
    Ab(i,:) = Ab(i,:)/Ab(i,i);
end

disp('Matriks [A|b] setelah Gauss-Jordan (bentuk identitas):')
disp(Ab)

x_gj = Ab(:,n+1);
disp('Solusi x dengan Eliminasi Gauss-Jordan:')
disp(x_gj)


%% ================= METODE C: DEKOMPOSISI LU =================
A = [2 1 -1; 4 3 1; -2 1 2];
b = [3; 9; 4];

[n, ~] = size(A);
L = eye(n);
U = A;

% Forward elimination sambil menyimpan pengali ke L
for i = 1:n-1
    for j = i+1:n
        m = U(j,i)/U(i,i);
        L(j,i) = m;
        U(j,:) = U(j,:) - m*U(i,:);
    end
end

disp('Matriks L:')
disp(L)
disp('Matriks U:')
disp(U)
disp('Cek L*U (harus sama dengan A):')
disp(L*U)

% Forward substitution: Ly = b
y = zeros(n,1);
y(1) = b(1)/L(1,1);
for i = 2:n
    y(i) = (b(i) - L(i,1:i-1)*y(1:i-1)) / L(i,i);
end
disp('Solusi y dari Ly = b:')
disp(y)

% Backward substitution: Ux = y
x_lu = zeros(n,1);
x_lu(n) = y(n)/U(n,n);
for i = n-1:-1:1
    x_lu(i) = (y(i) - U(i,i+1:n)*x_lu(i+1:n)) / U(i,i);
end
disp('Solusi x dengan Dekomposisi LU:')
disp(x_lu)


%% ================= PERBANDINGAN HASIL =================
fprintf('\n=== Perbandingan hasil ketiga metode ===\n')
fprintf('Gauss        : x1=%.4f, x2=%.4f, x3=%.4f\n', x(1), x(2), x(3))
fprintf('Gauss-Jordan : x1=%.4f, x2=%.4f, x3=%.4f\n', x_gj(1), x_gj(2), x_gj(3))
fprintf('LU           : x1=%.4f, x2=%.4f, x3=%.4f\n', x_lu(1), x_lu(2), x_lu(3))
