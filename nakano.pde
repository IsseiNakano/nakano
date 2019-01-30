
// 完全グラフのためグラフを使用していない（頂点はint:頂点数nの時０ 〜 n-1）
<<<<<<< HEAD
=======
//1：単一目的で閉路検出，そこで求めたパレート解は保存しない
//2：探索途中で閉路検出，閉路検出のたびにパレート解のメンテ必要あり
//3：単一目的で閉路検出，求めたパレート解を元に探索開始
>>>>>>> parent of 4c5424c... 提案と従来比較
String dir = "/Users/nakano/Desktop/data/" ;
int nodenum = 0 ;
int bound = 0 ;
final int objective = 3 ;
final int experimentNum = 3 ;
final int maxint = 99999 ;
<<<<<<< HEAD
=======
boolean negativeobj[] = new boolean[objective] ;
PathVec1 sss = new PathVec1() ;
PathVec3 sss3 = new PathVec3() ;

>>>>>>> parent of 4c5424c... 提案と従来比較

void setup() {

 PrintWriter pw ;
<<<<<<< HEAD
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
=======
 pw = createWriter(dir + "negative.csv") ;
 ParetoSolution p ;

for(int s = 0 ; s < 2 ; s++)
 for(int i = 1 ; i < 11 ; i++)
   for(int j = 1 ; j < 11 ; j++) {
     nodenum = 100 * i ;
     bound = 100 * j ;
     for(int k = 0 ; k < 10 ; k++) {
       p = new ParetoSolution(s) ;
       p.update1() ;
       pw.println
       (nodenum+","+bound+","+s+","+p.leng1()+",,"+p.update1()+","+p.update2()+","+p.update3()) ;
>>>>>>> parent of 4c5424c... 提案と従来比較
     }
   }

 pw.flush() ;
 pw.close() ;
 exit() ;
}
