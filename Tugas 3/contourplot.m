x = -2:0.2:2;
y = -2:0.2:2;
[X,Y] = meshgrid(x,y);
Z = 2.^(-X.^2 - Y.^2);
contour3(X,Y,Z,15)
xlabel('x'); ylabel('y'); zlabel('z');
