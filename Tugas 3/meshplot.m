x = -5:0.5:5;
y = x;
[X,Y] = meshgrid(x,y);
R = sqrt(X.^2 + Y.^2);
Z = cos(R);
mesh(X,Y,Z);
