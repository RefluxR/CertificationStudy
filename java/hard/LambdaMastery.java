package hard;

/**
 * 람다와 인터페이스의 '따로 노는' 성질을 완벽히 이해하기 위한 테스트 클래스
 */
public class LambdaMastery {

    // 1. 딱 하나의 메서드만 있는 '함수형 인터페이스' (람다의 집)
    @FunctionalInterface
    interface Operation {
        int execute(int x) throws Exception;
    }

    // 2. 람다를 받아서 실행해주는 '시스템' 메서드
    public static int runSystem(Operation op, int value) {
        try {
            // 전달받은 람다식에 value를 넣어서 실행!
            return op.execute(value);
        } catch (Exception e) {
            // 람다 안에서 어떤 에러든 터지면 무조건 -999 반환 (에러 마커)
            return -999;
        }
    }

    public static void main(String[] args) {
        System.out.println("=== 람다 뇌 정지 탈출 시뮬레이션 시작 ===\n");

        // [상황 A] 폭탄 설치된 람다 (2보다 크면 터짐)
        Operation bomb = (n) -> {
            if (n > 2) throw new Exception("폭발!");
            return n * 10;
        };

        // [상황 B] 아무 생각 없는 람다 (그냥 100만 더함)
        Operation peaceful = (n) -> n + 100;

        // [상황 C] 0으로 나누기 시도하는 람다 (수학적 에러)
        Operation divider = (n) -> n / 0;

        // --- 여기서부터 출력값 맞히기 퀴즈 시작 ---

        // 1. 폭탄 람다에 1을 넣으면? (1 <= 2 이므로 안전)
        // 결과: 1 * 10 = 10
        System.out.println("1. Bomb with 1: " + runSystem(bomb, 1));

        // 2. 폭탄 람다에 3을 넣으면? (3 > 2 이므로 폭발!)
        // 결과: catch문에 걸려서 -999
        System.out.println("2. Bomb with 3: " + runSystem(bomb, 3));

        // 3. 평화 람다에 3을 넣으면?
        // 결과: 3 + 100 = 103 (옆집 bomb가 터지든 말든 얘는 상관없음!)
        System.out.println("3. Peaceful with 3: " + runSystem(peaceful, 3));

        // 4. 즉석에서 만든 람다: 입력값이 뭐든 777 리턴
        // 결과: 777
        System.out.println("4. Instant 777: " + runSystem(n -> 777, 5));

        // 5. 수학적 에러(0으로 나누기)가 발생하면?
        // 결과: ArithmeticException도 Exception의 자식이므로 catch에 걸려 -999
        System.out.println("5. Division by zero: " + runSystem(divider, 10));

        // 6. [심화] 람다 중첩 호출
        // 안쪽: peaceful(1) -> 101 반환
        // 바깥쪽: bomb(101) -> 101 > 2 이므로 폭발! -> -999
        int nestedResult = runSystem(bomb, runSystem(peaceful, 1));
        System.out.println("6. Nested Lambda: " + nestedResult);

        System.out.println("\n=== 시뮬레이션 종료 ===");
    }
}