//These helper function essentially replicated functions
//that are found in matlab.  They are functions that I have
//used in javascript examples for classes in numerical analysis
//and numerical linear algebra.
// In some spots there are still printouts from when the code was
// being debugged.
function writeout(s)
{
    //Prints to a div that is used strictly for output
    //if it exists otherwise just writes
    if (document.getElementById('output') === null)
    {
    	document.write(s);
    }
    else
    {
	document.getElementById('output').innerHTML+=s;
    }
}
function linspace(a,b,N){
    if(N==1)
    {
	if (a==b)
	{
	    var out = new Float64Array(N);
	    out[0]=a;
	}
	else
	{
	    out==NaN;
	}
    }
    else
    {
    var h=(b-a)/(N-1);
    // Prealllocate 
    var out = new Float64Array(N);
    // No Preallocation 
    // out=[];
    for(var i=0;i< N;i++){
	//Preallocation
	out[i]=(a+i*h);
	//No Preallocation
	//out.push(a+i*h);
    }
    }
    //Preallocate, must convert to regular array
    return(Array.prototype.slice.call(out));
    //No Preallocation, no conversion necessary
	//return(out);

}
function zeros(n,m)
{
    var x=new Array(n);
    var i;
    var j;
    for(i=0;i<n;i++)
    {
	if(m==1)
	{
	    
	    x[i]=0.0;
	}
	else
	{
	    x[i]=new Array(m);
	    for(j=0;j<m;j++)
	    {
		x[i][j]=0.0;
	    }
	}
    }
    return(x)
}
function norm2(x)
{
    //a-b
    //Will fail if they aren't the same length
    var n=x.length;
    var i;
    var s;
    s=0;
    for(i=0;i<n;i++)
    {
	s=s+x[i]*x[i];
	//	   writeout(s+'<br>');
	//	       writeout(x[i]+'<br>');
    }
    return(Math.sqrt(s));
}
function dispsize(A)
{
    m=A.length;
    n=A[0].length;
    writeout("<br>("+m+","+n+")<br>");
    
}
function disp(A)
{
    var n=A.length;
    outstring='';
    outstring+='<pre><tt>'
    //      writeout(' n='+n+' ');
    //       writeout(' A='+A);
    //     writeout('n='+n);
    if(n>=1)
    {
	var m=A[0].length;//Alldimensions better be the same.
	if(typeof m == 'undefined')
	{
	    //		   writeout('m='+m+' n'+n);
	    for(i=0;i<n;i++)
	    {
		outstring+=(sprintf('%-8.2f ',A[i]));
		outstring+=('<br>')
	    }
	    
	}
	else
	{
	    var i;
	    for(i=0;i<n;i++)
	    {
		if(m>1)
		{
		    var j;
		    for(j=0;j<m;j++)
		    {
			//			   '<pre><tt>'+
			outstring+=(sprintf('% 7.4f ',A[i][j]));//+'</tt></pre>');
		    }
		}
		else
		{
		    outstring+=(sprintf('% 5.2f ',A[i]));
		}
		outstring+=('<br>')
	    }
	}

    }
    else
    {
	//	   writeout(sprintf('%4.2f<br> ',A));
	writeout(sprintf('%4.2f<br> ',A));
    }
    outstring+=('</tt>');
    outstring+=('</pre>');
    writeout(outstring);
}

function lagrange(xnodes,ynodes,xvals)
{
    n=xnodes.length-1;
    yvals=zeros(xvals.length,1);
    //Evaluate Lagrange polynomial
    for(i=0;i<=n;i++)
    {
	//Evaluate ith elementary lagrange interpolatingpolynomial
	term=numeric.add(zeros(xvals.length,1),ynodes[i]);
//	writeout('term' + term + '<br>');
//	writeout('xvals.length' + xvals.length + '<br>');
//	writeout('xvals' + xvals + '<br>');
	for(j=0;j<=n;j++){
	    if(i!=j){
		term=numeric.mul(term,numeric.sub(xvals,xnodes[j]));
		term=numeric.mul(term,1/(xnodes[i]-xnodes[j]));
	    }
	}
	yvals=numeric.add(yvals,term);
    }
   return(yvals)
}
//Generates a divided difference table for displaying
function ddtable(xnodes,ynodes)
{
    n=xnodes.length;
    DDtable=zeros(n,n);
    for(i=0;i<n;i++)
    {
    DDtable[i][0]=ynodes[i];
    }

    
    
    //Evaluate the divided differences
    //one column at a time.
    // In practice this would be done in place.
    for(j=1;j<n;j++)
    {	
	for(i=0;i<n-j;i++)
	{
	    DDtable[i][j]=(DDtable[i][j-1]-DDtable[i+1][j-1])/(xnodes[i]-xnodes[i+j]);
	}
    }
   return(DDtable)
}
//Generates a divided difference table for displaying
//The resulting polynomial will be nested so as to interpolate at the nodes
function newtoncoeff(xnodes,ynodes)
{
    n=xnodes.length;
    DDtable=zeros(n,1);
    for(var i=0;i<n;i++)
    {
    DDtable[i]=ynodes[i];
    }
    for(var j=1;j<n;j++)
    {	
	for(var i=n-1;i>=j;i--)
	{
//	    disp(DDtable[i-1])
//	    disp(DDtable[i])
//	    disp(xnodes[i-j])
//	    disp(xnodes[i])
	    DDtable[i]=(DDtable[i-1]-DDtable[i])/(xnodes[i-j]-xnodes[i]);
//	    disp(DDtable)
	}
//	disp(DDtable)
    }
   return(DDtable)
}
//Returns the Chebyshev nodes for the interval [a,b]
//Nodes are returned in ascending order
//assuming that a and b are already in ascending order.
function chebab(a,b,n)
{
    var xnodes=linspace(1/(2*n+2)*Math.PI,(2*n+1)/(2*n+2)*Math.PI,n+1);
//    disp(xnodes)
    var abnodes=zeros(n+1,1);
    for(var i=0;i<=n;i++)
    {
	abnodes[n-i]= (Math.cos(xnodes[i])+1)/2*(b-a)+a;
    }
    return(abnodes)

}
   function transpose(A)
   {
       var m=A.length;
  //     writeout('m=='+m+'<br>');
       if(typeof m == 'undefined')
       {
//	   writeout('Must have a scalar<br>');
	   return(A);
       }
       else
       {
//	   writeout('Must have a vector<br>');
	   
	       var n=A[0].length;	      
	   if(typeof n == 'undefined')
	   {
//	       	   writeout('Must have a column vector<br>');
	       var AT=new Array(1);
	       var ATrow=new Array(m);
	       var i;
	       for(i=0;i<m;i++)
	       {
		   ATrow[i]=A[i];		   
	       }
	    //   writeout(A);
//	       writeout(ATrow);
	       AT[0]=ATrow;
//	       writeout(AT);
//	       disp(AT);
	       return(AT);
	   }
	   else
	   {
//	       writeout('Have all dimensions<br>')
	       AT=new Array(n);
	       var i;
	       for(i=0;i<n;i++)
	       {
		   AT[i]=new Array(m);
		   var j;
		   for(j=0;j<m;j++)
		       AT[i][j]=A[j][i];
	       }
	       return(AT);
	   }
       }
   }
