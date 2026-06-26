package hard.lambda;

public class Lambda {


    static interface F{  // 람다식 내부에서 new Exception을 해버려서 후처리를 미리 선언해 줘야함
        int apply(int x) throws Exception; 
        // Java 언어는 함수(기능) 이 홀로 존재할 수 없음
        // 예를 들어, 클래스 내부에 선언되지 않은 함수나,
        // 아래와 같이 "람다"식을 활용한 임시 함수와 같이....
        // ->>> 따라서 interfac 라는 -임시 클래스- 역할이 필요함
    }

    public static int run(F f){
        try {
            return f.apply(3);
                    // f(3) 처럼 사용 못 하는 이유는
                    // 람다식은 실체화된 객체가 아니라.
                    // 위에 람다 전용 인터페이스 F에서 선언한
                    // apply 함수를 사용해야함 그래야 기능 연결 가능
                
        }catch(Exception e){
            return 7;
        }
    }

    public static void main(String[] args){

        // F 의 인터페이스 구조 F를 따르는 람다식 "f" 생성
        F f = (x) -> {
            if (x > 2){
                throw new  Exception();
            }
            return x * 2;
        };
                           
        System.out.println(run(f) + run((int n) -> n + 9));

        // === run(f) ---
        // run 내부에서 f 람다식에 3을 주입 >>> 예외 발생해서 7 return

        // === run( (int n) -> n + 9 )
        // 이 새끼를 보면 존나 어이가 없는게
        // run() 에서 람다 함수를 받는 매게변수를 잘 보면
        // 이미 "매게변수로 F 인터페이스를 따르는 f라고 전달 받겠다 ㅋ" 라고 함

        // 그래서
        // System.out.println(
        //  run((x) -> { if (x > 2) throw new Exception(); return x * 2; }) 
        // + run((n) -> n + 9)
        // 이렇게 해도 똑같이 작동함
        

    }
}
