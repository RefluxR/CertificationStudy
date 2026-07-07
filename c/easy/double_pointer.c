#include <stdio.h>

struct dat{
    int x;
    int y;
};

int main(){
    struct dat a[] = {{1, 2}, {3, 4}, {5, 6}};

    struct dat* ptr = a;
    struct dat** pptr = &ptr;
    // 만약 dat * pptr을 해버리면
    // pptr은 a의 주소값이 아니라
         // ptr의 주소값을 가지게 됨


    // *pptr = ptr의 내부값
    // ptr의 내부값 = a의 주소
    // a[1]
    (*pptr)[1] = (*pptr)[2];
    printf("%d 그리고 %d", a[1].x, a[1].y);

    printf("\n");
    printf(" a    = %p\n", (void*)(a));   // a 변수는 주소값이 근본 데이터임
    printf(" ptr  = %p\n", (void*)(ptr)); // 결과물이 a와 같음   ---> &ptr 해버리면 결과물인 a가 아니라 ptr 변수의 주소를 출력

    printf("*pptr = %p\n", (void*)(*pptr));  // pptr의 값 -> ptr -> a [ox7ff]----- 이걸 * 해버리니까 {1,2}

    printf("&pptr = %p\n", (void*)(&pptr));  //  
    printf(" pptr = %p\n", (void*)(pptr));  //  pptr의 값 -> ptr 
                                            // pptr은 역참조를 안했으니 a까지 도달 못함
                                            // 그래서 ptr의 주소값을 가짐  
    printf("&ptr  = %p\n", (void*)(&ptr));
    return 0;
}

