//
//  main.swift
//  BOJ[2667]
//
//  Created by SeokHyun on 2022/09/14.
//

import Foundation

let N = Int(readLine()!)!
var arr = [[Int]](repeating: [Int](), count: N)
var visited = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)

for i in 0..<N { //입력 저장
    arr[i] = readLine()!.map { Int(String($0))! }
}
/*   x   y
 좌: -1, 0
 상: 0, -1
 우: 1, 0
 하: 0, 1
 */
let xArr = [-1, 0, 1, 0]
let yArr = [0, -1, 0, 1]
var villageCount = 0
var houseCount = 0
var houseCountArr = [Int]()

//1. 배열을 넘어서면 안됨, 방문한적 없어야 함.
//2. 상하좌우 체크하고 0이면 넘어감, 1이면 새로 체크
//3. DFS 이용
for i in 0..<N { //세로줄 이동
    for j in 0..<N { //가로줄 이동
        if arr[i][j] == 1 && !visited[i][j] { //1이면서, 방문하지 않은 곳이면
            houseCount = 0
            houseCountArr.append(DFS(j, i))
            villageCount += 1
        }
    }
}

houseCountArr.sort()
print(villageCount)
for count in houseCountArr {
    print(count)
}

func DFS(_ x: Int, _ y: Int) -> Int {
    houseCount += 1 //집 개수 counting
    visited[y][x] = true //방문 표시
    
    for pos in 0..<xArr.count { //좌 상 우 하
        let xPos = x + xArr[pos]
        let yPos = y + yArr[pos]
        if !(xPos < 0 || yPos < 0 || xPos >= N || yPos >= N) && //배열 범위 내에 있고,
            !visited[yPos][xPos] && //방문 하지 않았고,
            arr[yPos][xPos] == 1 { //1이면
            DFS(xPos, yPos) //깊이우선탐색
        } else {
            continue //다음 방향 탐색
        }
    }
    return houseCount
}
