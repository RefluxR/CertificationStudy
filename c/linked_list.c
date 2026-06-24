#include <stdio.h>
#include <stdlib.h>

typedef struct Data{ // 연결 리스트를 구현
    int value;
    struct Data *next; 
    
} Data;   // typedef [자료형] [별명];
          // typedef [struct Data] [Data]


// 말이 insert지 그냥 create Data임 - 각각 노드가 연결돼있기 보다는 참조만 하는 식
Data* insert(Data* head, int value){  // insert 함수는 새로운 node를 생성해서, 이전 노드에
    Data* new_node = (Data*)malloc(sizeof(Data)); // 새로운 노드를 Data 크기에 맞게 생성
    new_node->value = value;
    new_node->next = head;
    return new_node;
}

Data* reconnect(Data* head, int value){ 
    if (head == NULL || head->value == value) return head;
    Data *prev = NULL, *curr = head;
    
    // printf("초기 head는 %d \n", head->value); //5

    while (curr != NULL && curr->value != value){  // curr가 3과 똑같아지게 만들기
        prev = curr;                              // 이걸로 뭐 새 리스트를 만들거나
        curr = curr->next;                        // 기존 리스트 연결을 끊는게 아님
    }
    
    //printf("prev는 %d \n", prev->value); // 4
    //printf("curr %d \n", curr->value); // 3

    if (curr != NULL && prev != NULL){
        prev->next = curr->next;  
        curr->next = head; // head는 5
    }
    return curr; //이렇게 해보면 답이 어떨까?
    //return head; 
}

void main(){

    Data *head = NULL, *curr;

    for (int i = 1; i <= 5; i ++)
        // ###      // head는 next와 비슷함
        head = insert(head, i); // 자동적으로 head가 초기화됨 insert 함수의 이전 return 값인, 
                                // 이전 for문 단계의 new_node(1)가 새로운 노드(2)의 heae가 됨.
                                // 따라서 1 > 2 > 3 이 아니라 null < 1 < 2 < 3 < 4 < 5 임

    printf("##################################################### ");                        
    printf("%p\n", (void*)head);                          // 5
    printf("%p\n", (void*)head->next);                    // 4
    printf("%p\n", (void*)head->next->next);              // 3
    printf("%p\n", (void*)head->next->next->next);        // 2
    printf("%p\n", (void*)head->next->next->next->next);  // 1
    printf("%p\n", (void*)head->next->next->next->next->next); // null

    printf("%d\n", head->value);
    printf("%d\n", head->next->value);
    printf("#####################################################\n");

    // 초기 값 
    head = reconnect(head, 3); // 1 < 2 < 4 < 5 < 3
                               // 3이 없어진게 아님. head 뒤로 붙여버리는거임

    for (curr = head; curr != NULL; curr = curr->next)
        printf("%d", curr->value);
    
}