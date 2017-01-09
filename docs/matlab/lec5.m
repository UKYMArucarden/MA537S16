%Solves Least squares approximation problem on [0,1] for ln(x)
for n=2:100
A=hilb(n);
b=[-1./[1:n].^2]';
c=flipud(A\b);
clf
x=linspace(1/999,1,999);
plot(x,polyval(c,x),'r')
hold on 
plot(x,log(x))
 
sqrt((sum((log(x([1 end]))-polyval(c,x([1 end]))).^2)/2+sum((log(x(2:end-1))-polyval(c,x(2:end-1))).^2))*1/((999)))
[1/(n-1) 1/n 1/(n+1)]
pause
end
