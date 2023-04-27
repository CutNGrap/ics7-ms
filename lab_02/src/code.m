f = fopen('file.txt','r');
X = fscanf(f,'%f,');
Z = sort(X);
fclose(f);
N = length(X);

Mu = mean(X);
S = var(X);

gamma = input('Введите значение уровня доверия:');
n = input('Введите значение объема выборки:');
X = X(1:n);
alpha = (1 - gamma)/2;

m1 = zeros(1, n);
m2 = zeros(1, n);
s1 = zeros(1, n);
s2 = zeros(1, n);
Mu_sp = zeros(1,n);
S_sp = zeros(1,n);
s_sp = zeros(1,n);

mu_sp = zeros(1,n);
for i = 1:n
    mu = mean(X(1:i));
    s = var(X(1:i));
    Mu_sp(i) = Mu;
    mu_sp(i) = mu;
    S_sp(i) = S;
    s_sp(i) = s;
    
    m1(i) = mu - sqrt(s)/sqrt(i)*tinv(1-alpha,i-1);
    m2(i) = mu + sqrt(s)/sqrt(i)*tinv(1-alpha,i-1);
    s1(i) = s * (i-1) / chi2inv(1-alpha,i-1);
    s2(i) = s * (i-1) / chi2inv(alpha,i-1);
end

figure('Name', 'Graph 1');
plot([10:n], Mu_sp(10:n), 'm');
hold on;
plot([10:n], mu_sp(10:n), 'g');
hold on;
plot([10:n], m1(10:n), 'r'), grid;
hold on;
plot([10:n], m2(10:n), 'b'), legend('y=mu', 'y=mu_n', 'y=mu-low_n', 'y=mu-high_n');

figure('Name', 'Graph 2');
plot([10:n], S_sp(10:n), 'm');
hold on;
plot([10:n], s_sp(10:n), 'g');
hold on;
plot([10:n], s1(10:n), 'r'), grid;
hold on;
plot([10:n], s2(10:n), 'b'), legend('z=S^2', 'z=S^2_n', 'z=S^2-low_n', 'z=S^2-high_n');