import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.StringTokenizer;

public class Main {

	public static void main(String[] args) {
		try {
			new Resignation();
		}catch(IOException e) {
			e.printStackTrace();
		}
	}

}
class Resignation{
	/**
	 * N : 일정의 개수
	 * dp : 해당 날짜에 얻을 수 있는 최대 이익
	 * T : 각 일정이 걸리는 시간
	 * p : 각 일정에 대한 가치
	 */
	private int N;
	private int[] dp;
	private int[] T;
	private int[] P;
	public Resignation() throws IOException {
		//입출력
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		N = Integer.parseInt(br.readLine());
		dp = new int[25];
		T = new int [25];
		P = new int[25];
		for(int i = 0; i<N; i++) {
			StringTokenizer st = new StringTokenizer(br.readLine());
			T[i] = Integer.parseInt(st.nextToken());
			P[i] = Integer.parseInt(st.nextToken());
		}
		
		//max : 이전의 최대값을 가르킨다.
		int max = 0;
		for(int i = 0; i<N+1; i++) {
			//이전 날 값이 더 크다면 교체한다.
			dp[i] = Math.max(max, dp[i]);
			//오늘 일정을 진행했을 때 해당 날짜에 얻을 가치 기입
			dp[i+T[i]] = Math.max(dp[i+T[i]], dp[i]+P[i]);
			//이전 날 값 최대치를 갱신
			max = Math.max(max, dp[i]);
		}
		System.out.println(Arrays.toString(dp));
		System.out.println(dp[N]);
	}
}