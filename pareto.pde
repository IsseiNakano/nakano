class ParetoSolution {
  int[][][] weight ;
<<<<<<< HEAD
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
=======
  int[][][] originalweight ;
  PathVec1[] pareto1 ;
  PathVec2[] pareto2 ;
  PathVec3[] pareto3 ;

  ParetoSolution(int s) {
    randomWeight(s) ;
    weight = originalweight ;
    pareto1 = new PathVec1[nodenum] ;
    for(int j = 0 ; j < nodenum ; j++)  pareto1[j] = new PathVec1(j, weight[j]) ;
    pareto2 = new PathVec2[nodenum] ;
    for(int j = 0 ; j < nodenum ; j++)  pareto2[j] = new PathVec2(j, weight[j]) ;
    pareto3 = new PathVec3[nodenum] ;
    for(int j = 0 ; j < nodenum ; j++)  pareto3[j] = new PathVec3(j, weight[j]) ;
  }

  int bellmanford1() {
    reset() ;
    int start = millis() ;
    negativeCycleCheck1() ;
    pareto1[0].upd.add(new Vector1(new int[objective])) ;
    boolean flag = true ;
    while(flag) {
      flag = false ;
      for(PathVec1 ps : pareto1)
        for(PathVec1 pps : pareto1)
          if(ps.index != pps.index)
          if(ps.paretoConstruction(pps)) flag = true ;
      for(PathVec1 ps : pareto1)
        ps.update() ;
>>>>>>> parent of 4c5424c... 提案と従来比較
    }
  }
<<<<<<< HEAD
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
=======

  int bellmanford2() {
    reset() ;
    int start = millis() ;
    pareto2[0].upd.add(new Vector2(new int[objective], -1)) ;
    bellmanfordlayer2() ;
    return millis() - start ;
  }
  void bellmanfordlayer2() {
    boolean flag = true ;
    while(flag) {
      flag = false ;
      for(PathVec2 ps : pareto2)
        for(PathVec2 pps : pareto2)
          if(ps.index != pps.index)
          if(ps.paretoConstruction(pps)) flag = true ;
      for(PathVec2 ps : pareto2)
        ps.update() ;
      for(int i = 0 ; i < objective ; i++)
        if(negativeobj[i] == true) {
          removeObject2(i) ;
          negativeobj[i] = false ;
        }
>>>>>>> parent of 4c5424c... 提案と従来比較
    }
  }
<<<<<<< HEAD
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
=======

  boolean negativeCycleCheck1(int k) {
    int status ;
    for(PathVec1 ps : pareto1) {
      ps.miniClear() ;
      ps.minipre = sss ;
    }
    pareto1[0].miniZero() ;
    for(int i = 0 ; i < weight.length ; i++) {
      boolean flag = false ;
      for(PathVec1 ps : pareto1)
        for(PathVec1 pps : pareto1)
          if(ps.index != pps.index) {
            status = ps.negativeCycleCheck(pps, k) ;
            if(status == 3)
              if(cycleCheck1(pps, pps.index)) return false ;
            if(status > 1) flag = true ;
          }
      if(!flag) return true ;
    }
    return false ;
  }

  boolean cycleCheck1(PathVec1 x, int y) {
    for(PathVec1 i = x.minipre ; i != sss ; i = i.minipre) {
      if(i.index == y) return true ;
    }
    return false ;
  }

  void negativeCycleCheck1() {
    for(int i = 0 ; i < objective ; i++) {
      if(!negativeCycleCheck1(i))
        removeObject1(i) ;
    }
  }

  int bellmanford3() {
  reset() ;
  int start = millis() ;
  negativeCycleCheck3() ;
  for(PathVec3 ps : pareto3)
    ps.updAddMinis() ;
  bellmanfordlayer3() ;
  return millis() - start ;
}

void bellmanfordlayer3() {
  boolean flag = true ;
  while(flag) {
    flag = false ;
    for(PathVec3 ps : pareto3)
      for(PathVec3 pps : pareto3)
        if(ps.index != pps.index)
        if(ps.paretoConstruction(pps)) flag = true ;
    for(PathVec3 ps : pareto3)
      ps.update() ;
  }
}

boolean negativeCycleCheck3(int k) {
  int status ;
  for(PathVec3 ps : pareto3) {
    ps.miniClear() ;
    ps.minipre = sss3 ;
  }
  pareto3[0].miniZero() ;
  for(int i = 0 ; i < nodenum ; i++) {
    boolean flag = false ;
    for(PathVec3 ps : pareto3)
      for(PathVec3 pps : pareto3)
        if(ps.index != pps.index) {
          status = ps.negativeCycleCheck(pps, k) ;
          if(status == 3)
            if(cycleCheck3(pps, pps.index)) return false ;
          if(status > 1) flag = true ;
        }
    if(!flag) return true ;
  }
  return false ;
}

boolean cycleCheck3(PathVec3 x, int y) {
  for(PathVec3 i = x.minipre ; i != sss3 ; i = i.minipre) {
    if(i.index == y) return true ;
  }
  return false ;
}

void negativeCycleCheck3() {
  for(int i = 0 ; i < objective ; i++) {
    if(!negativeCycleCheck3(i)) {
      removeObject3(i) ;
    } else {
      conversion() ;
    }
  }
}

void conversion() {
  for(PathVec3 ps : pareto3)
    ps.conversion() ;
}

void removeObject3(int k) {
  for(PathVec3 ps : pareto3)
    ps.removeObject(k) ;
}

  void removeObject1(int k) {
    for(PathVec1 ps : pareto1)
      ps.removeObject(k) ;
  }

  void removeObject2(int k) {
    for(PathVec2 ps : pareto2)
      ps.removeObject(k) ;
  }

  void reset() {
    for (PathVec1 vs : pareto1) {
      vs.reset() ;
    }
    for (PathVec2 vs : pareto2) {
      vs.reset() ;
    }
    for (PathVec3 vs : pareto3) {
      vs.reset() ;
    }
    weight = originalweight ;
    for(int j = 0 ; j < nodenum ; j++) {
      pareto1[j].w = weight[j] ;
      pareto2[j].w = weight[j] ;
      pareto3[j].w = weight[j] ;
    }
  }

  int update1() {
    int time = Integer.MAX_VALUE ; ;
    for(int i = 0 ; i < experimentNum ; i++)
      time = min(time, bellmanford1()) ;
    return time ;
  }
  int update2() {
    int time = Integer.MAX_VALUE ; ;
    for(int i = 0 ; i < experimentNum ; i++)
      time = min(time, bellmanford2()) ;
    return time ;
  }
  int update3() {
    int time = Integer.MAX_VALUE ; ;
    for(int i = 0 ; i < experimentNum ; i++)
      time = min(time, bellmanford3()) ;
    return time ;
  }
  int leng1() {
    int count = 0 ;
    for(PathVec1 ps : pareto1)
     count += ps.leng() ;
    return count ;
  }
  int leng2() {
    int count = 0 ;
    for(PathVec2 ps : pareto2)
     count += ps.leng() ;
    return count ;
  }
  int leng3() {
    int count = 0 ;
    for(PathVec3 ps : pareto3)
     count += ps.leng() ;
    return count ;
  }


  int minileng() {
    int count = 0 ;
    for(PathVec3 ps : pareto3)
     count += ps.minileng() ;
    return count ;
  }

  void minishow() {
    for(PathVec3 ps : pareto3)
      ps.minishow() ;
  }

  int[][][] randomWeight(int s) {
    originalweight = new int[nodenum][nodenum][objective] ;
    if(s == 0)
      for (int i = 0 ; i < nodenum ; i++)
        for(int j = 0 ; j < nodenum ; j++)
          for(int k = 0 ; k < objective; k++)
            originalweight[i][j][k] = int(random(bound)) ;
    else
      for (int i = 0 ; i < nodenum ; i++)
        for(int j = 0 ; j < nodenum ; j++)
          for(int k = 0 ; k < objective; k++)
            if(k == 0)
              originalweight[i][j][k] = int(random(-bound/20 , bound)) ;
            else
              originalweight[i][j][k] = int(random(bound)) ;
    return weight ;
  }

>>>>>>> parent of 4c5424c... 提案と従来比較
}
