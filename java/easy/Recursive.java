package easy;
class Recursive_p {
    int compute(int num) {
        if (num <= 1) return num;
        return compute(num - 1) + compute(num - 2);
    }
}
 
class Recursive_c extends Recursive_p {
    int compute(int num) {

        if (num <= 1) return num;
        return compute(num - 1) + compute(num - 3);
                //           4                       // [반환값]
                //       3        [1]
                //   2     [0]
               // [1] [-1]

               
               
    }
}
 
public class Recursive {
    public static void main(String[] args) {
        Recursive_p obj = new Recursive_c();
        System.out.print(obj.compute(4));
    }
}