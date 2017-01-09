
a=-1;
b=1;
w=@(x)1./(b-a)+0*x;
w=@(x)1/pi*1./sqrt(1-x.^2);
x=linspace(a-.1,b+.1);
y=x;
[X Y]=meshgrid(x,y);

N=2048;
xis=linspace(a,b,N+2);
xis=xis(2:end-1);
h=(b-a)/(N-1);

Z=X+1i*Y;
for i=1:100
for j=1:100;
fintvals=w(xis).*(-log(abs(Z(i,j)-xis)));
data(i,j)= h*(sum(fintvals(2:end-1))+(fintvals(1)+fintvals(2))/2);
end
end
contour(x,y,data)
