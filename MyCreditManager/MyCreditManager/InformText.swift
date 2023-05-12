//
//  InformText.swift
//  MyCreditManager
//
//  Created by KiWoong Hong on 2023/05/13.
//

enum InformText: CustomStringConvertible {
    case requestAddStudentName
    case completeAddStudent(name: String)
    
    case requestDeleteStudentName
    case completeDeleteStudent(name: String)
    
    case requestUpdateGrade
    case completeUpdateGrade(name: String, subject: Subject)
    
    case requestDeleteGrade
    case completeDeleteGrade(name: String, subjectName: String)
    
    var description: String {
        switch self {
        case .requestAddStudentName:
            return "추가할 학생의 이름을 입력해주세요."
        case .completeAddStudent(let name):
            return "\(name) 학생을 추가했습니다."
        case .requestDeleteStudentName:
            return "삭제할 학생의 이름을 입력해주세요."
        case .completeDeleteStudent(let name):
            return "\(name) 학생을 삭제하였습니다."
        case .requestUpdateGrade:
            return """
성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.
입력예) Mickey Swift A+
만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
"""
        case .completeUpdateGrade(let name, let subject):
            return "\(name) 학생의 \(subject.name) 과목이 \(subject.grade)로 추가(변경)되었습니다."
        case .requestDeleteGrade:
            return """
성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.
입력예) Mickey Swift
"""
        case .completeDeleteGrade(let name, let subjectName):
            return "\(name) 학생의 \(subjectName) 과목의 성적이 삭제되었습니다."
        }
    }
}
