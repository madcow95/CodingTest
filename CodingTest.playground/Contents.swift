import Foundation

// MARK: - 프로그래머스 문제 가장 큰 수 - https://school.programmers.co.kr/learn/courses/30/lessons/42746
func solution1(_ numbers:[Int]) -> String {
    /*
        MARK: 내가 작성한 정답
        let sortedNumbers = numbers.map{ String($0) }.sorted{ $0 + $1 > $1 + $0 }
        return sortedNumbers.count > 0 ? sortedNumbers.joined() : "0"
        MARK: ERROR CASE - 입력으로 [0, 0, 0, 0]이 주어질 경우 "0000"을 반환하기 때문에 오답
    */
    
    // MARK: sorted 분석 - String으로 형변환 후 두 문자열을 붙였을 때 "3", "30"일 경우 "330" 과 "303"을 비교하는 형식
    let sortedNumbers = numbers.map{ String($0) }.sorted{ $0 + $1 > $1 + $0 }
    // 정답의 ERROR CASE에 대한 분기처리
    if let firstNum = sortedNumbers.first, firstNum != "0" {
        return sortedNumbers.joined()
    } else {
        return "0"
    }
}

// MARK: - H-Index - https://school.programmers.co.kr/learn/courses/30/lessons/42747#fn1
func solution2(_ citations:[Int]) -> Int {
    var answer = -1
    // 문제에서 인용 횟수가 논문의 수보다 작거나 같아지는 값 -> H-Index
    // 1. 배열을 내림차순으로 정렬
    var sortedCitations = citations.sorted(by: >)
    
    for(idx, citaion) in sortedCitations.enumerated() {
        // 내림차순으로 정렬된 논문수를 반복하며 정답 조건 검색
        if citaion >= idx + 1 {
            answer = citaion
        } else {
            break
        }
    }
    return answer
}

// MARK: 해시 - 의상 - https://school.programmers.co.kr/learn/courses/30/lessons/42578?language=swift
func solution3(_ clothes:[[String]]) -> Int {
    /*
    MARK: - 내가 작성한 정답
    var clothDictionary: [String: [String]] = [:]
    var keys: [String] = []
    
    for cloth in clothes {
        if clothDictionary[cloth[1]] == nil {
            clothDictionary[cloth[1]] = [cloth[0]]
        } else {
            clothDictionary[cloth[1]]?.append(cloth[0])
        }
        
        if !keys.contains(cloth[1]) {
            keys.append(cloth[1])
        }
    }
    
    var answer = 0
    for key in keys {
        if let keyCount = clothDictionary[key] {
            answer += keyCount.count
        }
    }
    if clothDictionary.count > 1 {
        answer += clothDictionary.count
    }
    
    return answer
    MARK: - 원인: 나는 단순히 조합의 수를 구해서 더했지만 모든 가능한 의상의 조합을 계산해야함
    */
    
    // clothes의 종류별 의상 개수를 저장할 Dictionary
    var clothDictionary: [String: Int] = [:]
    
    for cloth in clothes {
        let clothType = cloth[1]
        clothDictionary[clothType, default: 0] += 1
    }
    
    var answer = 1
    for count in clothDictionary.values {
        answer *= (count + 1)
    }
    
    // 모든 의상을 입지 않는 경우 제외..?
    return answer - 1
}

// MARK: 스택/큐 - 기능개발 - https://school.programmers.co.kr/learn/courses/30/lessons/42586?language=swift
func solution4(_ progresses:[Int], _ speeds:[Int]) -> [Int] {
    var answer: [Int] = []
    /*
    MARK: - 내가 작성한 정답
    var copiedProgresses = progresses
    var count = 0
    for (index, progress) in progresses.enumerated() {
        var process = progress
        
        if copiedProgresses[index] >= 100 {
            answer.append(count)
            continue
        }
        while process < 100 {
            process += speeds[index]
            for i in index..<copiedProgresses.count {
                copiedProgresses[i] = copiedProgresses[i] + speeds[i]
            }
            count += 1
        }
        answer.append(count)
    }
    
    var uniqueAnswer = Array(Set(answer)).sorted()
    return uniqueAnswer.map{ answer.lastIndex(of: $0)! - answer.firstIndex(of: $0)! + 1 }
    MARK: - 원인: 배표되는 일 수를 계산할 때 제대로 처리되지 않음 -> 1. 중복되는 배포 일수를 처리하지 않음 2. uniqueAnswer에서 중복을 제거한 후 이전과 이후 배포 일수의 차이를 구하는데 오류가 있음
    */
    
    var index = 0
    while index < progresses.count {
        var day = 0
        // 현재 기능의 진행 상황이 100%가 되기 전까지 반복하여 '일수'를 증가시킴
        while progresses[index] + day * speeds[index] < 100 {
            day += 1
        }
        
        // 현재 배포될 기능의 수
        var deplyCount = 0
        // 현재 기능이 완료되어 배포 가능여부 확인
        while index < progresses.count, progresses[index] + day * speeds[index] >= 100 {
            deplyCount += 1
            // 현재 기능이 배포될 수 있을 때 다음 기능으로 넘어가기 위함
            index += 1
        }
        answer.append(deplyCount)
    }
    return answer
}

// MARK: 스택/큐 - 올바른 괄호 - https://school.programmers.co.kr/learn/courses/30/lessons/12909?language=swift
func solution5(_ s:String) -> Bool {
    var stack: [Character] = []
    
    for str in s {
        if str == "(" {
            stack.append(str)
        } else if str == ")" {
            // stack이 empty일 경우 (가 없다 -> 올바른 괄호가 만들어 질 수 없다.
            if stack.isEmpty {
                return false
            }
            // str이 (일 때만 stack에 append하므로, stack의 마지막이 str이 )일 때 처음 만나므로 stack의 마지막을 지워준다.
            stack.removeLast()
        }
    }
    
    return stack.isEmpty
}

/*
MARK: - 잘못된 풀이의 부산물...
func recursiveSolution(stacks: [(Int, Int)], compareProperties: [(Int, Int)], count: Int) -> [(Int, Int)] {
    var copiedCount = count
    var copiedStacks = stacks
    var restProps: [(Int, Int)] = []
    
    for tuple in compareProperties {
        if let lastStack = copiedStacks.last {
            if copiedCount == 0 {
                if lastStack.1 < tuple.1 {
                    copiedStacks.append(tuple)
                } else {
                    if lastStack.1 != tuple.1 {
                        restProps.append(tuple)
                    }
                    continue
                }
            } else {
                copiedStacks.append(tuple)
            }
        }
    }
    
    if restProps.isEmpty {
        return copiedStacks
    } else {
        return recursiveSolution(stacks: copiedStacks, compareProperties: restProps, count: copiedCount + 1)
    }
}
*/

// MARK: 스택/큐 - 프로세스 - https://school.programmers.co.kr/learn/courses/30/lessons/42587?language=swift
func solution6(_ priorities:[Int], _ location:Int) -> Int {
    /*
    // MARK: - 나의 풀이
    var priorityTuple: [(Int, Int)] = priorities.enumerated().map{ (index, priorty) in
        return (priorty, index)
    }.sorted{ $0.0 > $1.0 }

    let result = recursiveSolution(stacks: [priorityTuple[0]], compareProperties: priorityTuple, count: 0)
    return result.firstIndex(where: { $1 == location })! + 1
    */
    return 0
}

print(solution6([2, 1, 3, 2], 2)) // 1
