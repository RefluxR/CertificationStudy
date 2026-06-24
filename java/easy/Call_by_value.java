package easy;

public class Call_by_value {

    public static void change(String[] data, int[] data_i, String s, int i){
        data[0] = s;
        data_i[0] = 4;

        s = "Z";
        i = 3;
    }
    
    public static void main(String[] args) {
        String data[] = { "A" };
        int data_i[] = {1,2,3};
        
        String s = "B";
        int i = 0;
        
        change(data, data_i, s, i);
        System.out.print(data[0] + s + i);

        // 1 단계 - main함수 실행
            // data = {"A"}, data_i = {1,2,3}
            // s = "B", i = 0
        // 2 단계 - change 함수 호출
            // data = ["B"], data_i = {4,2,3}
            // 여기서 수정되는 변수들은 지역변수 - main함수에 영향 X

        // 출력값 - BB0423
        // B - data 의 0 번째 값 - change에서 수정 O
        // B - main에서 선언한 s - change에서 수정 X
        // 0 - main에서 선언한 i - change에서 수정 X
        // 423 - data_i의 내부 값 - chage에서 수정 O 

        for (int l = 0; l < data_i.length; l++){
            System.out.print(data_i[l]);
        }
    }

    
}