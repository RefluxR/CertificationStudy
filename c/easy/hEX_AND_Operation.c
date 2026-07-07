#include <stdio.h>

typedef struct student {
    char* name;
    int score[3];
} Student;

int dec(int enc){
    return enc & 0xA5;
}   // 160 을 2진수로 변환시켜서 and 연산 시켜야함
    // 

int sum(Student* p){
    return dec(p->score[0]) + dec(p->score[1]) + dec(p->score[2]);
}

int main() {
    Student s[2] = { "Kim", {0xA0, 0xA5, 0xDB}, "Lee", {0xA0, 0xED, 0x81} };
                        //  KIM  [160]  [165]   (16 *13) + 11 = [219]
                        //  Lee  [160]  [237]   (16 * 8) + 1 =  [129]
    Student* p = s;
    int result = 0;
 
    for (int i = 0; i < 2; i++) {
        result += sum(&s[i]);
    }
    printf("%d", result);
    return 0;
}
