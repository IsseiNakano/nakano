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
class Vectorl {
  int[] pathweight ;
  Vectorl pre ;
  Vectorl follow ;
  Vectorl() {
    pre = this ;
    follow = this ;
  }
  Vectorl(int[] weight) {
    pathweight = weight ;
  }
  void add(Vectorl a) {
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
  void addAll(Vectorl a, Vectorl b) {
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
    for (Vectorl v = follow ; v != this ; v = v.follow) {
      int status = v.dominate(u) ;
      if (status <= 1) return false ;
      if (status == 2) v.remove() ;
    }
    return true ;
  }
}
class PathVecl {
 Vectorl dummy ;
 int index ;
 int[][] w ;
 boolean update ;
 PathVecl() {
 }
 PathVecl(int i, int[][] wei) {
   index = i ;
   w = wei ;
   dummy = new Vectorl() ;
 }
 void add(int[] wei) {
   dummy.pre.add(new Vectorl(wei)) ;
 }
 boolean paretoConstruction(PathVecl pps) {
   if(!update) return false ;
   boolean flag = false ;
   for(Vectorl s = dummy.follow ; s != dummy ; s = s.follow) {
     int[] path = s.calculation(w[pps.index]) ;
     if (pps.check(path)) {
       pps.add(path) ;
       pps.update = true ;
       flag = true ;
     }
   }
   return flag ;
 }
 int leng() {
   int count = 0 ;
   for(Vectorl s = dummy.follow ; s != dummy ; s = s.follow)
     count++ ;
   return count ;
 }
 boolean check(int[] u) {
   for (Vectorl v = dummy.follow ; v != dummy ; v = v.follow) {
     int status = v.dominate(u) ;
     if (status <= 1) return false ;
     if (status == 2)
       v.remove() ;
   }
   return true ;
 }
 void reset() {
   dummy.clear() ;
 }
}
