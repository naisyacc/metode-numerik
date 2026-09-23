syms x
f = input('Masukkan bentuk persamaan f(x) = ');   % contoh input: cos(2*x) + 3*x.^2
f_asli = sym(f);
f_integral = int(f_asli, 'x')
