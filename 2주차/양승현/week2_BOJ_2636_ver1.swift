import Foundation

typealias point = (x: Int,y: Int)
let direction = [(-1,0),(1,0),(0,1),(0,-1)]

class Queue {
    var queue = [point]()
    var index = 0
}
class MapInfo {
    
    let width: Int
    let height: Int
    var map: [[Int]]
    init() {
        var inputRect = readLine()!.split(separator: " ").map{Int(String($0))!}
        width = inputRect[1]
        height = inputRect[0]
        map = Array(repeating: [Int](), count: height)
        for i in 0..<height {
            map[i] = readLine()!.split(separator: " ").map{Int(String($0))!}
        }
    }
    
}
/*
    문제에 대한 주요 알고리즘
    1. exposedAir를 통해 노출된 공기 처리를 한다.
    2. melting을 통해 외부 공기와 접촉된 치즈를 0으로 만들어 추후 실행될 exposedAir를 통해 녹이게 만든다.
    3. 시간 체크를 한다.
 */
class BOJ_2636 {
    var info = MapInfo()
    var time = -1
    var curCheese = 100001
    var prevCheese = 100001
    
    func solution() {
        while isMeltingCheese() {
            exposedAir()
            melting()
            time += 1
        }
        print("\(time)\n\(prevCheese)")
    }
    
    func melting() {
        curCheese = 0
        var visited = Array(repeating: Array(repeating: false, count: info.width), count: info.height)
        for y in 0..<info.height {
            for x in 0..<info.width {
                if !visited[y][x] && info.map[y][x] == 1  {
                    visited[y][x] = true
                    meltingCheeseCheck(start: (x,y), visited: &visited)
                }
            }
        }
    }
    func meltingCheeseCheck(start p: point, visited: inout [[Bool]]) {
        var q = Queue()
        visited[p.y][p.x] = true
        q.queue.append(p)
        curCheese += 1
        
        while q.index != q.queue.count {
            let curPoint = q.queue[q.index]
            q.index += 1
            for (dx,dy) in direction {
                let (nx,ny) = (curPoint.x+dx, curPoint.y+dy)
                if isOutOfMap(p: (nx,ny)) || visited[ny][nx] {
                    continue
                }
                if info.map[ny][nx] == -1 {
                    info.map[curPoint.y][curPoint.x] = 0
                }else if info.map[ny][nx] == 1 {
                    q.queue.append((nx,ny))
                    visited[ny][nx] = true
                    curCheese += 1
                }
            }
        }
    }
    
    func exposedAir() {
        var q = Queue()
        var visited = Array(repeating: Array(repeating: false, count: info.width), count: info.height)
        q.queue.append((0,0))
        visited[0][0] = true
        info.map[0][0] = -1
        
        while q.index != q.queue.count {
            let curPoint = q.queue[q.index]
            q.index += 1
            for (dx,dy) in direction {
                let (nx,ny) = (curPoint.x+dx,curPoint.y+dy)
                if isOutOfMap(p: (nx,ny)) || visited[ny][nx] || info.map[ny][nx] == 1 {
                    continue
                }
                q.queue.append((nx,ny))
                visited[ny][nx] = true
                if  info.map[ny][nx] == 0  {
                    info.map[ny][nx] = -1
                }
            }
        }
        
    }
    
    func isMeltingCheese() -> Bool {
        if curCheese != 0 {
            prevCheese = curCheese
            return true
        }
        return false
    }
    
    func isOutOfMap(p: point) -> Bool {
        return p.x<0 || p.x > info.width - 1 || p.y<0 || p.y > info.height - 1
    }
    
}
BOJ_2636().solution()
