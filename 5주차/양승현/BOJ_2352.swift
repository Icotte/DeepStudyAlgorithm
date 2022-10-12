import Foundation

/**

  반도체 설계에서 꼬이지 않고 포트를 연결하기 위한 경우의 수는 무수히 많은데
  LIS를 활용해서 문제를 접근했다.
  맨 왼쪽 포트의 경우 1~N까지 자동으로 정렬이 되어있음으로 다른 포트를 연결할 때 끊기지 않고 가장 긴 증가하는 포트들의 개수를 구해가면
  이 문제를 해결할 수 있었다는 결론을 토의를 통해 얻었습니다.

  점진적으로 증가하는 포트들의 개수를 구하기 위해서 이분 탐색을 통해 정렬된 배열에서의 크기가 작은 target값을 교체해가면서 포트의 점진적인 크기를 구해갔습니다.
*/
func binarySearch(_ target : Int, _ sequence : inout [Int]) {
    var left = 0, right = sequence.count
    while left < right {
        let mid = (left+right)/2
        if target > sequence[mid] {
            left = mid + 1
        } else {
            right = mid
        }
    }
    sequence[right] = target
}

func BOJ_1365() {
    let _ = Int(readLine()!)!
    let line = readLine()!.split(separator:" ").map{Int(String($0))!}
    var sequence = [line[0]]
    for i in 1..<line.count {
        if sequence.last! < line[i] {
            sequence.append(line[i])
        } else {
            binarySearch(line[i], &sequence)
        }
    }
    print(line.count - sequence.count)
}

BOJ_1365()
