import Foundation

//편리를 위해 x,y 좌표를 Point, Element로 지정
typealias Point = (x: Int, y: Int)
typealias Element = Point

// 집이 있는 곳에서 연결된 상하 좌우
let direction = [(0,-1),(0,1),(-1,0),(1,0)]

class MapInfo {
    
    var map: [[Int]]
    var n: Int
    var visited: [[Bool]]
    //단지 개수
    var houseArea: Int
    //단지 내 집 개수들
    var house: [Int]
    
    init() {
        n = Int(readLine()!)!
        map = Array(repeating: [Int](), count: n)
        houseArea = 0
        house = [Int]()
        visited = Array(repeating: Array(repeating: false, count: n), count: n)
        for i in 0..<n {
            map[i] = readLine()!.map{Int(String($0))!}
        }
    }
}

class BOJ_2667 {
    
    let info = MapInfo()
    
    func solution() {
        findHouseInMap()
        info.house.sort()
        print("\(info.houseArea)" + info.house.reduce(""){"\($0)\n\($1)"})
    }
    
    //완전탐색으로 지도 전부 탐색 중 집 발견하면 해당 좌표를 기준으로 bfs탐색으로 인접한 집 탐색
    func findHouseInMap() {
        
        for y in 0..<info.n {
            for x in 0..<info.n {
                if isHouse(point: (x,y)) {
                    bfs(start: (x,y))
                    info.houseArea += 1
                }
            }
        }
        
    }
    
    //탐색 할 좌표가 집인가?
    func isHouse(point: Point) -> Bool {
        if info.map[point.y][point.x] == 1 && !info.visited[point.y][point.x] {
            return true
        }
        return false
    }
    
    //bfs탐색
    func bfs(start point: Point) {
        var queue = [Element]()
        var idx = 0
        info.house.append(1)
        info.visited[point.y][point.x] = true
        queue.append(point)
        while queue.count != idx {
            let p = queue[idx]
            idx += 1
            searchDirectionArrow(currentPoint: p, queue: &queue)
        }
    }
    
    func searchDirectionArrow(currentPoint point: Point, queue: inout [Element]) {
        //"상 하 좌 우" 중 인접한 집 탐색
        for (dx,dy) in direction {
            let (nx,ny) = (point.x+dx, point.y+dy)
            if isOutOfMap(p: (nx,ny)) { continue }
            if isHouse(point: (nx,ny)) {
                info.visited[ny][nx] = true
                queue.append(((nx,ny)))
                info.house[info.houseArea] += 1
            }
        }
    }
    
    // 상 하 좌 우 탐색을 하다 주어진 맵의 영역을 벗어났는가?
    func isOutOfMap(p: Point) -> Bool {
        if p.x < 0 || p.x > info.n - 1 || p.y < 0 || p.y > info.n - 1 {
            return true
        }
        return false
    }
    
}

BOJ_2667().solution()
