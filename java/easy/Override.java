package easy;

public class Override{
    public static void main(String[] args) {
        new c();   // chiled 클래스의 생성자를 호출하면 상위 클래스부터 생성자가 호출됨
       
        // 이 과정에서 parent 클래스의 func()가 호출되고, 그 다음에 chiled 클래스의 func()가 호출됨    
        // 객체를 생성하기만해도 내부의 연산이 이루어짐  
        System.out.println(p.total);
    }
}

class p {
    static int total = 0; 

    int v = 1;
    p() {  // 생성자 함수를 호출할 때마다 v가 1씩 증가함
        total += (++v);
        func();  // chiled.func()가 호출됨
                // 왜 그러느냐!!! 이 시발롬아? ㅌㅋㅋㅋ
                // 실제 메모리에 들어간 객체는 parent 객체가 아니라 chiled 객체이기 때문에
                // 동적 바인딩에 의해 chiled 클래스의 func()가 호출됨
    }

    void func() {  // 하위 클래스에서 정의된 Override된 매서드가 호출됨
        total += total; // 따라서 해당 코드는 하위 클래스의 func()가 호출되어 total을 두 배로 증가시킴
    }
}

class c extends p {
    int v = 10; // 부모 클래스의 v와는 다른 변수

    c() {  
        v += 2;
        total += (v++); // total은 여기서 16이 됨
        func();
    }

    void func() {
        total += total * 2;
    }
}

