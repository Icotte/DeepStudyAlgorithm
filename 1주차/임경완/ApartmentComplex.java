import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collections;

public class ApartmentComplex {

	public static void main(String[] args) {
		try {
			new ApartmentComplexNumbering();
		}catch(IOException e) {
			e.printStackTrace();
		}
	}

}
class ApartmentComplexNumbering{
	public final static int[][] direction ={ {1,-1,0,0},{0,0,1,-1} }; 
	private int N;
	private boolean[][] map;
	private boolean[][] isVisited;
	private int resultN;
	private int tmpCounter;
	private ArrayList<Integer> result;
	public ApartmentComplexNumbering() throws IOException{
		result = new ArrayList<>();
		
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		N = Integer.parseInt(br.readLine());
		map = new boolean[N][N];
		isVisited = new boolean[N][N];
		for(int i = 0; i < N; i++) {
			String s = br.readLine();
			for(int j = 0; j<N; j++) {
				char c= s.charAt(j);
				if(c=='1') {
					map[i][j] = true;
				}
			}
		}
		
		
		resultN = 0;
		for(int i = 0; i<N; i++) {
			for(int j = 0; j<N; j++) {
				if(!isVisited[i][j]&&map[i][j]) {
					resultN++;
					tmpCounter = 0;
					dfs(i, j);
					result.add(tmpCounter);
				}
			}
		}
		
		System.out.println(resultN);
		Collections.sort(result);
		for(int i = 0; i<result.size(); i++) {
			System.out.println(result.get(i));
		}
	}
	
	public void dfs(int i , int j) {
		tmpCounter++;
		isVisited[i][j] = true;
		for(int d = 0; d<4; d++) {
			boolean isOutOfIdx = (i+direction[0][d]<0||i+direction[0][d]>=N||j+direction[1][d]<0||j+direction[1][d]>=N);
			if(isOutOfIdx) {
				continue;
			}
			boolean	isVisitedIdx =  isVisited[i+direction[0][d]][j+direction[1][d]];
			boolean isZero = !map[i+direction[0][d]][j+direction[1][d]];
			if(!isOutOfIdx&&!isVisitedIdx&&!isZero) {
				dfs(i+direction[0][d], j+direction[1][d]);
			}
		}
		
	}
}