#include<stdio.h>
int abs(int x){
  return x>0?x:-x;
}
int min_abs_remainder(int y,int x){
  if(x==0){
    return y;
  }
  int r = (y % abs(x) + abs(x)) % abs(x);
  if(r>abs(x)/2){
    return r-abs(x);
  }
  return r;
}
//this function is to get the greatest commom factor of two integer. 
int gcd(int x,int y){
  if(abs(x)>abs(y)){
//the function int abs(int a) returns the absolute value of a.
    int temp = x;
    x = y;
    y = temp;
  }
  if(x == 0){
    return abs(y);
  }
  int r=min_abs_remainder(y,x);
  int k=(y-r)/x;
  printf("%d &= %d &\\times %d &+ %d\n",y,k,x,r);
  return gcd(x,min_abs_remainder(y,x));
//the return value of function min_abs_remainder is the least-abs remainder of x divide y, which we have proved is less or equal to abs(x)
}
int main(){
  printf("%d",gcd(76501,9719));
  return 0;
}
