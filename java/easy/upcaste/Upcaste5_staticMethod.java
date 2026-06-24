package easy.upcaste;

public class Upcaste5_staticMethod{


    public static class p5{

        public int x(int i) {return i + 1; }
        public static String id() {return "P";}
    }

    public static class c5 extends p5{

        public int x(int i) {return i + 3; }
        public static String id() {return "C";}
    }

    public static void main(String[] args) {
        p5 obj = new c5();


        System.out.println(obj.x(2) + obj.id());

        
// Q: 여기서 id()는 왜 부모(p5)의 메서드가 호출될까?

// 1. 메모리 배치 (Method Area):
// static 메서드는 객체가 생성될 때 힙(Heap)에 올라가는 것이 아니라, 클래스가 로딩될 때 **메서드 영역(Method Area/Metaspace)**에 미리 배치됩니다. 
// 즉, 객체의 실제 정체(c5)와는 상관없이 클래스 자체에 딱 붙어 있습니다.

// 2. 정적 바인딩 (Static Binding):
// static 메서드는 컴파일 시점에 호출될 함수 주소가 이미 결정됩니다. 컴파일러는 obj의 실제 알맹이가 무엇인지 보지 않고, 
// 오로지 **변수의 선언 타입(p5)**만 보고 p5.id()를 호출하도록 코드를 짜버립니다.

// 3. 메서드 숨김 (Hiding) vs 오버라이딩 (Overriding):
// 인스턴스 메서드인 x()는 VMT를 통해 '오버라이딩'되어 자식 것이 실행되지만, static 메서드인 id()는 오버라이딩 개념이 없습니다. 
// 자식이 똑같은 이름으로 만들어도 그것은 부모의 것을 '숨기는(Hiding)' 것일 뿐이며, 호출 기준은 언제나 **'참조 변수의 타입'**입니다.
    }
}