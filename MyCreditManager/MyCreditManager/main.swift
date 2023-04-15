//
//  main.swift
//  MyCreditManager
//
//  Created by KiWoong Hong on 2023/04/16.
//

import Foundation

struct Subject {
    var name: String
    var grade: String
}

class MyCreditManager {
    
    private var isRunning = true
    private var answerMenu = ""
    private var students: [String : [Subject]] = [:]
    
    func run() {
        while isRunning {
            switch self.getMenu() {
            case "1" : addStudent()
            case "2" : deleteStudent()
            case "3" : updateGrade()
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
    
    private func addStudent() {
        print("추가할 학생의 이름을 입력해주세요.")
        let name = readLine() ?? " "
        if name.contains(" ") {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        } else {
            if students[name] == nil {
                students[name] = []
                print("\(name) 학생을 추가했습니다.")
            } else {
                print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
            }
        }
        
    }
    
    private func deleteStudent() {
    }
    
    private func updateGrade() {
    }
    
    private func deleteGrade() {
    }
    
    private func checkGrade() {
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


