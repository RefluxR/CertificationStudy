package easy.upcaste;

class P_6 {
    String f(Object x) { return "1"; }
            // int
            // String

    // [포인트 1: 컴파일러의 시선]
    // 컴파일러는 이 g()를 읽을 때 P_6 내부만 봅니다.
    // f(3)을 보고 "어? 3(int)을 받을 f(int)가 없네? 그럼 가장 큰 형님인 f(Object)로 가자!"
    // 이 순간, 'f(Object)'를 호출하라는 낙인이 찍힙니다. (정적 바인딩)
    String g() { return f("???"); } 
}

class C_6 extends P_6 {
    // [포인트 2: 오버라이딩의 힘]
    // 런타임(실행 시점)에 "f(Object) 실행해!"라는 명령이 떨어지면,
    // 자바는 실제 객체(C_6)가 이걸 덮어썼는지 확인하고 "2"를 출력합니다.

    //@Override
    String f(Object x) { return "2"; }

    // [포인트 3: 무시당하는 전문가]
    // 비록 f(int)라는 딱 맞는 전문가가 자식에게 생겼지만,
    // 부모의 g()는 이미 'f(Object)'라는 기차표를 끊어버렸기 때문에
    // 이 전문가(f(int))는 호출될 기회조차 얻지 못합니다. (야랄난 포인트)
    String f(String x) {return "3"; }
    String f(int x) { return "4"; }
}

public class Upcaste6_argument {
    public static void main(String[] args){
        P_6 a = new C_6();
        
        // 결과는 2. 
        // 4가 안 나오는 이유는 다형성이 망가진 게 아니라,
        // 자바가 "호출할 메서드 이름표"를 너무 일찍(컴파일 때) 붙여버리기 때문입니다.
        System.out.println(a.g()); 

        // 그래서 제네릭 타입 함수를 사용하는 것이다.!!!!!!
    }
}