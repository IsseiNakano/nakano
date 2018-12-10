// 完全グラフのためグラフを使用していない（頂点はint:頂点数nの時０ 〜 n-1）
//1：単一目的で閉路検出，そこで求めたパレート解は保存しない
//2：探索途中で閉路検出，閉路検出のたびにパレート解のメンテ必要あり
//3：単一目的で閉路検出，求めたパレート解を元に探索開始
String dir = "/Users/nakano/Desktop/instanceData/" ;
String dirF = "/Users/nakano/Desktop/data500/" ;
final int nodenum = 500 ;
final int bound = 300 ;
final int objective = 3 ;
final int experimentNum = 10 ;
final int maxint = 99999 ;
boolean negativeobj[] = new boolean[objective] ;
PathVec1 sss = new PathVec1() ;
PathVec3 sss3 = new PathVec3() ;

void setup() {
  // dir = "../../data/" ;
  int[] m = {0,1,2} ;
  ParetoSolution p = new ParetoSolution(m) ;
  p.update() ;
  exit() ;
}
