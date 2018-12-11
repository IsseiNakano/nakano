class ParetoSolution {
  int[][][] weight ;
  int[][][] weight1 ;
  PathVec[] pareto ;
  LabelSolution[] pareto1 ;
   ParetoSolution(int[] m) {
    weight = instanceText(m) ;
    weight1 = instanceText1(m) ;
    // weight = randomWeight() ;
    pareto = new PathVec[nodenum] ;
    for(int j = 0 ; j < nodenum ; j++)  pareto[j] = new PathVec(j, weight[j]) ;
    pareto1 = new LabelSolution[nodenum] ;
    for(int j = 0 ; j < nodenum ; j++)  pareto1[j] = new LabelSolution(j, weight[j]) ;
  }
  int bellmanford4() {
    reset() ;
    int start = millis() ;
    pareto1[0].upd.add(new Label(new int[objective])) ;
    boolean flag = true ;
    while(flag) {
      flag = false ;
      for(LabelSolution ps : pareto1)
        for(LabelSolution pps : pareto1)
          if(ps.index != pps.index)
          if(ps.paretoConstruction(pps)) flag = true ;
      for(LabelSolution ps : pareto1)
        ps.update() ;
    }
    return millis() - start ;
  }
  int bellmanford3() {
    int[][] solution = new int[orderlength][objective] ;
    int[] pre = orderReset() ;
  int[] follow = orderReset() ;
  boolean[] empty = new boolean[orderlength] ;
  for(int i = 0 ; i < orderlength ; i++)
    empty[i] = false ;
  int start = millis() ;
  follow[3*nodenum] = nodenum ;
  pre[3*nodenum] = nodenum ;
  follow[nodenum] = 3*nodenum ;
  pre[nodenum] = 3*nodenum ;
  empty[3*nodenum] = true ;
  int searchpoint = 3*nodenum ;
  boolean flag = true ;
  while(flag) {
    flag = false ;
    for(int j = 0 ; j < nodenum ; j++)
      for(int i = 0 ; i < nodenum ; i++)
        if(i != j) {
          int u1 = nodenum + i ;
          int u2 = 2*nodenum + i ;
          int v1 = nodenum + j ;
          int v2 = 2*nodenum + j ;
          for(int l = follow[u1] ; l != u1 ; l = follow[l]) {
            int[] path = calculation(solution[l], weight1[i][j]) ;
            boolean pathflag = true ;

            for(int pa = follow[j] ; pa != j ; pa = follow[pa]) {
              int status = dominate(solution[pa], path) ;
              if (status <= 1)  {
                pathflag = false ;
                break ;
              }
              if (status == 2) {
                int g = pre[pa] ;
                int gg = follow[pa] ;
                follow[g] = gg ;
                pre[gg] = g ;
                empty[pa] = false ;
              }
            }

            if(pathflag)
              for(int pa = follow[v1] ; pa != v1 ; pa = follow[pa]) {
                int status = dominate(solution[pa], path) ;
                if (status <= 1)  {
                  pathflag = false ;
                  break ;
                }
                if (status == 2) {
                  int g = pre[pa] ;
                  int gg = follow[pa] ;
                  follow[g] = gg ;
                  pre[gg] = g ;
                  empty[pa] = false ;
                }
              }

            if(pathflag)
              for(int pa = follow[v2] ; pa != v2 ; pa = follow[pa]) {
                int status = dominate(solution[pa], path) ;
                if (status <= 1)  {
                  pathflag = false ;
                  break ;
                }
                if (status == 2) {
                  int g = pre[pa] ;
                  int gg = follow[pa] ;
                  follow[g] = gg ;
                  pre[gg] = g ;
                  empty[pa] = false ;
                }
              }

            if(pathflag) {
              flag = true ;
              int s = emptysolution(empty, searchpoint) ;
              if(s == -1)
                s = emptysolution(empty, 3*nodenum) ;
              searchpoint = s ;
              if(s == -1)
                println("s = " + s ) ;
              for(int k = 0 ; k < objective ; k++)
                solution[s][k] = path[k] ;
              int v3 = pre[v2] ;
              follow[s] = v2 ;
              pre[s] = v3 ;
              follow[v3] = s ;
              pre[v2] = s ;
              empty[s] = true ;
            }
          }
        }

    for(int i = 0 ; i < nodenum ; i++) {
      int u1 = nodenum + i ;
      int u2 = 2*nodenum + i ;
      if(follow[u1] != u1) {
        int u3 = pre[i] ;
        int u4 = pre[u1] ;
        int u5 = follow[u1] ;
        pre[u5] = u3 ;
        follow[u3] = u5 ;
        follow[u4] = i ;
        pre[i] = u4 ;
        follow[u1] = u1 ;
        pre[u1] = u1 ;
      }
      if(follow[u2] != u2) {
        int u3 = follow[u2] ;
        int u4 = pre[u2] ;
        follow[u1] = u3 ;
        pre[u1] = u4 ;
        pre[u3] = u1 ;
        follow[u4] = u1 ;
        follow[u2] = u2 ;
        pre[u2] = u2 ;
      }
    }
  }
  int times = millis() - start ;
  println(solutionSize(empty)) ;
  return times ;
}
int[] orderReset() {
  int[] order = new int[orderlength] ;
  for(int i = 0 ; i < orderlength ; i++) {
    if(i < 3 * nodenum) order[i] = i ;
    else order[i] = -1 ;
  }
  return order ;
}

int dominate(int[] v , int[] u) {
    int status = 0 ;
    for (int k = 0 ; k < objective ; k++) {
      int d = u[k] - v[k] ;
      if (d > 0) status |= 1 ;
      else if (d < 0) status |= 2 ;
      if (status == 3) break ;
    }
    return status ;
  }

int[] calculation(int[] update, int[] weightl) {
  int[] path = new int[objective] ;
  for(int i = 0 ; i < objective ; i++)
    path[i] = update[i] + weightl[i] ;
  return path ;
}

int emptysolution(boolean[] empty, int searchpoint) {
  for(int i = searchpoint ; i < orderlength ; i++)
    if(!empty[i]) return i ;
  return -1 ;
}

int solutionSize(boolean[] empty) {
  int count = 0 ;
  for(int i = 3 * nodenum ; i < orderlength ; i++)
    if(empty[i]) count++ ;
  return count ;
}
   int bellmanford1() {
    reset() ;
    int start = millis() ;
    pareto[0].upd.add(new Vector(new int[objective])) ;
    boolean flag = true ;
    while(flag) {
      flag = false ;
      for(PathVec ps : pareto)
        for(PathVec pps : pareto)
          if(ps.index != pps.index)
          if(ps.paretoConstruction1(pps)) flag = true ;
      for(PathVec ps : pareto)
        ps.update() ;
    }
    return millis() - start ;
  }
  int bellmanford2() {
   reset() ;
   int start = millis() ;
   pareto[0].upd.add(new Vector(new int[objective])) ;
   boolean flag = true ;
   while(flag) {
     flag = false ;
     for(PathVec ps : pareto)
        for(Vector s = ps.upd.follow ; s != ps.upd ; s = s.follow) {
          for(PathVec pps : pareto)
            if(ps.index != pps.index)
              if(pps.paretoConstruction2(s , ps.index)) flag = true ;
        }
     for(PathVec ps : pareto)
       ps.update() ;
   }
   return millis() - start ;
 }
   void reset() {
    for (PathVec vs : pareto) {
      vs.reset() ;
    }
    for (LabelSolution vs : pareto1) {
      vs.reset() ;
    }
  }
   void update1() {
    int time = Integer.MAX_VALUE ; ;
    for(int i = 0 ; i < experimentNum ; i++) {
      int times = bellmanford1() ;
      time = min(time, times) ;
      // println(times) ;
    }
    println(leng()+","+time) ;
  }
  void update2() {
   int time = Integer.MAX_VALUE ; ;
   for(int i = 0 ; i < experimentNum ; i++) {
     int times = bellmanford2() ;
     time = min(time, times) ;
   }
   println(leng()+","+time) ;
 }
 void update3() {
  int time = Integer.MAX_VALUE ; ;
  for(int i = 0 ; i < experimentNum ; i++) {
    int times = bellmanford3() ;
    time = min(time, times) ;
  }
  println(leng()+","+time) ;
}
void update4() {
 int time = Integer.MAX_VALUE ; ;
 for(int i = 0 ; i < experimentNum ; i++) {
   int times = bellmanford4() ;
   time = min(time, times) ;
 }
 println(leng4()+","+time) ;
}
int leng4() {
    int count = 0 ;
    for(LabelSolution ps : pareto1)
     count += ps.dummy.size() ;
    return count ;
  }
   int leng() {
    int count = 0 ;
    for(PathVec ps : pareto)
     count += ps.leng() ;
    return count ;
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
  int[][][] instanceText1(int[] m) {
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
