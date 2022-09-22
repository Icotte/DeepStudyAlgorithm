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
		
		CycleCounter= 0;
		MeltingCheese();
		System.out.println(CycleCounter);
		System.out.println(preCheeseNum);
	}
	public void MeltingCheese() {
		CountCheese();
		while(cheeseNum!=0) {
			CycleCounter++;
			isSearchOutsideAir = true;
			SearchOutsideAir();
			isSearchOutsideAir = false;
			SearchCheese();
			ChangeOutsideCheese();
			CountCheese();
			//print();
		}	
	}
	public void print() {
		System.out.println("________________");
		for(int x = 0; x<N; x++) {
			for(int y = 0; y<M; y++) {
				System.out.print(ground[x][y]+" ");
			}
			System.out.println();
		}
	}
	public void ChangeOutsideCheese() {
		for(int x = 0; x<N; x++) {
			for(int y = 0; y<M; y++) {
				if(ground[x][y]==2) {
					ground[x][y] = -1;
				}
			}
		}
	}
	public void CountCheese() {
		cheeseNum = 0;
		for(int x = 0; x < N; x++) {
			for(int y = 0; y <M; y++) {
				if(ground[x][y]==1	) {
					cheeseNum++;
				}
			}
		}
		if(cheeseNum!=0) {
			preCheeseNum = cheeseNum;
		}
	}
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
	
	public void DFS(int x, int y, int noSearchNum, int changeNum) {
		if(isSearchOutsideAir) {
			ground[x][y]=changeNum;//이게 치즈 할땐 안해야됨
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









