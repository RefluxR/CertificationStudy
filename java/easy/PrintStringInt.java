package easy;

public class PrintStringInt {
    public static void main(String[] args) {
        int x1 = 9;
        int x2 = 2;
        String x3 = "3";
        System.out.println(x1 + x2 + "2" + x3);

        // 맨 앞에 정수를 먼저 더하면 = 정수는 알아서 돌아감
        // !!!!! 그러나 " " (문자열)을 만나버리면 그 뒤로는 전부 문자열 처리

        
        // 문자열이 맨 앞에 와버리면 이렇게 됨
        System.out.println("2" + 9 + 2 + 1 + "3");
    }
}
