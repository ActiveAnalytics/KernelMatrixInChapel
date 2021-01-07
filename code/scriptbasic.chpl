use Random;
use kernelbasic;

/**
  To compile:
  chpl scriptbasic.chpl --fast --no-checks --optimize --vectorize --no-ieee-float --inline && /usr/bin/time -v ./scriptbasic
**/

proc main()
{
  //var data: [1..10, 1..5] real;
  var data: [1..10_000, 1..512] real;
  fillRandom(data);
  var Kernel = new DotProduct(real);
  //var Kernel = new Gaussian(real, 1.0);
  //var Kernel = new Polynomial(real, 1.0, 0.0);
  //var Kernel = new Exponential(real, 1.0);
  //var Kernel = new Log(real, 1.0);
  //var Kernel = new Cauchy(real, 1.0);
  //var Kernel = new Power(real, 2.0);
  //var Kernel = new Sigmoid(real, 1.0, 0.0);
  var mat = calculateKernelMatrix(Kernel, data);
  //writeln("Matrix:\n", mat);
}

