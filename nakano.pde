
// 完全グラフのためグラフを使用していない（頂点はint:頂点数nの時０ 〜 n-1）
String dir = "/Users/nakano/Desktop/data/" ;
int nodenum = 0 ;
int bound = 0 ;
final int objective = 3 ;
final int experimentNum = 1 ;
final int maxint = 99999 ;

void setup() {

 PrintWriter pw ;
 pw = createWriter(dir + "past.csv") ;
 ParetoSolution p ;

 for(int i = 1 ; i < 6 ; i++)
   for(int j = 1 ; j < 6 ; j++) {
     nodenum = 50 * i ;
     bound = 50 * j ;
     for(int k = 0 ; k < 10 ; k++) {
       p = new ParetoSolution() ;
       p.labeling() ;
       pw.println
       (nodenum+","+bound+","+p.lengl()+",,"+p.dijkstra()+","+p.polynomial()+","+p.labeling()) ;
     }
   }

 pw.flush() ;
 pw.close() ;
 exit() ;
}
