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
	private int N;
	private int[] dp;
	private int[] T;
	private int[] P;
	public Resignation() throws IOException {
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
		int max = 0;
		for(int i = 0; i<N+1; i++) {
			dp[i] = Math.max(max, dp[i]);
			dp[i+T[i]] = Math.max(dp[i+T[i]], dp[i]+P[i]);
			max = Math.max(max, dp[i]);
		}
		System.out.println(Arrays.toString(dp));
		System.out.println(dp[N]);
	}
}