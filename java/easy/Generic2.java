package easy;

class normal_class{

    normal_class(Object value){
        
        System.out.println(value + "는 object이다 ");
    }

    normal_class(String value){
        
        System.out.println(value + "는 String이다 ");
    }

    normal_class(int value){
        
        System.out.println(value + "는 int이다 ");
    }
    
}

class generic_class<T>{
    T value;

    generic_class(T value){
        this.value = value;

        
        System.out.print(this.value + "( 제네릭 <T> )를 전달 ---> ");
        
        new normal_class(this.value);  // 1. 형변환은 '꺼내서 쓸 때'만 발생합니다 (Inside vs Outside)
                                    // 컴파일러가 자동 형변환 코드를 넣어주는 위치는 **제네릭 클래스의 '밖'**에서 그 값을 가져갈 때입니다.

                                    // 외부에서 부를 때 (Test 클래스): Integer num = generic_obj.value;

                                    // 컴파일러: "어, 밖에서 Integer 바구니에 담으려고 하네? 내가 (Integer)를 써줘야지!" (Casting 발생)

                                    // 내부에서 부를 때 (generic_class 내부): new normal_class(this.value);

                                    // 컴파일러: "여기는 내 집(generic_class) 안이네? 내 안에서 this.value의 신분은 여전히 Object야. 굳이 형변환할 필요 없지. 그냥 Object 통로로 보낼게." (Casting 안 함)
    }
    
    
}
 
public class Generic2<T> {

    
    public static void main(String[] args) {    
        
        // main함수의 static을 지우면
        // T test; 처럼 선언이 가능해짐

        // static 메소드에서 변수 선언이 안되는 이유
        // 1. 반드시 클래스 멤버 레벨에서 선언해야함.
        //  제네릭 타입 T는 해당 클래스의 인스턴스가 생성될 때(new Test<String>()) 결정된다.
        // 즉, static은 T가 무엇인지 결정되기도 전에 존재해야 하므로 컴파일러가 타입을 확정할 수 없습니다. 

        
        new generic_class<String>("String");
        new generic_class<Integer>(1234);

        System.out.println("\n");
        System.out.print("[main]에서 바로 전달 ---> "); new normal_class("String");
        System.out.print("[main]에서 바로 전달 ---> "); new normal_class(1234);

        System.out.println("\n");
        System.out.println("그렇다면 사실상, 객체 내부에서 다른 객체로 전달하는 것 자체가 중요한게 아니라.");

        System.out.println("객체(생성자) 자체에게 인자값으로 <제네릭> 값을 주었느냐가 중요한 부분");

        
        
        

    }
}