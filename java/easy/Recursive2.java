package easy;

public class Recursive2 {
    
  public static void main(String[] args) {
    System.out.println(calc("5"));
  }
 
  static int calc(int value) {
    if (value <= 1) return value;
    return calc(value - 1) + calc(value - 2);
  }
 
  static int calc(String str) {
    int value = Integer.valueOf(str);
    if (value <= 1) return value;
    return calc(value - 1) + calc(value - 3);  // 문제가 진짜 시이이ㅣ발새끼네,
                                               // calc(int value)로 호출함
  
  // 여기서 중요한게
  // 바로 calc(int value) 클래스 인자에 5가 다이렉트로 꽂히는게 아니라
  // 먼저 calc(value -1) , calc(value -3)을 수행한
              // 4              //  2

  // 4, 2 두개가 오버로딩되는거임 
  // 17행 로직은 실제로 동작 하는거!!!
  
                                              }
}
