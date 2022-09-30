//
//  main.swift
//  CodingTest
//
//  Created by SeokHyun on 2022/09/30.
//

import Foundation

// 입력 받기
let N = Int(readLine()!)!
var cost = [0]
var benefit = [0]
var cache = Array(repeating: -1, count: N + 1)

for _ in 0..<N {
    let line = readLine()!.split(separator: " ").map { Int(String($0))! }
    cost.append(line[0])
    benefit.append(line[1])
}

// 재귀함수로 dp 구현
func dp(_ i: Int) -> Int {
    // 퇴사일이 지나서는 일을 못한다.
    if i > N {
        return 0
    }
    
    // 초기값
    if i == N {
        cache[i] = cost[i] == 1 ? benefit[i] : 0
    }
    
    // 점화식
    if cache[i] < 0 {
        if i + cost[i] - 1 > N {
            cache[i] = dp(i + 1)
        } else {
            cache[i] = max(dp(i + 1), benefit[i] + dp(i + cost[i]))
        }
    }
    
    return cache[i]
}

print(dp(1))
