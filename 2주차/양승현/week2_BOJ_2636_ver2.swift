import Foundation

typealias point = (x: Int,y: Int)
let direction = [(-1,0),(1,0),(0,1),(0,-1)]

class Queue {
    var queue = [point]()
    var index = 0
}
let width: Int
let height: Int
var map: [[Int]]
var inputRect = readLine()!.split(separator: " ").map{Int(String($0))!}
width = inputRect[1]
height = inputRect[0]
map = Array(repeating: [Int](), count: height)
for i in 0..<height {
    map[i] = readLine()!.split(separator: " ").map{Int(String($0))!}
}
var time = -1
var curCheese = 100001
var prevCheese = 100001

while isMeltingCheese() {
    exposedAir()
    melting()
    time += 1
}
print("\(time)\n\(prevCheese)")

func melting() {
    curCheese = 0
    var visited = Array(repeating: Array(repeating: false, count: width), count: height)
    for y in 0..<height {
        for x in 0..<width {
            if !visited[y][x] && map[y][x] == 1  {
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
            if map[ny][nx] == -1 {
                map[curPoint.y][curPoint.x] = 0
            }else if map[ny][nx] == 1 {
                q.queue.append((nx,ny))
                visited[ny][nx] = true
                curCheese += 1
            }
        }
    }
}
func exposedAir() {
    var q = Queue()
    var visited = Array(repeating: Array(repeating: false, count: width), count: height)
    q.queue.append((0,0))
    visited[0][0] = true
    map[0][0] = -1
    
    while q.index != q.queue.count {
        let curPoint = q.queue[q.index]
        q.index += 1
        for (dx,dy) in direction {
            let (nx,ny) = (curPoint.x+dx,curPoint.y+dy)
            if isOutOfMap(p: (nx,ny)) || visited[ny][nx] || map[ny][nx] == 1 {
                continue
            }
            q.queue.append((nx,ny))
            visited[ny][nx] = true
            if  map[ny][nx] == 0  {
                map[ny][nx] = -1
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
    return p.x<0 || p.x > width - 1 || p.y<0 || p.y > height - 1
}
