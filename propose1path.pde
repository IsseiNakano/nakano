class PathVecp {
  Vector dummy ;
  int index ;
  int[][] w ;
  Vector upd ;
  PathVecp() {
  }
  PathVecp(int i, int[][] wei) {
    index = i ;
    w = wei ;
    dummy = new Vector() ;
    upd = dummy ;
  }
  void add(int[] wei) {
    dummy.pre.add(new Vector(wei)) ;
  }
  boolean paretoConstruction(PathVecp pps) {
    boolean flag = false ;
    for(Vector s = upd.follow ; s != dummy ; s = s.follow) {
      int[] path = s.calculation(w[pps.index]) ;
      if (pps.check(path)) {
        pps.add(path) ;
        flag = true ;
      }
    }
    return flag ;
  }
  int leng() {
    int count = 0 ;
    for(Vector s = dummy.follow ; s != dummy ; s = s.follow)
      count++ ;
    return count ;
  }
  boolean check(int[] u) {
    for (Vector v = dummy.follow ; v != dummy ; v = v.follow) {
      int status = v.dominate(u) ;
      if (status <= 1) return false ;
      if (status == 2) {
        if(v == upd) upd = v.pre ;
        v.remove() ;
      }
    }
    return true ;
  }
  void update() {
    upd = dummy.pre ;
  }
  void reset() {
    dummy.clear() ;
    upd = dummy ;
  }
}
