class ParetoSolution {
  int[][][] weight ;
  PathVec1[] pareto1 ;
  PathVec2[] pareto2 ;
  PathVec3[] pareto3 ;
  int[] mm ;

  ParetoSolution(int[] m) {
    weight = instanceText(m) ;
    mm = m ;
    // weight = randomWeight() ;
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
    }
    return millis() - start ;
  }

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
    }
  }

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
    weight = instanceText(mm) ;
    for(int j = 0 ; j < nodenum ; j++) {
      pareto1[j].w = weight[j] ;
      pareto2[j].w = weight[j] ;
      pareto3[j].w = weight[j] ;
    }
  }

  void update1() {
    int time = Integer.MAX_VALUE ; ;
    for(int i = 0 ; i < experimentNum ; i++) {
      int times = bellmanford1() ;
      time = min(time, times) ;
      // println(times) ;
    }
    println(leng1()+","+time) ;
  }
  void update2() {
    int time = Integer.MAX_VALUE ; ;
    for(int i = 0 ; i < experimentNum ; i++) {
      int times = bellmanford2() ;
      time = min(time, times) ;
    }
    println(leng2()+","+time) ;
  }
  void update3() {
    int time = Integer.MAX_VALUE ; ;
    for(int i = 0 ; i < experimentNum ; i++) {
      int times = bellmanford3() ;
      time = min(time, times) ;
    }
    println(leng3()+","+time) ;
  }
  void update() {
    update1() ;
    update2() ;
    update3() ;
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

  int[][][] instanceText(int[] m) {
    int[][][] weight = new int[nodenum][nodenum][objective] ;
    for (int k = 0 ; k < m.length ; k++) {
      String[] lines = loadStrings(dir + "weight_" + nodenum + "_" + bound + "_" + m[k] + ".csv");
      for(int i = 0 ; i < nodenum ; i++){
        String[] values = split(lines[i], ",") ;
        for(int j = 0 ; j < nodenum ; j++) {
          weight[j][i][k] = int(values[j]) ;
        }
      }
    }
    return weight ;
  }

  int[][][] instanceTextF(int[] m) {
    int[][][] weight = new int[nodenum][nodenum][objective] ;
    for (int k = 0 ; k < m.length ; k++) {
      String[] lines = loadStrings(dirF + "cost" + m[k] + ".csv");
      for(int i = 0 ; i < nodenum ; i++){
        String[] values = split(lines[i], ",") ;
        for(int j = 0 ; j < nodenum ; j++) {
          weight[j][i][k] = int(values[j]) ;
        }
      }
    }
    return weight ;
  }

  int[][][] randomWeight() {
    int[][][] weight = new int[nodenum][nodenum][objective] ;
    for (int k = 0 ; k < nodenum ; k++) {
      for(int i = 0 ; i < nodenum ; i++){
        for(int j = 0 ; j < objective; j++) {
          weight[k][i][j] = int(random(bound)) ;
        }
      }
    }
    return weight ;
  }

}
