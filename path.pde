class Vector1 {
  int[] pathweight ;
  Vector1 pre ;
  Vector1 follow ;
  Vector1() {
    pre = this ;
    follow = this ;
  }
  Vector1(int[] weight) {
    pathweight = weight ;
  }
  void add(Vector1 a) {
    a.pre = this ;
    follow.pre = a ;
    a.follow = follow ;
    follow = a ;
  }
  void remove() {
    pre.follow = follow ;
    follow.pre = pre ;
  }
  void clear() {
    pre = this ;
    follow = this ;
  }
  boolean isEmpty(){
    return follow == this ;
  }
  void addAll(Vector1 a, Vector1 b) {
    pre.follow = a ;
    a.pre = pre ;
    pre = b ;
    b.follow = this ;
  }
  int[] calculation(int[] weight) {
    int[] value = new int[objective];
    for(int i = 0 ; i < objective ; i++)
      value[i] = pathweight[i] + weight[i] ;
    return value ;
  }
  int dominate(int[] u) {
    int status = 0 ;
    for (int k = 0 ; k < objective ; k++) {
      int d = u[k] - pathweight[k] ;
      if (d > 0) status |= 1 ;
      else if (d < 0) status |= 2 ;
      if (status == 3) break ;
    }
    return status ;
  }
  boolean check(int[] u) {
    for (Vector1 v = follow ; v != this ; v = v.follow) {
      int status = v.dominate(u) ;
      if (status <= 1) return false ;
      if (status == 2) v.remove() ;
    }
    return true ;
  }
  boolean eqweight(int[] u) {
  for(int i = 0 ; i < objective ; i++)
    if(pathweight[i] != u[i])
      return false ;
  return true ;
}
boolean addInt(int[] u) {
  for(Vector1 v = follow ; v != this ; v = v.follow)
    if(v.eqweight(u))
      return false ;
  return true ;
}
boolean domi(int[] u) {
  for(Vector1 v = follow ; v != this ; v = v.follow)
    if(!v.domimi(u)) return false ;
  return true ;
}
boolean domimi(int[] u) {
  for(int i = 0 ; i < objective ; i++)
    if(pathweight[i] > u[i])
      return true ;
  return false ;
}
}

class PathVec1 {
  Vector1 dummy ;
  int index ;
  int[][] w ;
  Vector1 upd ;
  Vector1 vs ;
  int mini ;
  PathVec1 minipre ;
  PathVec1() {
  }
  PathVec1(int i, int[][] wei) {
    index = i ;
    w = wei ;
    dummy = new Vector1() ;
    upd = new Vector1() ;
    vs = new Vector1() ;
    minipre = sss ;
  }
  void add(int[] wei) {
    dummy.pre.add(new Vector1(wei)) ;
  }
  boolean paretoConstruction(PathVec1 pps) {
    boolean flag = false ;
    for(Vector1 s = pps.upd.follow ; s != pps.upd ; s = s.follow) {
      int[] path = s.calculation(w[pps.index]) ;
      if (dummy.check(path))
      if (upd.check(path))
      if (vs.check(path)) {
        vs.add(new Vector1(path)) ;
        flag = true ;
      }
    }
    return flag ;
  }
  int leng() {
    int count = 0 ;
    for(Vector1 s = dummy.follow ; s != dummy ; s = s.follow)
      count++ ;
    return count ;
  }
  void update() {
    if(!upd.isEmpty()) {
      dummy.addAll(upd.follow, upd.pre) ;
      upd.clear() ;
    }
    if(!vs.isEmpty()) {
      upd.addAll(vs.follow, vs.pre) ;
      vs.clear() ;
    }
  }
  void reset() {
    dummy.clear() ;
    upd.clear() ;
    vs.clear() ;
  }
  int negativeCycleCheck(PathVec1 pps, int k) {
    if(mini > pps.mini + w[pps.index][k]) {
      mini = pps.mini + w[pps.index][k] ;
      if(minipre == pps) return 3 ;
      minipre = pps ;
      return 2 ;
    }
    return 1 ;
  }
  void removeObject(int k) {
    for(int i = 0 ; i < w.length ; i++)
      w[i][k] = 0 ;
  }
  void miniZero() {
    mini = 0 ;
  }
  void miniClear() {
    mini = maxint ;
  }
}
