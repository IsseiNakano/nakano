class PathVec3 {
  Vector1 dummy ;
  int index ;
  int[][] w ;
  Vector1 upd ;
  Vector1 vs ;
  int mini[] ;
  Vector1 minis ;
  PathVec3 minipre ;
  PathVec3() {
  }
  PathVec3(int i, int[][] wei) {
    index = i ;
    w = wei ;
    dummy = new Vector1() ;
    upd = new Vector1() ;
    vs = new Vector1() ;
    minis = new Vector1() ;
    mini = new int[objective] ;
    minipre = sss3 ;
  }
  void add(int[] wei) {
    dummy.pre.add(new Vector1(wei)) ;
  }
  boolean paretoConstruction(PathVec3 pps) {
    boolean flag = false ;
    for(Vector1 s = pps.upd.follow ; s != pps.upd ; s = s.follow) {
      int[] path = s.calculation(w[pps.index]) ;
      // if (minis.domi(path))
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
    minis.clear() ;
    minipre = sss3 ;
  }
  int negativeCycleCheck(PathVec3 pps, int k) {
    if(mini[k] > pps.mini[k] + w[pps.index][k]) {
      int[] value = new int[objective];
      for(int i = 0 ; i < objective ; i++)
        value[i] = pps.mini[i] + w[pps.index][i] ;
      mini = value ;
      if(minipre == pps) return 3 ;
      minipre = pps ;
      return 2 ;
    }
    if(mini[k] == pps.mini[k] + w[pps.index][k]) {
      for(int i = 0 ; i < objective ; i++) {
        if(mini[i] > pps.mini[i] + w[pps.index][i]) {
          int[] value = new int[objective];
          for(int j = 0 ; j < objective ; j++)
            value[j] = pps.mini[j] + w[pps.index][j] ;
          mini = value ;
          if(minipre == pps) return 3 ;
          minipre = pps ;
          return 2 ;
        } else if (mini[i] < pps.mini[i] + w[pps.index][i]) {
          return 1 ;
        }
      }
    }
    return 1 ;
  }
  void removeObject(int k) {
    for(int i = 0 ; i < w.length ; i++)
      w[i][k] = 0 ;
  }
  void miniZero() {
    int[] value = new int[objective];
    for(int i = 0 ; i < objective ; i++)
      value[i] = 0 ;
    mini = value ;
  }
  void miniClear() {
    int[] value = new int[objective];
    for(int i = 0 ; i < objective ; i++)
      value[i] = maxint ;
    mini = value ;
  }
  void conversion() {
    if(minis.check(mini))
      minis.add(new Vector1(mini)) ;
  }
  void updAddMinis() {
    upd.addAll(minis.follow, minis.pre) ;
  }
  int minileng() {
    int count = 0 ;
    for(Vector1 s = minis.follow ; s != minis ; s = s.follow)
      count++ ;
    return count ;
  }
  void minishow() {
    for(Vector1 s = minis.follow ; s != minis ; s = s.follow)
      println(s.pathweight) ;
  }
}
