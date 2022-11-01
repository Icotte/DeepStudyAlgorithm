struct Heap<T> where T : Comparable {

    //MARK: - properties
    var heap = [T]()
    let comparer : (T,T)-> Bool
    var isEmpty : Bool {
        return heap.isEmpty
    }
    //MARK: - Lifecycle    
    init(comparer : @escaping (T,T)->Bool) {
        self.comparer = comparer
    }
    
    init() {
        self.init(comparer: <)
    }
}

//MARK: - Helpers
// 큐의 삽입, 삭제 연산 이있습니다. 삭제연산의 경우 heapify를 만족할 때까지 함수가 실행됩니다.
extension Heap {

    mutating func insert(_ element : T) {
        var idx = heap.count
        heap.append(element)
        while idx > 0 && comparer(heap[idx],heap[(idx-1)/2]) {
            heap.swapAt(idx, (idx-1)/2)
            idx = (idx-1)/2
        }
    }
    
    mutating func delete() -> T? {
        guard !heap.isEmpty else {
            return nil
        }
        if heap.count == 1 {
            return heap.removeFirst()
        }
        let res = heap.first
        heap.swapAt(0, heap.count-1)
        _ = heap.popLast()
        var idx = 0
        while idx < heap.count {
            let (left,right) = (idx*2+1,idx*2+2)
            if right < heap.count {
                if comparer(heap[left],heap[right]) && comparer(heap[left],heap[idx]) {
                    heap.swapAt(left, idx)
                    idx = left
                } else if comparer(heap[right],heap[idx]) {
                    heap.swapAt(right, idx)
                    idx = right
                } else {
                    break
                }
            } else if left < heap.count {
                if comparer(heap[left],heap[idx]) {
                    heap.swapAt(left, idx)
                    idx = left
                } else {
                    break
                }
            } else {
                break
            }
        }
        return res
    }
}
