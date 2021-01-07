use Math;

record DotProduct {
  type T;
  proc kernel(xrow: [?D] ?T, yrow: [D] T): T
  {
    var dist: T = 0: T;
    for i in D {
      dist += xrow[i] * yrow[i];
    }
    return dist;
  }
}

record Gaussian {
  type T;
  const theta: T;
  proc kernel(xrow: [?D] ?T, yrow: [D] T): T
  {
    var dist: T = 0: T;
    for i in D {
      var tmp = xrow[i] - yrow[i];
      dist += tmp * tmp;
    }
    return exp(-sqrt(dist)/this.theta);
  }
}

record Polynomial {
  type T;
  const d: T;
  const offset: T;
  proc kernel(xrow: [?D] ?T, yrow: [D] T): T
  {
    var dist: T = 0: T;
    for i in D {
      dist += xrow[i]*yrow[i];
    }
    return (dist + this.offset)**this.d;
  }
}

record Exponential {
  type T;
  const theta: T;
  proc kernel(xrow: [?D] ?T, yrow: [D] T): T
  {
    var dist: T = 0: T;
    for i in D {
      dist -= abs(xrow[i] - yrow[i]);
    }
    return exp(dist/this.theta);
  }
}

record Log {
  type T;
  const beta: T;
  proc kernel(xrow: [?D] ?T, yrow: [D] T): T
  {
    var dist: T = 0: T;
    //const n: int(64) = D.dim(0);
    for i in D {
      dist += abs(xrow[i] - yrow[i])**this.beta;
    }
    dist = dist**(1/this.beta);
    return -log(1 + dist);
  }
}

record Cauchy {
  type T;
  const theta: T;
  proc kernel(xrow: [?D] ?T, yrow: [D] T): T
  {
    var dist: T = 0: T;
    //const n: int(64) = D.dim(0);
    for i in D {
      var tmp = xrow[i] - yrow[i];
      dist += tmp * tmp;
    }
    dist = sqrt(dist)/this.theta;
    return 1/(1 + dist);
  }
}

record Power {
  type T;
  const beta: T;
  proc kernel(xrow: [?D] ?T, yrow: [D] T): T
  {
    var dist: T = 0: T;
    for i in D {
      dist += abs(xrow[i] - yrow[i])**this.beta;
    }
    return -dist**(1/this.beta);
  }
}

record Wave {
  type T;
  const theta: T;
  proc kernel(xrow: [?D] ?T, yrow: [D] T): T
  {
    var dist: T = 0: T;
    //const n: int(64) = D.dim(0);
    for i in D {
      dist += abs(xrow[i] - yrow[i]);
    }
    var tmp = this.theta/dist;
    return tmp*sin(1/tmp);
  }
}

record Sigmoid {
  type T;
  const beta0: T;
  const beta1: T;
  proc kernel(xrow: [?D] ?T, yrow: [D] T): T
  {
    var dist: T = 0: T;
    //const n: int(64) = D.domain.dim(0).last;
    for i in D {
      dist += xrow[i] * yrow[i];
    }
    return tanh(this.beta0 * dist + this.beta1);
  }
}

/***************************************************************************/
proc calculateKernelMatrix(K, data: [?D] ?T) /* : [?E] T */
{
  var n = D.dim(0).last;
  var p = D.dim(1).last;
  //writeln("Domain: ", D.dim(0));
  var E: domain(2) = {D.dim(0), D.dim(0)};
  var mat: [E] T;
  
  //type A = [{1..n}] T;
  forall j in D.dim(0) {
    var yrow: [{1..p}] T = data[j, ..];
    for i in j..n {
      var xrow: [{1..p}] T = data[i, ..];
      mat[i, j] = K.kernel(xrow, yrow);
      mat[j, i] = mat[i, j];
    }
  }
  return mat;
}

