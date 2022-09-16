import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collections;
//백준기준에 맞춰 Main으로 지정
public class Main {

	public static void main(String[] args) {
		try {
			new ApartmentComplexNumbering();
		}catch(IOException e) {
			e.printStackTrace();
		}
	}

}
class ApartmentComplexNumbering{
	/**
	 * direction : 상하좌우로 1씩 이동하는 것을 x와 y의 기준으로 나누어 2차원 배열로 설정
	 * N : 입력값으로서 배열의 크기를 지정한다. (N * N)
	 * map : 단지를 찾기위한 아파트의 분포를 저장한 배열 false : 아파트가 없는 구역 true : 아파트가 존재하는 구역
	 * resultN : 출력값 중 하나로서 아파트 단지 개수를 의미
	 * result : 출력값 중 하나로서 단지 별 아파트 개수를 의미
	 * tmpCounter : 단지내 아파트 개수를 넣는 변수
	 */
	public final static int[][] direction ={ {1,-1,0,0},{0,0,1,-1} }; 
	private int N;
	private boolean[][] map;
	private boolean[][] isVisited;
	private int resultN;
	private int tmpCounter;
	private ArrayList<Integer> result;
	public ApartmentComplexNumbering() throws IOException{
		//입력 및 초기화
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
		
		//구현
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
		
		//출력
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
			//배열 인덱스가 0보다 작거나 크기보다 크다면 탐색하지 않는다.
			boolean isOutOfIdx = (i+direction[0][d]<0||i+direction[0][d]>=N||j+direction[1][d]<0||j+direction[1][d]>=N);
			if(isOutOfIdx) {
				continue;
			}
			//이미 방문했다면 탐색하지 않는다.
			boolean	isVisitedIdx =  isVisited[i+direction[0][d]][j+direction[1][d]];
			//해당 방향에 아파트가 없다면 탐색하지 않는다.
			boolean isZero = !map[i+direction[0][d]][j+direction[1][d]];
			//각 방향으로 탐색한다.
			if(!isOutOfIdx&&!isVisitedIdx&&!isZero) {
				dfs(i+direction[0][d], j+direction[1][d]);
			}
		}
		
	}
}
