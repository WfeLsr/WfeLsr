close all;
clear;
Fe=100;
y=load('sujet4.txt');
N=length(y);
n=1:N
figure
grid on
subplot(311);
plot(y,'g');
xlabel('signal reelle')
% axis([0 14000 -2000000 2000000]);
r=autocorr(y);
M=12;
[a1,e]=levinson(r,M);
ye=zeros(N,1);
for n=1:N
 if n<M+1    
   for m=1:n-1
      ye(n)=ye(n)-a1(m+1)*y(n-m);
   end 
 else   
   for m=1:M
      ye(n)=ye(n)-a1(m+1)*y(n-m);
   end
 end  
end
grid on
subplot(312);
grid on
plot(ye)
xlabel('signal estimer')
FPE=e*(N+M+1)/(N-M-1);
EPS=y-ye;
grid on
subplot(313);
grid on
plot(EPS)
xlabel('signal erreur')
axis([0 18000 -60000 60000]);
hold on;


N=N/230*2;
[a2,e1]=levinson(r,M);
ye1=zeros(N,1);
for n=1:N
 if n<M+1    
   for m=1:n-1
      ye1(n)=ye1(n)-a2(m+1)*y(n-m);
   end 
 else   
   for m=1:M
      ye1(n)=ye1(n)-a2(m+1)*y(n-m);
   end
 end  
end
figure
grid on
subplot(312);
grid on
plot(ye1)
xlabel('signal estimer')
FPE=e*(N+M+1)/(N-M-1);
EPS=y(1:100)-ye1;
% K=N/100;
% A=zeros(5,1);
% W=zeros(K,100);
% b=1;
% c=1;
% for i=1:N;
%     W(b,c)=y(i);
%        if b==K
%            b=0;
%            c=c+1;
%        end
%  b=b+1;      
% end       
for M=2:4:12
pas=N;
x=ye1.';
x1=x(1:pas);
mu=0.001;
X=x1(1:length(x1)-M);
xr=x1(M+1:length(x1));
N=length(X);
h=zeros(N+1,M);
e(M)=0;
for i=M+1:N
    ye(i)=0;
    for j=1:M
        ye(i)=ye(i)+h(i,j)'*X(1,i-j+1);
        h(i+1,j)=h(i,j)+mu*e(i-1)*X(1,i-j+1);
    end
  e(i)=xr(1,i)-ye(i); 
end 
figure
plot(h)
end

