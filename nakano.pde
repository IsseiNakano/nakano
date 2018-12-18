// 完全グラフのためグラフを使用していない（頂点はint:頂点数nの時０ 〜 n-1）
//1：通常（頂点<-解，双方向リスト）
//2：解->他の頂点
//3：配列
//4：ArrayList
String dir = "/Users/nakano/Desktop/data/" ;
int nodenum = 0 ;
int bound = 0 ;
final int objective = 3 ;
final int experimentNum = 3 ;
final int maxint = 99999 ;
int orderlength = 0 ;
boolean negativeobj[] = new boolean[objective] ;

 void setup() {

  PrintWriter pw ;
  pw = createWriter(dir + "devise.csv") ;
  ParetoSolution p ;

  for(int i = 1 ; i < 11 ; i++)
    for(int j = 1 ; j < 11 ; j++) {
      nodenum = 100 * i ;
      bound = 100 * j ;
      for(int k = 0 ; k < 10 ; k++) {
        p = new ParetoSolution() ;
        p.update1() ;
        orderlength = (int)(p.leng()*1.1) ;
        pw.println
        (nodenum+","+bound+","+p.leng()+",,"+p.update1()+","+p.update2()+","+p.update3()+","+p.update4()) ;
      }
    }

  pw.flush() ;
  pw.close() ;
  exit() ;
 }
