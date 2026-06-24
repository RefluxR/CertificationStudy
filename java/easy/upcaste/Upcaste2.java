package easy.upcaste;

class A_2 {
    int cost = 10;
    A_2(){
        System.out.print("A");
        
        outputCost();           // B에서 오버라이딩 된 함수가 실행되지만.
                                // B에서 cost는 아직 생성되기 전이기에, 0을 출력하게 됨.
    }
    void outputCost(){
        System.out.print(cost);
    }
}

class B_2 extends A_2 {
    int cost = 20;
    B_2(){
        System.out.print("B");
        outputCost();
    }
    void outputCost(){
        System.out.print(cost); // 메서드, 생성자에서 사용되는 변수는 가장 가까운 변수이다.
                                // 왜냐?? 부모에게 상속받은 cost를 B에서 임의로 수정했기 때문에 정보 덫씌움
    }
}

public class Upcaste2{

    public static void main(String[] args){
        A_2 a = new B_2();
        System.out.println(a.cost);  


        // 출력 순
        // 1. A의 생성자 = A
        // 2. A생성자의 ouputCost 함수 = 0

        // 3. B의 생성자 = B
        // 4. B생성자의 outputCost 함수 = 20

        // 5. main 함수의 print(a.cost)
        // ------ 자료형이 A 이기 때문에 a의 cost를 참조함. = 10
    }

}