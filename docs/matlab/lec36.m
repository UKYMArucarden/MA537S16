format long 
x0=0;
xf=2; % Final Time
switch 3
case 1
f=@(x,y) y;
ytrue=@(x) exp(x);
y0=1;
[X Y]=meshgrid(linspace(0,2.5,20),linspace(0,8,20));
case 2,
f=@(x,y) 1./(1+x.^2)-2*y.^2;
ytrue=@(x) x./(1+x.^2);
y0=0;
[X Y]=meshgrid(linspace(0,2.1,20),linspace(0,.6,20));
case 3
lambda=-32
%lambda=-16
lambda=-8
f=@(x,y) lambda*y;
y0=1;
ytrue=@(x) y0*exp(lambda*x);
[X Y]=meshgrid(linspace(0,2,20),linspace(-1,1,20));
end
%Initial conditions
ns=5; %Number of samples (does not include x0)
      %Points for table
T=(xf-x0)/ns;
%For samples and all approximations
xval=linspace(x0,xf)';
figure(1)
clf
plot(xval,ytrue(xval),'Linewidth',3)
lg={'ytrue'}
legend(lg)

hold on
c=['rgkmy'];
ptcnt=1;
for n=[ 4 8 16 32]  % Number of points between samples
  ys=[]; yall=[];
  xs=[]; xall=[];
  k=1;
  y=y0;
  x=x0;
  yall(k,:)=y;
  xall(k,:)=x;

  h=T/(n);
  for j=1:ns
    for i=1:n
      % Forward Euler
      y=y+h*f(x,y);
      x=x+h;
      k=k+1;
      yall(k,:)=y;
      xall(k,:)=x;
    end
    ys(j,:)=y;
    xs(j,:)=x;
  end
fprintf('h==%15.15f\n',h);
fprintf('%6s %18.15s %18.15s %18.15s\n','x','y_h(x)','y(x)','y_h(x)-y(x)')
for i=1:ns
fprintf('%6.3f %18.15f %18.15f %18.15f\n',xs(i),ys(i),ytrue(xs(i)),ys(i)-ytrue(xs(i)));
end
pt=plot(xall,yall,'--','Linewidth',3);
set(pt,'Color',c(ptcnt));
lg{length(lg)+1}=['h==' num2str(h)];
legend(lg)

drawnow
pause
ptcnt=ptcnt+1;
end
disp('Now quiver!')
pause

dY=f(X,Y);  % Gives dy for dx of 1
% At each point we have a vector [1 Z]
% Normalize vector when we plot
dX=1./sqrt(1+dY.^2);
dY=dY./sqrt(1+dY.^2);

h=  quiver(X,Y,dX,dY);

