package semiconductordesign;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.StringTokenizer;
 
public class Main {
 
    public static void main(String[] args){
        try {
        	new SemiconductorDesign();
        }catch(IOException e) {
        	e.printStackTrace();
        }
    }
 
}
class SemiconductorDesign{
    StringTokenizer st;
	public SemiconductorDesign()  throws IOException{
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
 
        int arrayNum = Integer.parseInt(br.readLine());
        int[] lis = new int[arrayNum];
        int[] array = new int[arrayNum];
 
        st = new StringTokenizer(br.readLine());
        for (int i = 0; i < array.length; i++) {
            array[i] = Integer.parseInt(st.nextToken());
        }
 
        lis[0] = array[0];
        
        int idx = 1;
        int tmp = 0;
        for (int i = 1; i < arrayNum; i++) {
            if (lis[idx - 1] < array[i]) { 
		//큰 수 앞에 끼어 저장한다
                lis[idx++] = array[i];
            } else if (lis[0] > array[i]) { 
            	// LIS의 0번째 수보다 작은 값으로 교체한다.
                lis[0] = array[i];
            } else { 
            	// 단순 탐색이 아닌 이진탐색을 활용하여 수행 시간을 줄인다.
                tmp = Arrays.binarySearch(lis, 0, idx, array[i]);
                lis[tmp < 0 ? (-tmp - 1) : tmp] = array[i];
            }
        }
        
        System.out.println(idx);
	}
}
