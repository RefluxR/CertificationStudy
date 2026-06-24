package hard;


class Parent {
    int value = 10;

    Parent() {
        // [포인트 1] 부모 생성자가 먼저 실행됩니다.
        display(); 
    }

    void display() {
        System.out.println("Parent value: " + value);
    }
    static void static_method (){
        System.out.println("P");
    }


    void dispatcher(){}
}

class Child<T> extends Parent {
    T genericValue;

    Child(T val) {
        // [포인트 2] super()가 생략되어 있습니다.
        this.genericValue = val;
        this.value = 20; // 상속받은 value를 수정합니다.
    }

    
    void display() {
        // [포인트 3] 오버라이딩된 메서드입니다.
        System.out.println("Child value: " + value + ", Generic: " + genericValue);
    }

    static void static_method (){
        System.out.println("C");
    }


    void dispatcher(){
         new Dispatcher().send(genericValue);
    }
}

class Dispatcher {
    // [포인트 4] 오버라이딩된 메서드를 찾는 생성자들
    void send(Object obj) { System.out.println("Sent as Object"); }
    void send(String str) { System.out.println("Sent as String"); }
}

public class Quiz_upcaste_generic {
    public static void main(String[] args) {
        System.out.println("--- Start ---");
        
        // [문제의 핵심 라인]
        Parent obj = new Child<String>("Hello");
        
        System.out.println("--- After Init ---");
        obj.display();

        System.out.println("--- Dispatch Check ---");

        new Dispatcher();

        obj.dispatcher();
        // Child 내부에서 T는 무엇으로 변해 있을까요?
        // 만약 Child 내부에서 d.send(this.genericValue)를 호출한다면? 
        // (이 부분은 아래 출력 예측에 포함하지 않고 생각만 해보세요!)

        //obj.static_method();
        Parent.static_method(); // static 매서드는 클래스.함수로 바로 접근 가능. -> 인스턴스 안해도 됨
    }
}