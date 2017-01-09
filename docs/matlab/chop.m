function c = chop(x, t,flag)
%CHOP    Round matrix elements.
%        CHOP(X, t) is the matrix obtained by rounding the elements of X
%        to t significant binary places.
%        Default is t = 24, corresponding to IEEE single precision.
%Modified from Higham's chop

if nargin < 2, t = 24; flag=1; end
[m, n] = size(x);

%  Use the representation:
%  x(i,j) = 2^e(i,j) * .d(1)d(2)...d(s) * sign(x(i,j))

%  On the next line `+(x==0)' avoids passing a zero argument to LOG, which
%  would cause a warning message to be generated.

y = abs(x) + (x==0);
e = floor(log2(y) + 1);
%floor( pow2(x, t-e))
%round( pow2(x, t-e) )
if flag % Chop
s=sign(x);
x=abs(x);
c = s*pow2(floor( pow2(x, t-e) ), e-t);
else
c = pow2(round( pow2(x, t-e) ), e-t);
end
