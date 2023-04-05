f = fopen('file.txt','r');
% f = fopen('test.txt','r');
X = fscanf(f,'%f,');
Z = sort(X);
fclose(f);
n = length(X);

% a
M_min = min(X);
M_max = max(X);
fprintf('Mmin = %f\n', M_min);
fprintf('Mmax = %f\n', M_max);

% б
R = M_max - M_min;
fprintf('Range = %f\n', R);

% в
MX = mean(X);
DX = sum((X - MX).^2) /(n - 1);
fprintf('Mu = %f\n', MX);
fprintf('S2 = %f\n', DX);

% г
m = floor(log2(n))+ 2;
h = R / m;
intervals = cell(1, m);
i = 1;
for cur = (M_min):h:(M_max-h)
    next = cur + h;
    intervals(i) = {X((cur <= X) & (X < next))};
    i = i + 1;
end
intervals{m} = [intervals{m}; X(X == M_max)];
fprintf('m = %d, h = %f\n', m, h);


% д
figure('Name', 'Задание Д');
histogram(X, m, 'BinEdges', M_min:h:M_max, 'Normalization', 'pdf');
hold on;
x = (M_min - h):0.1:(M_max+h);
% f = exp(-(x-MX).^2./(2*DX))./(sqrt(DX * 2 * pi));
Xn = (M_min - h): 0.1 :(M_max + h);
y = pdf('normal', Xn, MX, DX);
plot(Xn,y), grid;

% е
figure('Name', 'Задание Г');
[yy, xx] = ecdf(X);
stairs(xx, yy,'LineWidth',1.5);
hold on;
Y = normcdf((Xn - MX) / DX);
plot(Xn, Y, 'r'), grid;
