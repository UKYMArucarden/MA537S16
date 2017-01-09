clf
for figcase=0:3
switch figcase 

case 0
xval=linspace(0,2*pi,100);
yval=linspace(-2,2,100);
case 1
xval=linspace(0,2*pi,20);
yval=linspace(-2,2,20);
case 2
xval=linspace(0,2*pi,20);
yval=linspace(-3,3,20);
case 3 
xval=linspace(0,2*pi,20);
yval=linspace(-6,6,20);
case 4 
xval=linspace(0,4*pi,40);
yval=linspace(-6,6,40);
end
%y'==-y+2cos(x)


f=@(x,y)-y+2*cos(x);

[X Y]=meshgrid(xval,yval);

dY=f(X,Y);  % Gives dy for dx of 1
% At each point we have a vector [1 Z]
% Normalize vector when we plot
dX=1./sqrt(1+dY.^2);
dY=dY./sqrt(1+dY.^2);

quiver(X,Y,dX,dY)
xlabel('x')
ylabel('y')
axis tight0
pause
end

hold on
for y0=[-1 0 3]
yout=y0*exp(-xval)+sin(xval)+cos(xval)-exp(-xval);
plot(xval,yout,'Linewidth',8)
pause
end
