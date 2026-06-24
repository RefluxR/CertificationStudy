package easy.upcaste;

class P_4 {
    int a = 100;
    P_4(int a) { this.a = a; }
}

class C_4 extends P_4 {
    int a = 200;
    C_4(int a) {
        super(a + 50); // 부모의 super(a + 50) 생성자를 통해 p_4.a = 60이 된다.
        this.a = a;
    }
}

public class Upcaste4 {
    public static void main(String[] args) {
        P_4 obj = new C_4(10);
        System.out.println(obj.a);
    }
} 
