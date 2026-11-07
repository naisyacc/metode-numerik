clc; clear; close all;

%% ===== DATA SOAL =====
% dy/dx = (4x^3 - 2x + 1)/(2 + y), y(0) = 1, cari y(2), n = 15
f      = @(x,y) (4*x.^3 - 2*x + 1) ./ (2 + y);
yeksak = @(x) -2 + sqrt(2*(x.^4 - x.^2 + x) + 9);   % solusi analitik

x0 = 0;  y0 = 1;  xn = 2;  n = 15;
h  = (xn - x0)/n;
y_eksak = yeksak(xn);

fprintf('h = %.6f\n', h);
fprintf('y(2) eksak = %.6f\n\n', y_eksak);

%% ===== METODE EULER =====
yE = zeros(1,n+1);  yE(1) = y0;
fprintf('===== METODE EULER =====\n');
fprintf('%-5s %-10s %-10s %-12s %-10s\n','i','xi','yi','f(xi,yi)','yi+1');
for i = 0:n-1
  x  = x0 + i*h;
  y  = yE(i+1);
  fi = f(x,y);
  yE(i+2) = y + h*fi;
  fprintf('%-5d %-10.6f %-10.6f %-12.6f %-10.6f\n', i, x, y, fi, yE(i+2));
end
y_euler = yE(end);

%% ===== METODE HEUN (RK-2) =====
yH = zeros(1,n+1);  yH(1) = y0;
fprintf('\n===== METODE HEUN (RK-2) =====\n');
fprintf('%-5s %-10s %-10s %-10s %-10s %-10s\n','i','xi','yi','k1','k2','yi+1');
for i = 0:n-1
  x  = x0 + i*h;
  y  = yH(i+1);
  k1 = f(x,y);
  k2 = f(x+h, y+h*k1);
  yH(i+2) = y + (h/2)*(k1+k2);
  fprintf('%-5d %-10.6f %-10.6f %-10.6f %-10.6f %-10.6f\n', i, x, y, k1, k2, yH(i+2));
end
y_heun = yH(end);

%% ===== METODE RUNGE-KUTTA ORDE-4 =====
yR = zeros(1,n+1);  yR(1) = y0;
fprintf('\n===== METODE RUNGE-KUTTA ORDE-4 =====\n');
fprintf('%-5s %-10s %-10s %-10s %-10s %-10s %-10s %-10s\n', ...
        'i','xi','yi','k1','k2','k3','k4','yi+1');
for i = 0:n-1
  x  = x0 + i*h;
  y  = yR(i+1);
  k1 = f(x,y);
  k2 = f(x+h/2, y+h*k1/2);
  k3 = f(x+h/2, y+h*k2/2);
  k4 = f(x+h,   y+h*k3);
  yR(i+2) = y + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
  fprintf('%-5d %-10.6f %-10.6f %-10.6f %-10.6f %-10.6f %-10.6f %-10.6f\n', ...
          i, x, y, k1, k2, k3, k4, yR(i+2));
end
y_rk4 = yR(end);

%% ===== GALAT DAN PERBANDINGAN =====
hasil   = [y_euler y_heun y_rk4];
gal_abs = abs(y_eksak - hasil);
gal_rel = gal_abs ./ abs(y_eksak) * 100;
nama    = {'Euler','Heun','RK4'};

fprintf('\n===== PERBANDINGAN DAN GALAT (y(2)) =====\n');
fprintf('%-12s %-12s %-14s %-14s\n','Metode','y(2)','Galat Absolut','Galat Relatif (%%)');
fprintf('%-12s %-12.6f %-14s %-14s\n','Eksak',y_eksak,'-','-');
for j = 1:3
  fprintf('%-12s %-12.6f %-14.6f %-14.6f\n', nama{j}, hasil(j), gal_abs(j), gal_rel(j));
end

%% ===== GRAFIK PERBANDINGAN =====
xs = x0 + (0:n)*h;
xx = linspace(x0, xn, 200);
figure;
plot(xx, yeksak(xx), 'k-', 'LineWidth', 1.5); hold on;
plot(xs, yE, 'o--');
plot(xs, yH, 's--');
plot(xs, yR, '^--');
xlabel('x'); ylabel('y'); grid on;
legend('Eksak','Euler','Heun','RK4','Location','northwest');
title('Perbandingan Solusi Eksak dan Pendekatan (n = 15)');
