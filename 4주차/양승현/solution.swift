import Foundation
typealias Element = (left: Int,right: Int)

/*
  주요 구성 로직은 주어진 두 전봇대의 연결 선에 대해서 한쪽 전봇대의 연결 선을 sort한다.
  정렬을 하는 이유는 한쪽 전봇대가 정렬될 경우에 나머지 값들에 대해서 LIS 최장 증가 부문 수열을 적용시키면
  겹치지 않는 최대 전봇대의 개수를 구할 수 있기 때문입니다.
*/
func BOJ_2565() {
    let n        = Int(readLine()!)!
    var line     = [Element]()
    var length   = Array(repeating:1, count: n)
    
    for _ in 0..<n {
        let input = readLine()!.split(separator:" ").map{Int(String($0))!}
        line.append((input[0],input[1]))
    }
    line.sort {
        if $0.left < $1.left {
            return true
        }
        return false
    }
    for i in 0..<n {
        for j in 0..<i {
            if line[j].right < line[i].right {
                length[i] = max(length[i],length[j] + 1)
            }
        }
    }
    print(n - length.sorted()[n-1])
}
BOJ_2565()
