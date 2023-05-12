//
//  main.swift
//  MyCreditManager
//
//  Created by KiWoong Hong on 2023/04/16.
//

import Foundation

struct Subject: Equatable {
    var name: String
    var grade: String
}
enum ManagerError: Error, CustomDebugStringConvertible {
    case wrongInput
    case duplicatedInput(name: String)
    case notFoundInput(name: String)
    
    var debugDescription: String {
        switch self {
        case .wrongInput: return "입력이 잘못되었습니다. 다시 확인해주세요."
        case .duplicatedInput(let name): return "\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다."
        case .notFoundInput(let name): return "\(name) 학생을 찾지 못했습니다."
        }
    }
}

enum InformText: CustomStringConvertible {
    case requestAddStudentName
    case completeAddStudent(name: String)
    
    case requestDeleteStudentName
    case completeDeleteStudent(name: String)
    
    case requestUpdateGrade
    case completeUpdateGrade(name: String, subject: Subject)
    
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
        }
    }
}

class MyCreditManager {
    
    private var isRunning = true
    private var students: [String : [Subject]] = [:]
    
    func run() {
        while isRunning {
            switch self.getMenu() {
            case "1" :
                do { try addStudent() } catch {
                    print(error)
                }
            case "2" :
                do { try deleteStudent() } catch {
                    print(error)
                }
            case "3" :
                do { try updateGrade() } catch {
                    print(error)
                }
            case "4" : deleteGrade()
            case "5" : checkGrade()
            case "X" : exitProgram()
            default : warnWrongMenu()
            }
        }
    }
    
    private func getMenu() -> String {
        print("원하는 기능을 입력하세요")
        print("1: 학생추가 , 2: 학생삭제 , 3: 성적추가(변경) , 4: 성적삭제 , 5: 평점보기 , X: 종료")
        return readLine() ?? "0"
    }
    
    private func addStudent() throws {
        print(InformText.requestAddStudentName)
        
        guard let name = readLine(),
              name.contains(" ") == false else {
            throw ManagerError.wrongInput
        }
        
        guard students[name] == nil else {
            throw ManagerError.duplicatedInput(name: name)
        }
        
        students[name] = []
        print(InformText.completeAddStudent(name: name))
    }
    
    private func deleteStudent() throws {
        print(InformText.requestDeleteStudentName)
        
        guard let name = readLine() else {
            throw ManagerError.wrongInput
        }
        
        guard students[name] != nil else {
            throw ManagerError.notFoundInput(name: name)
        }
        
        students[name] = nil
        print(InformText.completeDeleteStudent(name: name))
    }
    
    private func updateGrade() throws {
        print(InformText.requestUpdateGrade)
        
        guard let inputs = readLine()?.components(separatedBy: " "),
                  inputs.count == 3 else {
            throw ManagerError.wrongInput
        }
        
        let (name, subject) = (inputs[0], Subject(name: inputs[1], grade: inputs[2]))
        
        guard students[name] != nil else {
            throw ManagerError.notFoundInput(name: name)
        }
        
        students[name]?.append(subject)
        print(InformText.completeUpdateGrade(name: name, subject: subject))
    }
    
    private func deleteGrade() {
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift")
        let inputs = (readLine() ?? " ").components(separatedBy: " ")
        guard inputs.count == 2 else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        let (name, subjectName) = (inputs[0], inputs[1])
        
        guard students[name] != nil else {
            print("\(name) 학생을 찾지 못했습니다.")
            return
        }
        guard let index = students[name]?.firstIndex(where: {$0.name == subjectName}) else {
            print("\(name) 학생의 \(subjectName) 과목의 성적은 찾지 못했습니다.")
            return
        }
        students[name]?.remove(at: index)
        print("\(name) 학생의 \(subjectName) 과목의 성적이 삭제되었습니다.")
    }
    
    private func checkGrade() {
        var sum = 0.0
        
        print("평점을 알고싶은 학생의 이름을 입력해주세요.")
        let name = readLine() ?? " "
        guard !name.contains(" ") else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        guard let student = students[name] else {
            print("\(name) 학생을 찾지 못했습니다.")
            return
        }
        for subject in student {
            print("\(subject.name): \(subject.grade)")
            switch subject.grade {
            case "A+": sum += 4.5
            case "A" : sum += 4.0
            case "B+": sum += 3.5
            case "B" : sum += 3.0
            case "C+": sum += 2.5
            case "C" : sum += 2.0
            case "D+": sum += 1.5
            case "D" : sum += 1.0
            default  : sum += 0.0
            }
        }
        let str = String(format: "%.2f", sum / Double(student.count))
        print("평점 : \(str)")
   }
    
    private func warnWrongMenu() {
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
    
    private func exitProgram() {
        print("프로그램을 종료합니다...")
        isRunning.toggle()
    }
}

MyCreditManager().run()

