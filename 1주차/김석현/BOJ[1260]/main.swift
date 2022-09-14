//
//  main.swift
//  BOJ[1260]
//
//  Created by SeokHyun on 2022/09/13.
//
import Foundation

//인접 리스트 사용
let nmv = readLine()!.split(separator: " ").map{ Int(String($0))! }
let N = nmv[0] //vertex number
let M = nmv[1] //edge number
let V = nmv[2] //start vertex

var arr = [[Int]](repeating: [Int](), count: N + 1) //인덱스 0은 사용하지 않을것이기 때문에 +1을 해준다.
var visited = [Bool](repeating: false, count: N + 1)

for _ in 1...M {
    let input = readLine()!.split(separator: " ").map{ Int(String($0))! }
    let start = input[0]
    let end = input[1]
    
    arr[start].append(end)
    arr[end].append(start)
    arr[start].sort()//인접리스트 낮은순부터 만들기 위해 오름차순으로 정렬
    arr[end].sort()
}

DFS(arr, V, &visited); print()
BFS(arr, V, &visited)
func DFS(_ arr: [[Int]], _ v: Int, _ visited: inout [Bool]) { //stack

    visited[v] = true //방문처리
    print(v, terminator: " ")

    for i in arr[v] {
        if !visited[i] { //방문 한 적 없으면
            DFS(arr, i, &visited)
        }
    }
}

func BFS(_ arr: [[Int]], _ v: Int, _ visited: inout [Bool]) {
    var queue = [Int]() //Queue 생성
    visited[v] = false //방문처리(DFS에 연이어 BFS 사용하므로, 방문처리를 false로 함)
    queue.append(v)
    
    while !queue.isEmpty { //큐가 비어있을 때까지 반복
        let newV = queue.removeFirst() //dequeue
        print(newV, terminator: " ")
        
        for i in arr[newV] { //arr[]는 1차원배열(순회 반복), i는 1차원 배열의 column
            if visited[i] { //방문한 적이 없으면
                queue.append(i)
                visited[i] = false //방문처리
            }
        }
    }
}
