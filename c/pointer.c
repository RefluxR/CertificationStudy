#include <stdio.h>
//////////////////////////////////////////////////////////////////////////////////////////    %p로 주소 출력법 (void*)
int point_1(){
    static int num1 = 10;
    // %p는 모든 자료형에 대한 포인터를 출력해야하기 때문에
    // void*로 형변환을 해주어야 한다.
    // 그렇지 않으면 %pf(float), %pd(double) 처럼, 모든 자료형에 대한 포인터를 만들어야 하기 때문에 번거로워진다.
    printf("%p\n", (void*)&num1);
    return 0;   

}
///////////////////////////////////////////////////////////////////////////////////////////  선언법
void point_2(){
    int *ptr;
    int num2 = 20;
    ptr = &num2;

    printf("[ptr] 실제 num2의 주소: ptr%p\n", (void *)ptr); // 
    printf("[*ptr] num2의 값: %d\n", *ptr);

    *ptr = 30; // 포인터를 이용하여 num2의 값을 변경
    printf("[*ptr = 30] 포인터로 인해 \nnum2의 변경된 값: %d\n", num2);

    printf("역참조(*)라는 것은... 포인터가 가리키는 주소에 (접근)하여 그 주소에 저장된 값을 읽거나 변경하는 것을 의미.\n");
}
///////////////////////////////////////////////////////////////////////////////////////////     문자열 리터럴
void point_3(){

    char * string_p = "ABCD"; // &사용하지 않고 문자열 리터럴을 집어넣을 수 있는 이유는
                              // 문자열 리터럴은 컴파일러에 의해 자동으로 메모리의 특정 위치에 저장되고
                                // 그 위치의 주소가 string_p에 할당되기 때문

    int num = 10;
    int * int_p = &num; 
    

    printf("string_p에 저장된 주소값 string_p : %p\n", (void *)string_p);
    printf("string_p가 가리키는 문자열이자 주소 string_p : %s\n", string_p);
    printf("string_p가 가리키는 문자열의 첫번째 문자 *string_p : %c\n", *string_p);
    printf("string_p가 가리키는 문자열의 두번째 문자 *(string_p + 1) : %c\n", *(string_p + 1)); // *()를 사용해 주소의 값을 증가시켜 
                                                                                              // 다음 문자인덱스 접근
                                                                                              // 이렇게 하면 포인터 산술 연산이 발생

    printf("문자열 리터럴과 다르게 정수형 포인터는\n");
    printf(" %d", (*int_p + 1));
    printf("\n %d", num + 2 );
    printf("\n 이렇게 하면 int형 크기(4바이트)만큼 증가된 주소의 값을 읽어오게 된다.\n");
    // 따라서 포인터 산술 연산은 포인터가 가리키는 자료형의 크기에 따라 주소 증가 폭이 달라진다.


    printf("\n 이와 다르게 문자열 리터럴은 char형(1바이트) 크기만큼 증가된 주소의 값을 읽어오게 된다.");
    // 따라서 A 다음에 B가 출력된다.

    char text[4] = "ABCD";
    printf("\n text = %s", text );
    printf("\n *text(역참조) = %c", *text );
    printf("\n *text + 1 = %c", *(text + 1));
    printf("\n *text + 2 = %c", *(text + 2));

    // 존나 중요함!!!!
    // 모든 포인터 산술 연산(ptr + N, ptr - N)은 포인터가 선언될 때 정해진 자료형에 의해 두 가지가 결정된다.
}
void point_4(){
    // 배열 자체에 관심을 가져보면
    
    char text[5] = "ABCDE";
    int arr[5] = {1,2,3,4,5};

    char * text_p = text; // char * text_p = text[0];
    int * arr_p = arr; // int * arr_p = arr[0];

    // 여기서 중요한건

    // 왜 * text_p = &text가 아니냐?  

    // text는 text[0]이랑 똑같다
    // text는 "ABCDE" 전체를 나타내는 종합적인 변수가 아니라
    // text[0] 이라는 요소의 주소다...

    // 그래서 &text = "하... 그래서 1번째 요소야? 2번째 요소야? 뭐야?!!" 
    // 이렇게 돼버려서 어색해지기 때문 


    printf("(void*)&arry    = %p", (void*)&arr);
    printf("\n(void*)&arry[0] = %p\n", (void*)&arr[0]);
    
    for(int i = 0; i < 5; i++){
        printf("%d", * (arr_p + i)); // arr[i]
        //printf("%p", (void*)&arr[i] ); 
    }

    printf("\n");
    

    for(int i = 0; i < 5; i++){
        printf("%c", * (text_p + i)); // text[i]
    }

}

int main(){

    point_4();
    return 0;

}