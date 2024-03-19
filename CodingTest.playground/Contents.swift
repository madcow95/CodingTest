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
    var copiedCitations = citations
    var paperCount = copiedCitations.count
    return 0
}

print(solution2([3, 0, 6, 1, 5]))
