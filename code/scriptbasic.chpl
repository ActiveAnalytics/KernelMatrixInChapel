use Random;
use kernelbasic;

/**
  To compile:
  chpl scriptbasic.chpl --fast --no-checks --optimize --vectorize --no-ieee-float --inline && /usr/bin/time -v ./scriptbasic
**/

proc main()
{
  var data: [1..10_000, 1..512] real;
  fillRandom(data);
  var Kernel = new DotProduct(real);
  var mat = calculateKernelMatrix(Kernel, data);
}

