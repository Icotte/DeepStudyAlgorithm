import Foundation

struct NodeInfo {
    let nodeCount: Int
    let edgeCount: Int
    let startNode: Int
    init(){
        let input = readLine()!.split(separator: " ").map{Int(String($0))!}
        self.nodeCount = input[0]
        self.edgeCount = input[1]
        self.startNode = input[2]
    }
}

class BOJ_1260{
    
    let nodeInfo: NodeInfo
    var graph :[[Int]]
    
    init() {
        
        nodeInfo = NodeInfo()
        graph = Array(repeating: [Int](), count: nodeInfo.nodeCount + 1)
        
        for _ in 0..<nodeInfo.edgeCount{
            let input = readLine()!.split(separator: " ").map{Int(String($0))!}
            let aNode = input[0], bNode = input[1]
            graph[aNode].append(bNode)
            graph[bNode].append(aNode)
        }
        
        for i in 1...nodeInfo.nodeCount {
            graph[i] = graph[i].sorted(by: <)
        }
    }
    
    func solution() {
        dfs(startNode: nodeInfo.startNode)
        bfs(startNode: nodeInfo.startNode)
    }
    
    func dfs(startNode v: Int) {
        var result = ""
        var visited = Array(repeating: false, count: nodeInfo.nodeCount+1)
        var stack = [Int]()
        stack.append(v)
        visited[v] = true
        result = "\(v)"
        
        while !stack.isEmpty {
            guard let node = stack.last else {
                break
            }
            var check = false
            graph[node].forEach{ vertex in
                if !visited[vertex] && !check {
                    check = true
                    stack.append(vertex)
                    visited[vertex] = true
                    result += " \(vertex)"
                }
            }
            if !check {
                stack.removeLast()
            }
        }
        print(result)
    }
    
    func bfs(startNode v: Int) {
        var res = ""
        var queue = [Int]()
        var index = 0
        var visited = Array(repeating: false, count: nodeInfo.nodeCount + 1)
        queue.append(v)
        visited[v] = true
        res += "\(v)"
        
        while queue.count != index {
            let node = queue[index]
            index += 1

            graph[node].forEach{ vertex in
                if !visited[vertex] {
                    visited[vertex] = true
                    res += " \(vertex)"
                    queue.append(vertex)
                }
            }
        }
        print(res)
    }
}
BOJ_1260().solution()
