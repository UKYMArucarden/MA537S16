%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Region of Stability of Euler's Method
%EM y_i+1=y_i+h f(x_i,y_i)
% r(lambda h)=(1+h*lambda)
r=@(z)(1+z)
disp('Forward Euler')
%Method 1
disp('Method 1')
xval=linspace(-2,2);
yval=linspace(-2,2);
[X Y]=meshgrid(xval,yval);
Z=X+1i*Y;
Rval=abs(r(Z));
clf
colormap autumn
h=pcolor(xval,yval,(Rval<1)*1.0);
colorbar
title('Region of Stability of Euler Method')
xlabel('real(\lambda h)')
ylabel('imag(\lambda h)')
pause
%Method 2
disp('Method 2')
thetaval=linspace(0,2*pi);
data=[];
i=1;
for theta=thetaval
    %Polynomial for matlab 
    %will be 
    r=[1 1-exp(1i*theta)];
    data(i,:)=roots(r);
    i=i+1;
end
hold on



plot(data(:),'b*')
pause
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Region of Stability of Backward Euler's Method
%BEM y_i+1=y_i+h f(x_i+1,y_i+1)
% r(lambda h)=1./(1-h*lambda)
r=@(z)1./(1-z)
disp('Backward Euler')
%Method 1
disp('Method 1')
xval=linspace(-2,2);
yval=linspace(-2,2);
[X Y]=meshgrid(xval,yval);
Z=X+1i*Y;
Rval=abs(r(Z));
clf
colormap autumn
pcolor(xval,yval,(Rval<1)*1.0)
colorbar
title('Region of Stability of Backward Euler Method')
xlabel('real(\lambda h)')
ylabel('imag(\lambda h)')
pause
%Method 2
disp('Method 2')
%To use method 2 for rational functions 
% r(z)= h(z)/g(z)
% Let h(z)/g(z)=e^{i theta}
% then
% h(z)-g(z)*e^{i theta}
% Is the polynomial whose roots we want to find
thetaval=linspace(0,2*pi);
data=[];
i=1;

for theta=thetaval
    %h=1 -> [ 0 1]%
    %g=(1-z) -> [-1 1]
    % Hence the coefficients will be
    r=[0 1]-exp(1i*theta)*[-1 1];
    data(i,:)=roots(r);
    i=i+1;
end
hold on

plot(data(:),'b*')
pause

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Region of Stability of Trapezoid Method
%Trap y_i+1=y_i+h/2( f(x_i+1,y_i+1)+f(x_i+1,y_i+1))
% r(lambda h)=(1+h lambda /2)./(1-h*lambda/2)
r=@(z)(1+z/2)./(1-z/2)
disp('Trapezoid')
%Method 1
disp('Method 1')
xval=linspace(-2,2);
yval=linspace(-2,2);
[X Y]=meshgrid(xval,yval);
Z=X+1i*Y;
Rval=abs(r(Z));
clf
colormap autumn
pcolor(xval,yval,(Rval<1)*1.0)
colorbar
title('Region of Stability of Trapezoid Method')
xlabel('real(\lambda h)')
ylabel('imag(\lambda h)')
pause
%Method 2
disp('Method 2')
%To use method 2 for rational functions 
% r(z)= h(z)/g(z)
% Let h(z)/g(z)=e^{i theta}
% then
% h(z)-g(z)*e^{i theta}
% Is the polynomial whose roots we want to find
thetaval=linspace(0,2*pi);
data=[];
i=1;

for theta=thetaval
    %h=1 -> [ 1/2 1]%
    %g=(1-z) -> [-1/2 1]
    % Hence the coefficients will be
    % 
    
    r=[1/2 1]-exp(1i*theta)*[-1/2 1];
    data(i,:)=roots(r);
    i=i+1;
end
hold on

plot(data(:),'b*')
pause
return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%n
%Region of stability for AB-2
%EM y_i+1=y_i+h/2*(3 f(x_i,y_i)-  f(x_i-1,y_i-1))
% Replace y_{i} with r^i simplify
%Method 2
disp('Method 2')
clf
title('Region of Stability of AB-2')
thetaval=linspace(0,2*pi);
data=[];
i=1;
for theta=thetaval
    %Polynomial for matlab 
    %will be 
    rtemp =exp(1i*theta);
    r=[-1/2+3/2*rtemp rtemp-rtemp^2];
    data(i,:)=roots(r);
    i=i+1;
end
hold on

axis([-2 2 -2 2])

plot(data(:),'b*')
pause
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Region of stability for AM-3
%EM y_i+1=y_i+h/12*(5 f(x_i+1,y_i+1)+8 f(x_i,y_i)- f(x_i-1-1,y_i-1))
% Replace y_{i} with r^i simplify
%Method 2
disp('Method 2')
clf
thetaval=linspace(0,2*pi);
data=[];
i=1;
for theta=thetaval
    %Polynomial for matlab 
    %will be 
    rtemp =exp(1i*theta);
    r=[1/12*(5*rtemp^2+8*rtemp-1) rtemp-rtemp.^2 ];
%    r=[1/2*(rtemp+1) 1-rtemp ];
    data(i,:)=roots(r);
    i=i+1;
end
hold on
   
hlambda=-3;
roots([5*hlambda/12-1 8*hlambda/12+1 -hlambda/12]);

axis([-2 2 -2 2])

plot(data(:),'b*')
pause

