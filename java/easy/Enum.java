package easy;


enum Tri {
    A("A"), B("AB"), C("ABC"); // main에서 인스턴스 안 해도 이미 메모리에 로드
 
    private String code;
 
    Tri(String code) {
        this.code = code;
    }
 
    public String code() {
        return code;
    }
}
 
public class Enum {
    public static void main(String[] args) {
            // t 는 이미 인스턴스 된, Tri.values()  == [A,B,C] 들 중 하나를 얻음

        Tri t = Tri.values()[Tri.A.name().length()];
                                // name()은 단순히 껍데기를 받아옴
                                // A안의 "A"가 아니라 A 생성자 이름 A
                                // B였어도 "AB"가 아닌 B 생성자 이름 B
                            
        System.out.println(t.code());

        Tri test = Tri.values()[Tri.B.code().length()];
        System.out.println(test.code());
    }
}