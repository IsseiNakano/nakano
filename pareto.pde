class ParetoSolution {
  int[][][] weight ;
  Vector pareto1 ;
   ParetoSolution(int[] m) {
    weight = instanceText(m) ;
    pareto1 = new Vector() ;
  }
   int polynomialup() {
    reset() ;
    int start = millis() ;
    pareto1.add(new Vector(new int[objective] , 0)) ;
    while(true) {
      boolean flag = false ;
      for(int i = 0 ; i < nodenum ; i++) {
        // Vector pareto2 = (Vector)pareto1.clone() ;
        for(Vector s = pareto1.follow ; s != pareto1 ; s = s.follow) {
          if(s.index == i) {
            for(int j = 0 ; j < nodenum ; j++) {
              Vector x = new Vector(s.calculation(weight[i][j]) , j) ;
              if(pareto1.check(x)) {
                pareto1.add(x) ;
                flag = true ;
              }
            }
          }
        }
      }
      if(!flag) break ;
    }
    return millis() - start ;
  }
   void reset() {
     pareto1.clear() ;
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
