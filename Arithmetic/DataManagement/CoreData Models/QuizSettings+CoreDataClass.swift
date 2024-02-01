//
//  QuizSettings+CoreDataClass.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-30.
//
//

import Foundation
import CoreData

public class QuizSettings: NSManagedObject {
  
  static func fetchOrCreateQuizSetting(operation: ArithmeticOperation, context: NSManagedObjectContext) throws -> QuizSettings {
    let fetchRequest = Self.fetchRequest()
    let type = operation.rawValue
    fetchRequest.predicate = NSPredicate(format: "type == %@", type)
    do {
      let results = try context.fetch(fetchRequest)
      if let quizSetting = results.first {
        return quizSetting
      } else {
       return  createQuizSettings(type: operation, level: Constants.defaultLevel, duration: Constants.defaultQuizDuration , in: context)
      }
    } catch let error {
      throw error
    }
  }
  
  static func createQuizSettings(type: ArithmeticOperation,
                          level: ArithmeticOperation.Level,
                          duration: Int,
                          in context: NSManagedObjectContext) -> QuizSettings {
    let quizSetting = QuizSettings(entity: Self.entity(), insertInto: context)
    quizSetting.type = type.rawValue
    quizSetting.level = level.rawValue
    quizSetting.durationInSeconds = Int64(duration)
    return quizSetting
  }
}
