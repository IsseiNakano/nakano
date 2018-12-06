class ParetoSolution {
  int[][][] weight ;
  Vector pareto1 ;
  Vector pareto2 ;
   ParetoSolution(int[] m) {
    weight = instanceText(m) ;
    pareto1 = new Vector() ;
    pareto2 = new Vector() ;
  }
   int polynomialup() {
    reset() ;
    int start = millis() ;
    pareto2.add(new Vector(new int[objective] , 0)) ;
    while(!pareto2.isEmpty()) {
      Vector s = pareto2.follow ;
      s.remove() ;
      // if(pareto1.check(s))
        pareto1.add(s) ;
      for(int i = 0 ; i < nodenum ; i++) {
        Vector x = new Vector(s.calculation(weight[s.index][i]) , i) ;
        if(pareto1.check(x))
          if(pareto2.check(x))
            pareto2.add(x) ;
      }
    }
    return millis() - start ;
  }
   void reset() {
     pareto1.clear() ;
     pareto2.clear() ;
  }
   void polynomial() {
    int time = Integer.MAX_VALUE ; ;
    for(int i = 0 ; i < experimentNum ; i++) {
      int times = polynomialup() ;
      time = min(time, times) ;
      println(times) ;
    }
    println(pareto1.leng()+","+time) ;
  }
   int[][][] instanceText(int[] m) {
    int[][][] weight = new int[nodenum][nodenum][objective] ;
    for (int k = 0 ; k < m.length ; k++) {
      String[] lines = loadStrings(dir + "weight_" + nodenum + "_" + bound + "_" + m[k] + ".csv");
      for(int i = 0 ; i < nodenum ; i++){
        String[] values = split(lines[i], ",") ;
        for(int j = 0 ; j < nodenum ; j++) {
          weight[i][j][k] = int(values[j]) ;
        }
      }
    }
    return weight ;
  }
}
