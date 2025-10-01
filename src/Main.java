import java.util.Arrays;
import java.util.Scanner;


public class Main {
    

    public static void main(String[] args) {
        int[] list = {441, 316, 644, 952, 213, 81, 157, 949, 974, 660, 787, 917, 836, 953, 437, 890, 477, 444, 557, 370, 568, 694, 572, 697, 206, 641, 853, 97, 6, 520, 790, 419, 87, 36, 693, 314, 826, 192, 380, 326, 110, 680, 509, 697, 824, 561, 572, 29, 344, 269};
        // int[] list = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
        boolean sorted = false;
        while (!sorted){
            int tmp = 0;
            sorted = true;
            for (int i = 1; i < list.length; i++){
                if (list[i] < list[i - 1]){
                    sorted = false;
                    tmp = list[i - 1];
                    list[i - 1] = list[i];
                    list[i] = tmp;
                }
            }
        }
        System.out.println(Arrays.toString(list));
        for (int i = 0; i < list.length; i++)
        {
            binSearch(list, list[i]);
        }
        // binSearch(list, list[list.length - 1]);
    }

static void binSearch(int[] list, int target) {
        Scanner scaner = new Scanner(System.in);
        int pointer = -1;
        int tail = 0;
        int head = list.length - 1;
        int index = -1;
        while (true)
        {
            pointer = (int) Math.floor( ((head - tail) / 2) ) + tail;
            // System.out.println("-------");
            // System.out.println(list[pointer]);
            // System.out.println(list[tail]);
            // System.out.println(list[head]);
            // System.out.println("-------");
            // scaner.nextInt();

            if (list[pointer] == target)
            {
                index = pointer;
                break;
            } else if (tail == head)
            {
                break;
            }
            else
            {
                if (list[pointer] > target)
                {
                    head = pointer - 1;
                }
                else if (list[pointer] < target)
                {
                    tail = pointer + 1;
                }
            }
        }
        scaner.close();

        if (index != -1)
        {
            System.out.println("found at " + Integer.toString(index));
        }
        else
        {
            System.out.println("not found");
        }
    }
}
