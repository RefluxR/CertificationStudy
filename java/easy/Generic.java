package easy;

class Printer<T>{
    
    void print(Integer a) {
        System.out.println("A" + a);
    }
    void print(T a) { // Object a와 다른점은 
        System.out.println("Printer 인스턴스 ===================");
        System.out.println("Object!!! " + a); 
        // 자바의 오버로드된 메서드 선택 방식
        // 컴파일러 눈에 value는 그저 T일 뿐이고, T는 최악의 경우 어떤 타입이든 올 수 있는 Object급

        // 

    }
    
    void print(Number a) {
        System.out.println("C" + a);
    }

    void print(String a) {
        System.out.println("String" + a);
    }

    // void getType(Object value){
    //     System.out.println("Printer 내부 에서의 타입 = " + value.getClass().getSimpleName());
    //     System.out.println("");
    // }

    void getType(T value){
        System.out.println("Printer 내부 에서의 타입 = " + value.getClass().getSimpleName());
        System.out.println("");
    }

    void getType(String value){
        System.out.println("Printer 내부 에서의 타입 = " + value.getClass().getSimpleName());
    }
}


public class Generic {
    public static void main(String[] args) {
        new Container<Integer>(10).print(); // 10을 제네릭 타입으로 전달
        new Container<String>("test").print(); // String을 넣어도 정상 작동 됨
        new Container<Double>(3.14).print(); // 

  
        // est;
        System.out.println("main () -----------");
        new Printer<>().getType(333);
        new Printer<>().getType("test");
        
    }

    public static class Container<T> { // 제네릭 타입 추가
        T value;
        // value 라는 변수는 Container<T> 안에서 T 타입(즉, Object)으로 선언되어 있습니다.
        
        public Container(T t) {
            System.out.println("container 인스턴스 ===================");

            if (t instanceof Integer){
                System.out.println("integer 타입이 전달되었습니다.");
            }else if(t instanceof String){
                System.out.println("String 타입이 전달되었습니다.");
                
            }else if(t instanceof Double){
                System.out.println("Double 타입이 전달되었습니다.");
            }
            value = t;
            
        }

        public void print() {
            new Printer<>().print(value); // 컴파일러 눈에 value는 그저 T일 뿐이고, T는 최악의 경우 어떤 타입이든 올 수 있는 Object급
                                         // **"제네릭은 특정 객체(Integer, String)가 아니라, 무엇이든 될 수 있는 '미확정 상태의 객체(Object)'로 취급된다"**가 더 정확한 팩트
                                         
                                         // Integer 객체: "나는 숫자 계산도 할 수 있고, intValue()도 있어!"
                                         // String 객체: "나는 글자도 합칠 수 있고, length()도 있어!"
                                         // 제네릭 T: (컴파일러 시점) "얘는 나중에 Integer가 될 수도 있고, String이 될 수도 있어. 
                                         // 즉, 공통점인 '객체(Object)'라는 사실 말고는 아무것도 확신할 수 없어."

                                         // "제네릭 T는 컴파일 시점에 자료형이 확정되지 않았기 때문에, 가장 안전한 자료형인 Object로 **업캐스팅(Upcasting)**되어 다뤄진다."
            new Printer<>().getType(value);
        }
    }
}
