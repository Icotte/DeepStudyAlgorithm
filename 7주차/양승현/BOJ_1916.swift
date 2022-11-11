import Foundation
struct Heap<T> where T : Comparable
{
    var heap = [T]()
    let comparer : (T,T)-> Bool
    var isEmpty : Bool
    {
        return heap.isEmpty
    }
    
    init(comparer : @escaping (T,T)->Bool)
    {
        self.comparer = comparer
    }
    init()
    {
        self.init(comparer: <)
    }
    
    mutating func insert(_ element : T)
    {
        var idx = heap.count
        heap.append(element)
        while idx > 0 && comparer(heap[idx],heap[(idx-1)/2])
        {
            heap.swapAt(idx, (idx-1)/2)
            idx = (idx-1)/2
        }
    }
    mutating func delete() -> T?
    {
        guard !heap.isEmpty else
        {
            return nil
        }
        if heap.count == 1
        {
            return heap.removeFirst()
        }
        let res = heap.first
        heap.swapAt(0, heap.count-1)
        _ = heap.popLast()
        var idx = 0
        while idx < heap.count
        {
            let (left,right) = (idx*2+1,idx*2+2)
            if right < heap.count
            {
                if comparer(heap[left],heap[right]) && comparer(heap[left],heap[idx])
                {
                    heap.swapAt(left, idx)
                    idx = left
                }
                else if comparer(heap[right],heap[idx])
                {
                    heap.swapAt(right, idx)
                    idx = right
                }
                else
                {
                    break
                }
            }
            else if left < heap.count
            {
                if comparer(heap[left],heap[idx])
                {
                    heap.swapAt(left, idx)
                    idx = left
                }
                else
                {
                    break
                }
            }
            else
            {
                break
            }
        }
        return res
    }
}
/*
 큐에 vertex, weight를 튜플로하는 typelaias nodeInfo : (vertex: Int, weight: Int)를 할경우 오류가 난다. 컴파일러는 둘 중 무엇을 우선순위로 비교해서 nodeInfo간 작고 큰지 비교할 지모르기 때문. 이럴 때는 Comparable프로토콜을 적용해서 뭘 비교해 줄지를 파악하면된당,,
 */
struct NodeInfo : Comparable
{
    static func < (lhs: NodeInfo, rhs: NodeInfo) -> Bool
    {
        lhs.weight < rhs.weight
    }
    var weight : Int, vertex : Int
}

func BOJ_1916()
{
    let n     = Int(readLine()!)!
    let edges = Int(readLine()!)!
    var dist  = Array(repeating: Int.max, count: n)
    var graph = Array(repeating:[NodeInfo](),count: n)
    for _ in 0..<edges
    {
        let vuw = readLine()!.split(separator:" ").map{Int(String($0))!}
        let (start, new, weight) = (vuw[0],vuw[1],vuw[2])
        graph[start-1].append(NodeInfo(weight: weight, vertex: new-1))
    }
    let se            = readLine()!.split(separator:" ").map{Int(String($0))!}
    let (start, end)  = (se[0]-1,se[1]-1)
    
    var priorityQueue = Heap<NodeInfo>()
    dist[start] = 0
    priorityQueue.insert(NodeInfo(weight: 0, vertex: start))
    while !priorityQueue.isEmpty
    {
        guard let newNode = priorityQueue.delete() else
        {
            return
        }
        if dist[newNode.vertex] < newNode.weight
        {
            continue
        }
        for i in 0..<graph[newNode.vertex].count
        {
            let node = graph[newNode.vertex][i]
            if dist[newNode.vertex] + node.weight < dist[node.vertex]
            {
                dist[node.vertex] = dist[newNode.vertex] + node.weight
                priorityQueue.insert(NodeInfo(weight: dist[node.vertex], vertex: node.vertex))
            }
        }
    }
    print(dist[end])
}
BOJ_1916()
