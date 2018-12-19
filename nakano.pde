// 完全グラフのためグラフを使用していない（頂点はint:頂点数nの時０ 〜 n-1）
//labeling：ラベル付けアルゴリズム
//propose1：提案解法１
//propose2：提案解法２
//s
//0:ランダム
//1:頂点から出て行く辺の相関係数がかなり強い
//2:頂点に入ってくる辺の相関係数がかなり強い
//3:辺の相関係数がかなり強い
//4:頂点から出て行く辺の相関係数が強い
//5:頂点に入ってくる辺の相関係数が強い
//6:辺の相関係数が強い
String dir = "/Users/nakano/Desktop/data/" ;
int nodenum = 0 ;
int bound = 0 ;
final int objective = 3 ;
final int experimentNum = 1 ;
final int maxint = 99999 ;
int removecount = 0 ;
int[][][] weight ;
int[][][] weight1 ;

void setup() {

 PrintWriter pw ;
 pw = createWriter(dir + "comparison.csv") ;
 ParetoSolution p ;
 float ina ;
 float inb ;
 float inc ;
 float outa ;
 float outb ;
 float outc ;
 float inave ;
 float outave ;

for(int s = 0 ; s < 7 ; s++)
 for(int i = 1 ; i < 4 ; i++)
   for(int j = 1 ; j < 4 ; j++) {
     nodenum = 100 * i ;
     bound = 100 * j ;
     for(int k = 0 ; k < 1 ; k++) {
       weightset(s) ;
       ina = correlationj(0,1) ;
       inb = correlationj(1,2) ;
       inc = correlationj(0,2) ;
       outa = correlationi(0,1) ;
       outb = correlationi(1,2) ;
       outc = correlationi(0,2) ;
       inave = (ina + inb + inc)/3 ;
       outave = (outa + outb + outc)/3 ;
       p = new ParetoSolution() ;
       p.propose2() ;
       pw.println
       (nodenum+","+bound+","+s+","+p.leng()+",,"+
       outave+","+outa+","+outb+","+outc+",,"+
       inave+","+ina+","+inb+","+inc+",,"+
       p.labeling()+","+removecount+",,"+
       p.propose1()+","+removecount+",,"+
       p.propose2()+","+removecount) ;
     }
   }

 pw.flush() ;
 pw.close() ;
 exit() ;
}

void weightset(int s) {
  weight = new int[nodenum][nodenum][objective] ;
  weight1 = new int[nodenum][nodenum][objective] ;
  if(s == 0) {
  for(int i = 0 ; i < nodenum ; i++)
    for(int j = 0 ; j < nodenum ; j++)
      for(int k = 0 ; k < objective ; k++)
        weight1[i][j][k] = (int)random(bound) ;
  } else if(s == 1) {
    for(int i = 0 ; i < nodenum ; i++) {
      int l = (int)random(bound/2) ;
      for(int j = 0 ; j < nodenum ; j++)
        for(int k = 0 ; k < objective ; k++)
          weight1[i][j][k] = (int)random(bound/2) + l ;
      }
  } else if(s == 2) {
    for(int i = 0 ; i < nodenum ; i++) {
      int l = (int)random(bound/2) ;
      for(int j = 0 ; j < nodenum ; j++)
        for(int k = 0 ; k < objective ; k++)
          weight1[j][i][k] = (int)random(bound/2) + l ;
    }
  } else if(s == 3) {
    for(int i = 0 ; i < nodenum ; i++)
      for(int j = 0 ; j < nodenum ; j++) {
        int l = (int)random(bound/2) ;
        for(int k = 0 ; k < objective ; k++)
          weight1[i][j][k] = (int)random(bound/2) + l ;
      }
  } else if(s == 4) {
    for(int i = 0 ; i < nodenum ; i++) {
      int l = (int)random(bound/2) ;
      for(int j = 0 ; j < nodenum ; j++)
        for(int k = 0 ; k < objective ; k++)
          if(k == 2) weight1[i][j][k] = (int)random(bound/2) ;
          else weight1[i][j][k] = (int)random(bound/2) + l ;
      }
  } else if(s == 5) {
    for(int i = 0 ; i < nodenum ; i++) {
      int l = (int)random(bound/2) ;
      for(int j = 0 ; j < nodenum ; j++)
        for(int k = 0 ; k < objective ; k++)
        if(k == 2) weight1[j][i][k] = (int)random(0 , bound) ;
        else weight1[j][i][k] = (int)random(0 , bound) + l ;
      }
  } else if(s == 6) {
    for(int i = 0 ; i < nodenum ; i++)
      for(int j = 0 ; j < nodenum ; j++) {
        int l = (int)random(bound/2) ;
        for(int k = 0 ; k < objective ; k++)
        if(k == 2) weight1[i][j][k] = (int)random(bound/2) ;
        else weight1[i][j][k] = (int)random(bound/2) + l ;
      }
  }
  for(int i = 0 ; i < nodenum ; i++)
    for(int j = 0 ; j < nodenum ; j++)
      for(int k = 0 ; k < objective ; k++)
        weight[j][i][k] = weight1[i][j][k] ;
}

float correlationi(int a , int b) {
  return covariancei(a,b) / (standarddeviationi(a) * standarddeviationi(b)) ;
}

float correlationj(int a , int b) {
  return covariancej(a,b) / (standarddeviationj(a) * standarddeviationj(b)) ;
}

float covariancei(int a , int b) {
  float averagea = 0 ;
  float averageb = 0 ;
  float[] aveia = aaveragei(a) ;
  float[] aveib = aaveragei(b) ;
  for(int i = 0 ; i < nodenum ; i++)
    averagea += aveia[i] ;
  averagea = averagea / nodenum ;
  for(int i = 0 ; i < nodenum ; i++)
    averageb += aveib[i] ;
  averageb = averageb / nodenum ;
  float dispersion = 0 ;
  for(int i = 0 ; i < nodenum ; i++)
    dispersion += (aveia[i] - averagea) * (aveib[i] - averageb) ;
  return dispersion / nodenum ;
}

float covariancej(int a , int b) {
  float averagea = 0 ;
  float averageb = 0 ;
  float[] aveja = aaveragej(a) ;
  float[] avejb = aaveragej(b) ;
  for(int j = 0 ; j < nodenum ; j++)
    averagea += aveja[j] ;
  averagea = averagea / nodenum ;
  for(int j = 0 ; j < nodenum ; j++)
    averageb += avejb[j] ;
  averageb = averageb / nodenum ;
  float dispersion = 0 ;
  for(int j = 0 ; j < nodenum ; j++)
    dispersion += (aveja[j] - averagea) * (avejb[j] - averageb) ;
  return dispersion / nodenum ;
}

float standarddeviationi(int a){
  return sqrt(ddispersioni(a)) ;
}

float standarddeviationj(int a){
  return sqrt(ddispersionj(a)) ;
}

float ddispersionj(int a) {
  float average = 0 ;
  float[] avej = aaveragej(a) ;
  for(int j = 0 ; j < nodenum ; j++)
    average += avej[j] ;
  average = average / nodenum ;
  float dispersion = 0 ;
  for(int j = 0 ; j < nodenum ; j++)
    dispersion += sq(avej[j] - average) ;
  return dispersion / nodenum ;
}

float ddispersioni(int a) {
  float average = 0 ;
  float[] avei = aaveragei(a) ;
  for(int i = 0 ; i < nodenum ; i++)
    average += avei[i] ;
  average = average / nodenum ;
  float dispersion = 0 ;
  for(int i = 0 ; i < nodenum ; i++)
    dispersion += sq(avei[i] - average) ;
  return dispersion / nodenum ;
}

float[] aaveragei(int a){
  float[] average = new float[nodenum] ;
  for(int i = 0 ; i < nodenum ; i++)
    average[i] = aaverageii(i , a) ;
  return average ;
}

float[] aaveragej(int a){
  float[] average = new float[nodenum] ;
  for(int j = 0 ; j < nodenum ; j++)
    average[j] = aaveragejj(j , a) ;
  return average ;
}

float aaveragejj(int j , int a){
  float sum = 0 ;
  for(int i = 0 ; i < nodenum ; i++)
    sum += weight1[i][j][a] ;
  return sum / nodenum ;
}

float aaverageii(int i , int a){
  float sum = 0 ;
  for(int j = 0 ; j < nodenum ; j++)
    sum += weight1[i][j][a] ;
  return sum / nodenum ;
}
