class Vector {
  int[] pathweight ;
  Vector pre ;
  Vector follow ;
  int index ;
  Vector() {
    pre = this ;
    follow = this ;
  }
  Vector(int[] weight , int ind) {
    pathweight = weight ;
    index = ind ;
  }
  void add(Vector a) {
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
  boolean check(Vector u) {
    for (Vector v = this.follow ; v != this ; v = v.follow) {
      if(v.index == u.index) {
        int status = v.dominate(u.pathweight) ;
        if (status <= 1) return false ;
        if (status == 2)
          v.remove() ;
      }
    }
    return true ;
  }
  int leng() {
    int count = 0 ;
    for(Vector s = this.follow ; s != this ; s = s.follow)
      count++ ;
    return count ;
  }
}
