#include <stdio.h>
char Data[5] = {'B', 'A', 'D', 'E'};
// 각각 정수로   66    65   68   69   ----- 아스키코드로 생각해
char c;
 
int main(){
    int i, temp, temp2;
 
    c = 'C'; // 67
    printf("%d\n", Data[3]-Data[1]); // 어차피 알파벳 순서만 알면 결과 똑같음
 
    for(i=0;i<5;++i){
        if(Data[i]>c) // i = 2
            break;
    }
 
    temp = Data[i];  // temp=D
    Data[i] = c;     // {B A C E}
    i++;             // i = 3
 
    for(;i<5;++i){       //   i 3         i 4
        temp2 = Data[i]; // t2 = E   // t2 = null
        Data[i] = temp;  // {BACD}   // {BACDE}
        temp = temp2;    // t = E    // t = null
    }
 
    for(i=0;i<5;i++){
        printf("%c", Data[i]);    
    }
}
