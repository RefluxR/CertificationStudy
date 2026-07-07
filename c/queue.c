#include <stdio.h>
#define SIZE 3

typedef struct { 
    int a[SIZE];  
    int front;
    int rear;
} Queue;

void enq(Queue* q, int val){
    q -> a[ q -> rear] = val;
    q -> rear = (q->rear +1) % SIZE;
}

int deq(Queue* q){
    int val = q -> a[q->front];
    q -> front = (q -> front + 1) % SIZE;
    return val;
}

void main() {
    Queue q = {{0}, 0, 0};

    enq(&q, 1); enq(&q, 2); deq(&q); enq(&q, 3);
    
    int first = deq(&q);
    int second = deq(&q);
    printf("%d 그리고 %d\n", first, second);

    // deq는 값을 실제로 지우는게 아니라. front 위치값만 바꾼다 -> 값 보존된다.


    printf("rear = %d\n", q.rear);
    printf("front = %d\n", q.front);
    printf("q 내부에 존재하는 배열 값 >>>  ");
    for (int i = 0; i < SIZE; i++){
        printf("[%d] ", q.a[i]);
    }
    

    

}