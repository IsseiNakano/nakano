
// 完全グラフのためグラフを使用していない（頂点はint:頂点数nの時０ 〜 n-1）
//1：通常（頂点<-解，双方向リスト）
//2：解->他の頂点
//3：配列
//4：ArrayList
//5
String dir = "/Users/nakano/Desktop/instanceData/" ;
String dirF = "/Users/nakano/Desktop/data500/" ;
final int nodenum = 500 ;
final int bound = 300 ;
final int objective = 3 ;
final int experimentNum = 3 ;
final int maxint = 99999 ;
final int orderlength = 160000 ;
boolean negativeobj[] = new boolean[objective] ;

 void setup() {
  // dir = "../../data/" ;
  int[] m = {0,1,2} ;
  ParetoSolution p = new ParetoSolution(m) ;
  p.update1() ;
  p.update2() ;
  p.update3() ;
  p.update4() ;
  exit() ;
 }
