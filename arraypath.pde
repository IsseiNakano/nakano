class Label {
  int[] pathweight ;
  Label() {
  }
  Label(int[] w) {
    pathweight = w ;
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
}

class PathLabel extends ArrayList<Label> {
  PathLabel() {
  }
  boolean check(int[] u) {
    PathLabel removeset = new PathLabel() ;
    for(Label v : this) {
      int status = v.dominate(u) ;
      if (status <= 1) return false ;
      if (status == 2) removeset.add(v) ;
    }
    for(Label v : removeset)
      this.remove(v) ;
    return true ;
  }
}

class LabelSolution {
  int index ;
  int[][] w ;
  PathLabel dummy ;
  PathLabel upd ;
  PathLabel vs ;
  LabelSolution() {
  }
  LabelSolution(int i, int[][] wei) {
    index = i ;
    w = wei ;
    dummy = new PathLabel() ;
    upd = new PathLabel() ;
    vs = new PathLabel() ;
  }
  void add(int[] wei) {
    dummy.add(new Label(wei)) ;
  }
  boolean paretoConstruction(LabelSolution pps) {
    boolean flag = false ;
    for(Label s : pps.upd) {
      int[] path = s.calculation(w[pps.index]) ;
      if (dummy.check(path))
      if (upd.check(path))
      if (vs.check(path)) {
        vs.add(new Label(path)) ;
        flag = true ;
      }
    }
    return flag ;
  }
  void update() {
    if(!upd.isEmpty()) {
      dummy.addAll(upd) ;
      upd.clear() ;
    }
    if(!vs.isEmpty()) {
      upd.addAll(vs) ;
      vs.clear() ;
    }
  }
  void reset() {
    dummy.clear() ;
    upd.clear() ;
    vs.clear() ;
  }
}
