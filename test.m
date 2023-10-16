close all
clear all
%1)
n=0:1/100:2*pi;
v=cos(n)+i*sin(n);
Z1=0.99*exp(0.2*pi*i);
Z2=0.99*exp(-0.2*pi*i);
Z3=0.99*exp(0.4*pi*i);
Z4=0.99*exp(-0.4*pi*i);
figure
plot(v,'b')
hold on 
grid on
plot(Z1,'--rs','linewidth',1,'markersize',5,'markerfacecolor','g','markeredgecolor','k');
hold on
plot(Z2,'--rs','linewidth',1,'markersize',5,'markerfacecolor','g','markeredgecolor','k');
hold on
plot(Z3,'--rs','linewidth',1,'markersize',5,'markerfacecolor','g','markeredgecolor','k');
hold on
plot(Z4,'--rs','linewidth',1,'markersize',5,'markerfacecolor','g','markeredgecolor','k');
title(' Position des zéros dans le plan complexe :');
m=[(1/Z1) ((1/Z1).^2) ((1/Z1).^3) ((1/Z1).^4);(1/Z2) ((1/Z2).^2) ((1/Z2).^3) ((1/Z2).^4);(1/Z3) ((1/Z3).^2) ((1/Z3).^3) ((1/Z3).^4);(1/Z4) ((1/Z4).^2) ((1/Z4).^3) ((1/Z4).^4)];
a=inv(m)*[-1;-1;-1;-1];
%2)
N=1000;
b=randn(1,N); % Bruit blan de moyen 0 et de varriance 1 .
y=zeros(1,N);
for k=1:N;
    if k<5
        som=0;
      for m=1:k-1 
      som=som-a(m)*y(k-m);
      end
    else
        som=0;
        for m=1:4  
        som=som-a(m)*y(k-m);
        end
    end
   y(k)=b(k)+som;
end
tft=abs(fft(y));
figure
subplot(121)
plot(tft);
title(' Signal initial (total=1000 pts) :')
xlabel(' Frequences')
ylabel(' Spectre de y(n) ')
grid on

subplot(122)
signale=y(N-49:N);
tf=abs(fft(signale));
w=1:N;
plot(w(1:25),tf(1:25));
plot(tf);
title('  Signal initial (50 derniers pts) :')
xlabel(' Frequences')
ylabel(' Spectre de y(n) ')
grid on
%3)
figure
r=autocorr(y);
ft1=fft(r);
plot(abs(ft1))
title('  Spectre Autoccorélation de y(n)(50 derniers pts)  ')
xlabel(' Frequences')
ylabel(' Syy ')
grid on
%4)
[a1,e]=levinson(r,4);
%6)
ye=estime(y,a1,4)
erreur=y-ye;
figure
ff1=abs(fft(erreur));
plot(ff1)
title('  Erreur de prédiction : ')
xlabel(' Frequences')
ylabel(' e')
grid on