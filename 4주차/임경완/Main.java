import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.StringTokenizer;

public class Main {

	public static void main(String[] args) {
		try {
			new TwistedElectricWire();
		}catch(IOException e) {
			e.printStackTrace();
		}
	}

}
class TwistedElectricWire{
	/**
	 * array : 전봇대로서 입력된 전깃줄을 기입합니다.
	 * dp : 해당 위치에서 최장 길이를 저장합니다.
	 * num : 전깃줄의 개수를 저장합니다.
	 */
	private int[] array;
	private int[] dp;
	private int num;
	public TwistedElectricWire() throws IOException{
		array = new int[501];
		dp = new int[501];
		//입력부
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		num = Integer.parseInt(br.readLine());
		for(int i = 0; i<num; i++) {
			StringTokenizer st=  new StringTokenizer(br.readLine());
			int idx = Integer.parseInt(st.nextToken());
			int n = Integer.parseInt(st.nextToken());
			array[idx] = n;
		}
		
		//구현부
		int max = 0;
		for(int i = 0; i<501; i++) {
			//전봇대가 연결되지 않았다면 패스합니다.
			if(array[i]==0) {
				continue;
			}
			
			//해당 위치까지 탐색하며 해당 값보다 작은 것 중에 가장 큰 dp[j]값을 가지게 만들고 증가시켜 dp[i]로 저장합니다.
			int maxInIdx = 0;
			for(int j = 0; j<i; j++) {
				if(array[j]<array[i]&&array[j]!=0) {
					maxInIdx = Math.max(maxInIdx, dp[j]);
				}
			}
			dp[i] = maxInIdx+1;
			max = Math.max(max, dp[i]);
		}
		//최장길이와 전깃줄 개수를 빼서 잘라야할 전깃줄을 구합니다.
		System.out.println(num - max);
	}
}






















