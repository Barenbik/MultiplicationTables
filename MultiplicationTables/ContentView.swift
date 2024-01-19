//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Tony Sharples on 18/01/2024.
//

import SwiftUI

struct Question {
    let multiplicationTable: String
    let question: String
    let answer: String
}

struct ContentView: View {
    @State private var multiplicationTable = 2
    @State private var selectedNumberOfQuestions = 5
    @State private var selectedDifficulty = "Easy"
    @State private var questions = [Question]()
    @State private var gameIsActive = true
    @State private var answer = ""
    @State private var questionNumber = 0
    
    var numberOfQuestionsOptions = ["5", "10", "20"]
    var difficultyOptions = ["Easy", "Medium", "Hard"]
    
    var body: some View {
        if gameIsActive {
            NavigationStack {
                Form {
                    Section {
                        if questions.count > 0 {
                            Text(questions[questionNumber].question)
                            TextField("Enter your answer", text: $answer)
                                .keyboardType(.numberPad)
                        }
                    }
                    
                    Section {
                        Button("Submit") {
                            checkAnswer()
                        }
                    }
                }
                .navigationTitle("Question \(questionNumber + 1)")
                // TODO: Remove this once generateQuestions is working on the other NavigationStack.
                .onAppear(perform: generateQuestions)
            }
            
        } else {
            NavigationStack {
                Form {
                    Section {
                        Stepper(value: $multiplicationTable, in: 2...12) {
                            Text("Up to \(multiplicationTable) times tables")
                        }
                        
                        Picker("Number of questions", selection: $selectedNumberOfQuestions) {
                            ForEach(numberOfQuestionsOptions, id: \.self) {
                                Text($0)
                            }
                        }
                        
                        Picker("Difficulty", selection: $selectedDifficulty) {
                            ForEach(difficultyOptions, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    
                    Section {
                        Button("Start") {
                            startGame()
                        }
                    }
                }
                .navigationTitle("Settings")
            }
        }
    }
    
    func startGame() {
        // TODO: Display the questions based on the selected options.
        gameIsActive = false
    }
    
    func generateQuestions() {
        for table in 1...12 {
            for number in 1...20 {
                questions.append(Question(multiplicationTable: "\(table)", question: "\(number) x \(table)", answer: "\(number * table)"))
            }
        }
    }
    
    func checkAnswer() {
        print("Checking answer")
        questionNumber += 1
    }
}

#Preview {
    ContentView()
}
