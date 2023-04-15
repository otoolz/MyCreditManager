//
//  main.swift
//  MyCreditManager
//
//  Created by KiWoong Hong on 2023/04/16.
//

import Foundation


class MyCreditManager {
    
    private var isRunning = true
    private var answerMenu = ""
    
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


