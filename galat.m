
%% Galat e^0.3 menggunakan Deret Taylor, n = {0,1,2,3,4}
x = 0.3;
eksak1 = exp(x);

for n = 0:4
    p = 0;
    for i = 0:n
        p = p + (x^i)/factorial(i);
    end
    galat = abs(eksak1 - p);
    fprintf('n = %d\n', n);
    fprintf('Pendekatan\t= %.10f\n', p);
    fprintf('Eksak\t\t= %.10f\n', eksak1);
    fprintf('Error\t\t= %.10f\n\n', galat);
end



%% Galat 1/1 + 1/2 + ... + 1/20

% a. Perhitungan secara eksak
eksak2 = sum(1./(1:20))

% b. Masing-masing pembagian dibulatkan (4 desimal)
total = 0;
for k = 1:20
    nilai = round((1/k)*10000)/10000;
    total = total + nilai;
end
pendekatan_bulat = total
galat_b = abs(eksak2 - pendekatan_bulat)

% c. Tanpa looping (fungsi sum)
pendekatan_sum = sum(1./(1:20))
galat_c = abs(eksak2 - pendekatan_sum)



%% Galat sin(x) menggunakan Deret Taylor, N = {1,2,3,4,5}, x = 1
x = 1;
eksak3 = sin(x);

for N = 1:5
    p = 0;
    for n = 0:N
        p = p + ((-1)^n) * (x^(2*n+1))/factorial(2*n+1);
    end
    galat = abs(eksak3 - p);
    fprintf('N = %d\n', N);
    fprintf('Pendekatan\t= %.10f\n', p);
    fprintf('Eksak\t\t= %.10f\n', eksak3);
    fprintf('Error\t\t= %.10f\n\n', galat);
end
