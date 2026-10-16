clc; clear; close all;

%% ===== PERSAMAAN 1: y = 3x^3 - 5x^2 + 4x - 7, dengan y = 1 =====
% Grafik tunggal: f(x) = 3x^3 - 5x^2 + 4x - 8 (angka 1 dipindah ke kiri)
x = linspace(0,3);
f1 = @(x) 3*x.^3 - 5*x.^2 + 4*x - 8;
figure(1)
plot(x,f1(x)); hold on
line([0,3],[0,0],'Color','k')        % sumbu X
line([0,0],[-10,40],'Color','k')     % sumbu Y
plot(1.77,0,'ro')
text(1.8,3,'Akar')
xlabel('x'); ylabel('y'); grid on
title('Grafik Tunggal: y = 3x^3-5x^2+4x-8')

% Grafik ganda: y1 = 3x^3 - 5x^2 dan y2 = -4x + 8
y1 = @(x) 3*x.^3 - 5*x.^2;
y2 = @(x) -4*x + 8;
figure(2)
plot(x,y1(x),x,y2(x)); hold on
line([0,3],[0,0],'Color','k')
line([0,0],[-10,40],'Color','k')
plot(1.77,y2(1.77),'ro')
text(1.85,y2(1.77)+3,'Akar')
xlabel('x'); ylabel('y'); grid on
legend('y_1 = 3x^3-5x^2','y_2 = -4x+8','location','northwest')
title('Grafik Ganda Persamaan 1')

%% ===== PERSAMAAN 2: y = e^x - x^2, dengan y = 0 =====
x = linspace(-2,2);
f2 = @(x) exp(x) - x.^2;
figure(3)
plot(x,f2(x)); hold on
line([-2,2],[0,0],'Color','k')
line([0,0],[-5,5],'Color','k')
plot(-0.70,0,'ro')
text(-0.65,0.6,'Akar')
xlabel('x'); ylabel('y'); grid on
title('Grafik Tunggal: y = e^x - x^2')

% Grafik ganda: y1 = e^x dan y2 = x^2
y1 = @(x) exp(x);
y2 = @(x) x.^2;
figure(4)
plot(x,y1(x),x,y2(x)); hold on
line([-2,2],[0,0],'Color','k')
line([0,0],[-1,8],'Color','k')
plot(-0.70,y2(-0.70),'ro')
text(-0.65,y2(-0.70)+0.8,'Akar')
xlabel('x'); ylabel('y'); grid on
legend('y_1 = e^x','y_2 = x^2','location','north')
title('Grafik Ganda Persamaan 2')

%% ===== PERSAMAAN 3: y = log(x+2) + 2x - 3, dengan y = 0 =====
x = linspace(-1.5,3);
f3 = @(x) log(x+2) + 2*x - 3;
figure(5)
plot(x,f3(x)); hold on
line([-1.5,3],[0,0],'Color','k')
line([0,0],[-8,6],'Color','k')
plot(0.96,0,'ro')
text(1.0,0.8,'Akar')
xlabel('x'); ylabel('y'); grid on
title('Grafik Tunggal: y = log(x+2)+2x-3')

% Grafik ganda: y1 = log(x+2) dan y2 = -2x + 3
y1 = @(x) log(x+2);
y2 = @(x) -2*x + 3;
figure(6)
plot(x,y1(x),x,y2(x)); hold on
line([-1.5,3],[0,0],'Color','k')
line([0,0],[-4,7],'Color','k')
plot(0.96,y2(0.96),'ro')
text(1.0,y2(0.96)+0.8,'Akar')
xlabel('x'); ylabel('y'); grid on
legend('y_1 = log(x+2)','y_2 = -2x+3','location','northeast')
title('Grafik Ganda Persamaan 3')
