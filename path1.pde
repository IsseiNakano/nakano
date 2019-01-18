
class Vector2 {
  int[] pathweight ;
  Vector2 pre ;
  Vector2 follow ;
  int prenode ;
  Vector2 nodevec ;
  Vector2() {
    pre = this ;
    follow = this ;
  }
  Vector2(int[] weight, int node) {
    pathweight = weight ;
    prenode = node ;
  }
  Vector2(int[] weight, int node, Vector2 vec) {
    pathweight = weight ;
    prenode = node ;
    nodevec = vec ;
  }
  void add(Vector2 a) {
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
  void addAll(Vector2 a, Vector2 b) {
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
    for (Vector2 v = follow ; v != this ; v = v.follow) {
      int status = v.dominate(u) ;
      if (status <= 1) return false ;
      if (status == 2) v.remove() ;
    }
    return true ;
  }
  void removeObject(int k) {
    for (Vector2 v = follow ; v != this ; v = v.follow)
      v.pathweight[k] = 0 ;
  }
  void removeObject(Vector2 k) {
    for (Vector2 v = follow ; v != this ; v = v.follow)
      k.removecheck(v.pathweight) ;
  }
  void removecheck(int[] u) {
    for (Vector2 v = follow ; v != this ; v = v.follow) {
      int status = v.dominate(u) ;
      if (status == 2) v.remove() ;
    }
  }
}
 class PathVec2 {
  Vector2 dummy ;
  int index ;
  int[][] w ;
  Vector2 upd ;
  Vector2 vs ;
  PathVec2() {
  }
  PathVec2(int i, int[][] wei) {
    index = i ;
    w = wei ;
    dummy = new Vector2() ;
    upd = new Vector2() ;
    vs = new Vector2() ;
  }
  boolean paretoConstruction(PathVec2 pps) {
    boolean flag = false ;
    for(Vector2 s = pps.upd.follow ; s != pps.upd ; s = s.follow) {
      int[] path = s.calculation(w[pps.index]) ;
      if(check(path))
        if(negativeCheck(path, pps.index, s)) {
          vs.add(new Vector2(path, pps.index, s)) ;
          flag = true ;
        }
    }
    return flag ;
  }
  boolean check(int[] path) {
    if (dummy.check(path))
      if (upd.check(path))
        if (vs.check(path))
          return true ;
    return false ;
  }
  boolean negativeCheck(int[] path, int ppsindex, Vector2 s) {
    boolean flag = true ;
    for(Vector2 v = s ; v.prenode != -1 ; v = v.nodevec)
      if(v.prenode == ppsindex)
        for(int i = 0 ; i < objective ; i++)
          if(v.pathweight[i] > path[i]) {
            negativeobj[i] = true ;
            flag = false ;
          }
    return flag ;
  }
  int leng() {
    int count = 0 ;
    for(Vector2 s = dummy.follow ; s != dummy ; s = s.follow)
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
  void removeObject(int k) {
    for(int i = 0 ; i < w.length ; i++)
      w[i][k] = 0 ;
    dummy.removeObject(k) ;
    upd.removeObject(k) ;
    vs.removeObject(k) ;
    removeObject() ;
  }
  void removeObject() {
    dummy.removeObject(dummy) ;
    upd.removeObject(upd) ;
    vs.removeObject(vs) ;
    dummy.removeObject(upd) ;
    dummy.removeObject(vs) ;
    upd.removeObject(dummy) ;
    upd.removeObject(vs) ;
    vs.removeObject(dummy) ;
    vs.removeObject(upd) ;
  }
}
