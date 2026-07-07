#include <stdio.h>

int main() {
	int a = 11;
	int b = 19;
	switch(a) {
		case 1:     // 조건에 안 맞으니 다음 조건 찾으러 떠남
			b += 1; 
		case 11:
			b += 2; // b = 21
        case 12:				// break 안 했으니까 아래 조건은 신경 안쓰고 
								// 계속 실행
            b += 4; // b = 25
			// 만약 여기서 break 해버리면 default는 실행 X
		default:
			b += 3; // b = 28
			break;
	}
	printf("%d", a-b);  // 11 - 28 = -17
}