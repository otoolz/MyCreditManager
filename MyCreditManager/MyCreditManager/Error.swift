//
//  Error.swift
//  MyCreditManager
//
//  Created by KiWoong Hong on 2023/05/13.
//

enum ManagerError: Error, CustomDebugStringConvertible {
    case wrongInput
    case duplicatedInput(name: String)
    case notFoundStudent(name: String)
    case notFoundSubject(name: String, subjectName: String)
    
    var debugDescription: String {
        switch self {
        case .wrongInput: return "입력이 잘못되었습니다. 다시 확인해주세요."
        case .duplicatedInput(let name): return "\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다."
        case .notFoundStudent(let name): return "\(name) 학생을 찾지 못했습니다."
        case .notFoundSubject(let name, let subjectName): return "\(name) 학생의 \(subjectName) 과목의 성적은 찾지 못했습니다."
        }
    }
}
