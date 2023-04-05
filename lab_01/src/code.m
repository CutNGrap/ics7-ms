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

% á
R = M_max - M_min;
fprintf('Range = %f\n', R);

% â
MX = mean(X);
DX = sum((X - MX).^2) /(n - 1);
fprintf('Mu = %f\n', MX);
fprintf('S2 = %f\n', DX);

% ã
m = floor(log2(n))+ 2;
h = R / m;
intervals = cell(1, m);
i = 1;
fprintf('m = %d, h = %f\n', m, h);
bracket = ') ';
format short;
for cur = (M_min):h:(M_max-h)
    next = cur + h;
    intervals(i) = {X((cur <= X) & (X < next))};
    fprintf('[%5.2f, %5.2f%s', cur, next,bracket);
    i = i + 1;
    if i == m
        bracket = ']';
    end
end
intervals{m} = [intervals{m}; X(X == M_max)];
intervals(1);
cellsz = cellfun(@size,intervals,'uni',false);
cellsz{5}(1);

fprintf('\n');
s = size(cellsz);
for i = 1:s(2)
    fprintf('%8d       ', cellsz{i}(1));
end
fprintf('\n');
% ä
figure('Name', 'Graph 1');
histogram(X, m, 'BinEdges', M_min:h:M_max, 'Normalization', 'pdf');
hold on;
x = (M_min - h):0.1:(M_max+h);
% f = exp(-(x-MX).^2./(2*DX))./(sqrt(DX * 2 * pi));
Xn = (M_min - h): 0.1 :(M_max + h);
y = pdf('normal', Xn, MX, DX);
plot(Xn,y), grid;

% å
figure('Name', 'Graph 2');
[yy, xx] = ecdf(X);
stairs(xx, yy,'LineWidth',1.5);
hold on;
Y = normcdf((Xn - MX) / DX);
plot(Xn, Y, 'r'), grid;