//
//  QuestionLoader.swift
//  BincangBareng
//
//  Created by Stefanus Albert Wilson on 10/10/23.
//

import Foundation

func loadQuestionsFromFile(fileName: String) -> [String]? {
    if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let questions = try JSONDecoder().decode([String].self, from: data)
            return questions
        } catch {
            print("Error reading questions from file: \(error)")
        }
    }
    return nil
}
