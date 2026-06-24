package easy.upcaste;

class A_3 {
    String n;
    int a;  

    public A_3(String n, int a) {
        this.n = n;
        this.a = a;
        setting();
        display();
    }

    public void display() {
        System.out.printf("%s = %d \n", n, a );
    }

    void setting(){
        a = 99999;
    }
}

class B_3 extends A_3 {
    public B_3(String n, int a) {
        super(n, a);
        // 부모 클래스에서 자동으로 Setting() display() 해 줌
    }

    void setting(){
        a = 20;    
    }
}

public class Upcaste3 {
    public static void main(String[] args) {
        A_3 obj = new B_3("upcast", 10);
        B_3 abj_c = new B_3("child", 10);
        A_3 obj_p = new A_3("parent", 10);

        System.out.println(obj.a);
        System.out.println(abj_c.a);
        System.out.println(obj_p.a);
    }
}