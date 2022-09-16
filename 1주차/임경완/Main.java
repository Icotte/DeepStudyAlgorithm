import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.LinkedList;
import java.util.Queue;
import java.util.StringTokenizer;

public class Main {

	public static void main(String[] args) {
		try {
			new BFSDFS();
		}catch(IOException e) {
			e.printStackTrace();
		}
	}

}
class BFSDFS{
	private int nodeNum;
	private int linkNum;
	private int startNode;
	private Node[] nodes;
	private boolean[] isVisited;
	public BFSDFS() throws IOException{
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		StringTokenizer st = new StringTokenizer(br.readLine());
		nodeNum = Integer.parseInt(st.nextToken());
		linkNum = Integer.parseInt(st.nextToken());
		startNode = Integer.parseInt(st.nextToken());
		
		nodes = new Node[nodeNum];
		isVisited = new boolean[nodeNum];
		for(int i = 0; i<nodeNum; i++) {
			Node newNode = new Node(i+1);
			nodes[i] = newNode;
		}
		
		for(int i = 0; i<linkNum; i++) {
			st = new StringTokenizer(br.readLine());
			int start = Integer.parseInt(st.nextToken());
			int end = Integer.parseInt(st.nextToken());
			nodes[start-1].addLinkdedNode(nodes[end-1]);
			nodes[end-1].addLinkdedNode(nodes[start-1]);
		}
		
		
		for(int i = 0; i<nodeNum; i++) {
			nodes[i].sort();
		}
		InitVisitedArray();
		DFS(nodes[startNode-1]);
		InitVisitedArray();
		System.out.println();
		BFS(nodes[startNode-1]);
	}
	
	//bfs - 큐로 구현
	public void BFS(Node node) {
		Queue<Node> queue = new LinkedList<>();
		queue.add(node);
		isVisited[node.getData()-1] = true;
		while(!queue.isEmpty()) {
			node = queue.poll();
			System.out.print(node.getData()+ " ");
			for(int i = 0; i<node.getLinkedNode().size(); i++) {
				if(!isVisited[node.getLinkedNode().get(i).getData()-1]) {
					queue.add(node.getLinkedNode().get(i));
					isVisited[node.getLinkedNode().get(i).getData()-1] = true;
				}
			}
		}
	}
	
	//dfs - 재귀호출로 구현
	public void DFS(Node node) {
		System.out.print(node.getData()+" ");
		isVisited[node.getData()-1] = true;
		for(int i = 0; i<node.getLinkedNode().size(); i++) {
			if(!isVisited[node.getLinkedNode().get(i).getData()-1]) {
				DFS(node.getLinkedNode().get(i));
			}
		}
	}
	
	//bfs와 dfs 사이에 배열을 초기화해주는 함수
	public void InitVisitedArray() {
		Arrays.fill(isVisited, false);
	}
}
//노드를 객체화한 클레스
class Node{
	private int data;
	private ArrayList<Node> linkedNode;
	public Node(int a) {
		data = a;
		linkedNode = new ArrayList<>();
	}
	
	public void addLinkdedNode(Node node) {
		linkedNode.add(node);
	}
	
	public int getData() {
		return data;
	}

	public void setData(int data) {
		this.data = data;
	}

	public ArrayList<Node> getLinkedNode() {
		return linkedNode;
	}
	
	//그래프 탐색에서 불필요하지만 백준 출력에 맞추기 위하여 더 낮은 값을 먼저 탐색하기 위하여 정렬한다.
	public void sort() {
		linkedNode.sort(new Comparator<Node>() {
			public int compare(Node a, Node b) {
				return a.getData()-b.getData();
			}
		});
	}
}



