//
//  main.swift
//  CodingTest
//
//  Created by SeokHyun on 2022/10/14

import Foundation

/*
 1. A의 맨 뒤에 넣을 수 있는 경우
    sol) - 맨 뒤 숫자와 기준 number를 비교해서 number가 더 크면 맨 뒤에 넣을 수 있다.
 
 2. A중간 혹은 처음에 넣어야 하는 경우
    sol) - lower bound를 이용한다.
         - 배열 A에 [2 4 5 6]이 있고 1을 넣어야 한다면 lower bound를 통해 1이라면 index를 얻을 수 있고, 그 index의 값을 1로 업데이트 한다.
 */

//12015 가장 긴 증가하는 부분 수열2
func lowerBound(find: Int, numbers: [Int]) -> Int {
    var start = 0, end = numbers.count - 1
    var mid = (start + end) / 2
    
    while start < end {
        mid = (start + end) / 2
        if numbers[mid] < find {
            start = mid + 1
        } else {
            end = mid
        }
    }
    
    return end
}

let input = Int(readLine()!)!

var numbers: [Int] = readLine()!.split(separator: " ").map { Int(String($0))! }

var dp: [Int] = []
for number in numbers {
    if dp.isEmpty {
        dp.append(number)
        continue
    }
    
    if dp[dp.count - 1] < number {
        dp.append(number)
    } else {
        let index = lowerBound(find: number, numbers: dp)
        dp[index] = number
    }
}
print(dp.count)
