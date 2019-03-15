%% Solution Template
% Circle
r = 2;
areaCircle = pi*r^2;
circumferenceCircle = 2*pi*r;

% Right triangle 
a = 3;
b = 4;
c = 5;
areaTriangle = (1/2)*a*b;
circumferenceTriangle = a+b+c;

% Rectangle
x = 6;
y = 7;
areaRectangle = x*y;
circumferenceRectangle = (2*x)+(2*y);

% Trapezoid
b = 4;
n = 10;
m = 2;
areaTrapezoid = ((a+b)/2)*m;

%A kangaroo is capable of jumping to a height of 2.62 m. Determine the takeoff speed of the kangaroo.
ay = -9.8;
s = 2.62;
%vf = vi^2 + 2*a*d;
ad = 2*a*s;
vi = sqrt(-(ad));
