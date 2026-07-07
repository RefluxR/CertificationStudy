package easy.upcaste;

public class Upcaste7_staticValue {
      public static void main(String[] args) {
       new C_7();
        System.out.println(P_7.total);
    }
}

    
    class P_7 {
        static int total = 0;
        int v = 1;
 
        public P_7() {
            total += (++v);
            show();  // 자식의 오버라이딩 된 show 실행
                    // 그런데 자식 클래스 선언도 안 됐기에
                    // + v 는 0이 됨  
        }
 
        public void show() {
            total += total;
        }
    }
 
 
    class C_7 extends P_7 {
        int v = 10;
 
        public C_7() {
            v += 2;
            total += v++;
            show();
        }
 
        @Override
        public void show() {
            total += (total * 2) + v;
        }
    }

  