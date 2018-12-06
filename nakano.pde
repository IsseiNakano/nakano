// 完全グラフのためグラフを使用していない（頂点はint:頂点数nの時０ 〜 n-1）
String dir = "/Users/nakano/Desktop/instanceData/" ;
String dirF = "/Users/nakano/Desktop/data500/" ;
final int nodenum = 100 ;
final int bound = 50 ;
final int objective = 3 ;
final int experimentNum = 1 ;
final int maxint = 99999 ;
boolean negativeobj[] = new boolean[objective] ;

void setup() {
// dir = "../../data/" ;
  int[] m = {0,1,2} ;
  ParetoSolution p = new ParetoSolution(m) ;
  p.polynomial() ;
  exit() ;
}
