import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.StringTokenizer;

public class Main {

	public static void main(String[] args) {
		try {
			new Cheese();
		}catch(IOException e) {
			e.printStackTrace();
		}
	}

}
class Cheese{
	/**
	 * direction : 배열을 탐색하기 위해서 2차원 배열로 상하좌우 구현
	 * N : 세로길이
	 * M : 가로길이
	 * ground : 2차원 공간을 배열로 구현
	 * isVisited : dfs을 위해서 방문 표시용 배열
	 * cheeseNum : 현재 ground에 남은 치즈 개수
	 * preCheeseNum : 1시간 전 남은 치즈로 백준 결과를 보이기 위함
	 * CycleCounter : 백준 결과를 위해서 몇 시간이 지났는지 보여줌
	 * isSearchOutsideAir : dfs 혹은 bfs가 2개가 필요한 문제를 1개로 압축시키기위하여 두개의 타입으로 나누는 용도
	 */
	public static final int[][] direction = {{1, -1, 0, 0},{0, 0, 1, -1}};
	private int N;
	private int M;
	private int[][] ground;
	private boolean[][] isVisited;
	private int cheeseNum;
	private int preCheeseNum;
	private int CycleCounter;
	private boolean isSearchOutsideAir;
	public Cheese() throws IOException{
		//입력
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		StringTokenizer st = new StringTokenizer(br.readLine());
		N = Integer.parseInt(st.nextToken());
		M = Integer.parseInt(st.nextToken());
		ground = new int[N][M];
		isVisited = new boolean[N][M];
		for(int i = 0; i<N; i++) {
			st = new StringTokenizer(br.readLine());
			for(int j = 0; j<M; j++) {
				ground[i][j] = Integer.parseInt(st.nextToken());
			}
		}
		
		//최초 초기화
		CycleCounter= 0;
		
		//풀이 시작
		MeltingCheese();
		
		//출력
		System.out.println(CycleCounter);
		System.out.println(preCheeseNum);
	}
	public void MeltingCheese() {
		CountCheese();
		//치즈가 다 녹을때까지 시작
		while(cheeseNum!=0) {
			CycleCounter++;
			isSearchOutsideAir = true;
			//바깥 공기 부분을 탐색하는 타입으로 dfs시작
			SearchOutsideAir();
			isSearchOutsideAir = false;
			//바깥 공기와 마주친 치즈를 탐색하기 위한 dfs 시작
			SearchCheese();
			ChangeOutsideCheese();
			CountCheese();
			//print();
		}	
	}
	
	//테스트 용으로서 삭제해도 무관
	public void print() {
		System.out.println("________________");
		for(int x = 0; x<N; x++) {
			for(int y = 0; y<M; y++) {
				System.out.print(ground[x][y]+" ");
			}
			System.out.println();
		}
	}
	
	//바깥공기와 마주친 치즈부분을 삭제하는 함수
	public void ChangeOutsideCheese() {
		for(int x = 0; x<N; x++) {
			for(int y = 0; y<M; y++) {
				if(ground[x][y]==2) {
					ground[x][y] = -1;
				}
			}
		}
	}
	
	//현재 ground에 치즈가 얼마나 남아있는지 설정
	public void CountCheese() {
		cheeseNum = 0;
		for(int x = 0; x < N; x++) {
			for(int y = 0; y <M; y++) {
				if(ground[x][y]==1	) {
					cheeseNum++;
				}
			}
		}
		//치즈가 아직 다 안녹았으면 preCheeseNum에 저장
		if(cheeseNum!=0) {
			preCheeseNum = cheeseNum;
		}
	}
	//배열 초기화
	public void ArraysFillTwoDimen() {
		for(boolean[] b : isVisited) {
			Arrays.fill(b, false);
		}
	}
	
	public void SearchOutsideAir() {
		ArraysFillTwoDimen();
		DFS(0, 0, 1, -1);
	}
	
	public void SearchCheese() {
		ArraysFillTwoDimen();
		for(int x = 0; x<N; x++) {
			for(int y =0; y<M; y++) {
				if(!isVisited[x][y]) {
					DFS(x, y, -1, 2);
				}
			}
		}
	}
	//noSearchNum : 탐색하면 안되는 숫자 표시 - 바깥 공기 탐색일때는 치즈 / 치즈 탐색 일때는 공기
	//changeNum : 특정 숫자를 changeNum으로 변환
	public void DFS(int x, int y, int noSearchNum, int changeNum) {
		if(isSearchOutsideAir) {
			ground[x][y]=changeNum;
		}
		isVisited[x][y] = true;
		for(int i = 0; i<4; i++	) {
			int nextX = x+direction[0][i];
			int nextY = y+direction[1][i];
			boolean isOutOfIdx = (nextX<0||nextX>=N||nextY<0||nextY>=M);
			if(isOutOfIdx) {
				continue;
			}
			if(!isSearchOutsideAir) {
				if(ground[nextX][nextY]==noSearchNum) {
					ground[x][y] = changeNum;
				}
			}
			boolean	isVisitedIdx =  isVisited[nextX][nextY];
			boolean isNoSearchNum = ground[nextX][nextY]==noSearchNum;
			if(!isVisitedIdx&&!isNoSearchNum) {
				DFS(nextX, nextY, noSearchNum, changeNum);
			}
		}
	}
}









