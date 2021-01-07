use Random;
use kernelperf;
//use DynamicIters;  


/**
  To compile:
  chpl scriptperf.chpl --fast --no-checks --optimize --vectorize --no-ieee-float --inline && /usr/bin/time -v ./scriptperf
**/

proc main()
{
  //var data: [1..10, 1..5] real;
  var data: [1..10_000, 1..512] real;
  fillRandom(data);
  var Kernel = new DotProduct(real);
  var mat = calculateKernelMatrix(Kernel, data);
}

