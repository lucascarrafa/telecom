close all
Am = 1;
fm = 2e2;

Ac = 1;
fc = 10e3;

Fs = fc*20;

Ta = 1/Fs;

t = 0:Ta:10e-3;

kf = 2e3;
%% questao 1

x = Ac*cos(2*pi*fm*t);

%% questao 2
beta = (kf*Am)/fm;

delta = fm*beta;

%% questao 3

xfm = Ac*cos(2*pi*fc*t + beta*sin(2*pi*fm*t));
opt = (fc/Fs)*2*pi/(max(max(x)))

y = modulate(x,fc,Fs,'fm',opt);

%% questao 4
 plot(t,x);
hold all
plot(t,xfm);


%% questao 5

B = 2*(beta+1)*fm;

%% questao 6

f = GeraVetorFreq(Fs,length(t));
figure
plot(f,10*log10(abs(fftshift(fft(xfm)))));

%% questao 7

% medindo os picos da questao 6 , a diferença deu 200 e comparado com fm
% deu igual, incrivel isso

%% questao 8

% beta deu 4000 proximo de 4400
% observar no grafico

%% questao 9
beta_i = 0.01
kf_i = (beta_i*fm)/Am

xfm_i = Ac*cos(2*pi*fc*t + beta_i*sin(2*pi*fm*t));
y_i = modulate(x,fc,Fs,'am');
plot(f,10*log10(abs(fftshift(fft(xfm_i)))));
hold all
plot(f,10*log10(abs(fftshift(fft(y_i)))));

%% questao 10

% repetir tudo

%% questao 1 secao 3

beta_3 = 0 : 0.01 : 10;
J = zeros(6, length(beta_3));
BJ5 = zeros(1, beta + 1);
for i = 0 : 5
J(i + 1, :) = besselj(i, beta_3);
BJ5(i + 1) = besselj(i, 5);
end
figure, plot(beta_3, J)
hold all
plot(5, BJ5,'*');
grid; xlabel('indice de Modulacao - beta');
title('funcoes de Bessel de 1a Especie');

%% questao 2 secao 3

Pt = (1/2)*(Ac^2);

fprintf('Potência média: %.2f W\n',Pt);

%% questao 3 secao 3

Pfm = mean(xfm.^2); %eleva cada elemento do vetor e eleva ao quadrado, operação ponto a ponto

fprintf('Potência média xfm: %f W\n',Pfm);

%% questao 4 secao 3
Pbcarson = Pt*(BJ5(1)^2 + 2*sum(BJ5(2:end).^2));
razao_p = Pbcarson/Pfm;

fprintf('Percentagem de potência total do sinal FM: %.2f%%\n',razao_p*100);

%% questao 5 secao 3

beta = 5;
nmax = sum(abs(besselj(1 : 99, beta)) > 0.01);
for i = 0 : nmax
    BJN(i + 1) = besselj(i, 5);
end

P99 = Pt*(BJN(1)^2 + 2*sum(BJN(2:end).^2));
razao_p99 = P99/Pfm;

fprintf('Pelo critério dos 99. O numero de riscas é: %.2f%%\n',razao_p99*100);

%% questao 6 secao 3

beta = [0.1 0.3 0.5 1 2 5 10 20 30];
nmax2 = zeros(size(beta));
for j = 1 : length(beta)
    nmax2(j) = 2*sum(abs(besselj(1 : 99, beta(j))) > 0.01);
    fprintf('Para beta igual %.1f: %.1f\n',beta(j),nmax2(j));
end

%% questao 7 secao 3

beta = linspace(0.1, 30, 200);
nmax3 = zeros(size(beta));
for j = 1 : length(beta)
    nmax3(j) = 2 * sum(abs(besselj(1 : 99, beta(j))) > 0.01);
end
deltaf = beta * fm;
BCar = 2 * (beta + 1) * fm;
B99 = nmax3 * fm;
figure(5)
plot(beta, BCar./deltaf,'LineWidth',2,'DisplayName','banda Carson');
%legend('-Banda Carson');
hold all
plot(beta, B99./deltaf,'LineWidth',2,'DisplayName','banda 99');
legend('-Banda Carson','-Banda 99');
xlabel('Indice de Modulação(\beta)');
ylabel('BW/\Delta_f');
grid;


