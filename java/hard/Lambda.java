package hard;

public class Lambda {

    static interface F {
        int apply(int x) throws Exception; 
        
        // 어차피 interface라 직접 구현하는게 아님 
        // apply라는 함수도 main 클래스 안에서 구현하는거기 때문에 여기선 ㅈ도 신경 쓸거 없음
    }

    public static int run(F f){
        try {
            return f.apply(3);  // main에서 선언한 람다식을 적용

                    // f
                    // (int n) -> n + 9
                    // 이 두 함수가 실행됨

        }catch (Exception e){
            return 7; // 이때 apply의 매게변수가 2보다 크면 7 return
        }
    }


    public static void main(String[] args){

        F f = (x) -> {
            if (x > 2){
                throw new Exception();
            }
            return x * 2;
        };

        
        

        System.out.println(run(f) + run((int  n) -> n + 9 ));

        // 결과값 해석
        System.out.println(run(f)); // 일단 try return f.apply(3)
                                    // 그럼 람다식에 의해 3 > 2에 걸려 Exception 걸림 -> 7
        System.out.println(run((int  n) -> n + 9 )); 
        // ##################
        // 왜 씨발 12가 그대로 출력되는건데 ㅋㅋㅋ
        // 12 > 2 조건문 걸려서
        // Exception() 나야 되는거 아니냐 이 개 씨발 출제자 새끼들아




        // 야 이 빡대가리 새끼야
        // 처음 run(f)는 위에서 선언한

        //F f = (x) -> {
        //    if (x > 2){
        //        throw new Exception();
        //    }
        //    return x * 2;
        //};
        // 람다식을 적용했으니까 X > 2 조건문이 성립되는거잖아. 그래서 에러 나는거고


        // 그런데 뒤에는 그냥 (int n) -> n + 9
        // 즉, "그냥 n 에다가 9를 더해서 전달 해라" 라는 "새로운 람다식"을 전달했으니
        // Exception이 안 나는거고 (에초레 Exception 구문도 없음)

        // (int n) -> n + 9 는
        // F 인터페이스를 따르는 람다 apply 함수인 것이다.

    }
}
