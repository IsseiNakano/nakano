class ParetoSolution {
  int[][][] weight ;
  Vector pareto1 ;
  Vector pareto2 ;
  PathVecl[] labelpareto ;
   ParetoSolution() {
    randomWeight() ;
    pareto1 = new Vector() ;
    pareto2 = new Vector() ;
    labelpareto = new PathVecl[nodenum] ;
    for(int j = 0 ; j < nodenum ; j++)  labelpareto[j] = new PathVecl(j, weight[j]) ;
  }
  int labeling() {
 int time = Integer.MAX_VALUE ; ;
 for(int i = 0 ; i < experimentNum ; i++)
   time = min(time, labelingup()) ;
return time ;
}
int labelingup() {
  reset() ;
  int start = millis() ;
  labelpareto[0].add(new int[objective]) ;
  labelpareto[0].update = true ;
  boolean flag = true ;
  while(flag) {
    flag = false ;
    for(PathVecl ps : labelpareto) {
      for(PathVecl pps : labelpareto)
        if(ps.index != pps.index)
        if(ps.paretoConstruction(pps)) flag = true ;
      ps.update = true ;
    }
  }
  return millis() - start ;
}
  int dijkstraup() {
   reset() ;
   int start = millis() ;
   pareto1.add(new Vector(new int[objective] , 0)) ;
   while(true) {
     boolean flag = false ;
     for(int i = 0 ; i < nodenum ; i++) {
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
 int dijkstra() {
   int time = Integer.MAX_VALUE ; ;
   for(int i = 0 ; i < experimentNum ; i++)
     time = min(time, dijkstraup()) ;
   return time ;
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
     for (PathVecl vs : labelpareto)
      vs.reset() ;
  }
  int lengl() {
  int count = 0 ;
  for(PathVecl ps : labelpareto)
   count += ps.leng() ;
  return count ;
}
   int polynomial() {
    int time = Integer.MAX_VALUE ; ;
    for(int i = 0 ; i < experimentNum ; i++)
      time = min(time, polynomialup()) ;
    return time ;
  }
  void randomWeight() {
   weight = new int[nodenum][nodenum][objective] ;
   for (int i = 0 ; i < nodenum ; i++)
     for(int j = 0 ; j < nodenum ; j++)
       for(int k = 0 ; k < objective; k++) {
         weight[i][j][k] = int(random(bound)) ;
       }
 }
}
