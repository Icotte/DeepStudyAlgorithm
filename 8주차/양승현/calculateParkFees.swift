import Foundation

/*
    두번째 try 걸린시간 50min..
    어려웠던 점 : 변수를 재사용할 때 오타 이름을 사용하는 경우가 많았음... 디버깅이 안되서 index out of range 체크를 하지 못했음...
    그중 하나가 클래스에 append하는 경우인데 맴버변수의 배열을 빈 배열로 초기화 했기에 append를 해야했는데 
    index 라는 변수를 추가시키면서 아직 원소가 빈 자리에 index를 활용해서 에러가 났음.
    추가적으로 문제에선 차 넘버가 낮은 순으로 출력하라는 것을 뒤늦게 확인했음..
*/
// feeds[0] == 기본 시간
// feeds[1] == 기본 요금
// feeds[2] ==  추가 시간
// feeds[3] == 추가 시간당 요금

class UserCarInfo {
    //변수
    var visited = [Bool]()
    var visitedTime = [Int]()
    var totalFee = 0
    var visitedMinutes = 0
    var number = ""
    var index = 0
}

//함수
extension UserCarInfo {
    
    func configure(time: String, num: String) {
        number = num
        changeTimeToMinutesWithInt(time: time)
        checkVisited()
        index += 1
    }
    //input시 시간을 숫자 분으로 바꿈
    func changeTimeToMinutesWithInt(time: String) {
        let separated = time.split(separator:":").map{Int(String($0))!}
        
        visitedTime.append(separated[0] * 60 + separated[1])
    }
    //inoutCheck
    func checkVisited() {
        if index % 2 == 0 {
            visited.append(true)
            return
        }
        visited.append(false)
    }
}

var carList = [UserCarInfo]()

func setupCarList(_ records: [String]) {
    
    records.forEach { record in
        var isNewParkedCarID = false
        let timeNumberIn = record.split(separator: " ").map{String($0)}
        for car in carList {
            if car.number == timeNumberIn[1] {
                car.configure(time: timeNumberIn[0], num: timeNumberIn[1])
                isNewParkedCarID = true
                break
            }
        }
        if !isNewParkedCarID {
            let newUserCar = UserCarInfo()
            newUserCar.configure(time: timeNumberIn[0], num: timeNumberIn[1])
            carList.append(newUserCar)
        }
    }
}

func userFeesCalculate(_ fees: [Int])-> [Int] {
    carList.forEach { car in
        for i in 0..<car.visited.count {
            if car.visited[i] {
                continue
            }
            car.visitedMinutes += car.visitedTime[i] - car.visitedTime[i-1]
        }
        if car.visited.last! {
            car.visitedMinutes += 23*60 + 59 - car.visitedTime.last!
        }
        if car.visitedMinutes - fees[0] <= 0 {
            car.totalFee = fees[1]
            return
        }
        
        var lastMinutes = car.visitedMinutes - fees[0]
        if lastMinutes%fees[2] != 0 {
            lastMinutes = lastMinutes/fees[2] + 1
        }else {
            lastMinutes = lastMinutes/fees[2]
        }
        car.totalFee += fees[1] + lastMinutes*fees[3]
    }
    carList.sort { $0.number < $1.number }
    return carList.map{$0.totalFee}
}


func solution(_ fees:[Int], _ records:[String]) -> [Int] {
    
    setupCarList(records)
    return userFeesCalculate(fees)

}
