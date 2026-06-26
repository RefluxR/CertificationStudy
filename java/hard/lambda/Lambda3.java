package hard.lambda;

public class Lambda3 {

    static interface Calculator {
        int oper(int[] arr, int n);
    }

    public static int process(Calculator c, int[] arr, int n) {
        n = n + 2;
        return c.oper(arr, n);
    }

    public static void main(String[] args) {
        int[] nums = {1, 2, 3};
        int val = 1;

        // 1번 익명 슛
        int res1 = process((a, k) -> {
            a[0] = a[0] + k;
            return a[0] * 2;
        }, nums, val);

        // 2번 익명 슛
        int res2 = process((x, y) -> x[0] + y, nums, val);

        System.out.print(res1 + " " + res2 + " " + nums[0] + " " + val);
    }
}

