//
//  Score+CoreDataClass.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-30.
//
//

import Foundation
import CoreData


public class Score: NSManagedObject {
  
  static func createScore(type: String, numCorrect: Int, numWrong: Int, duration: Int, into context: NSManagedObjectContext) -> Score {
    let score = Score(entity: Score.entity(), insertInto: context)
    score.numCorrect = Int64(numCorrect)
    score.numWrong = Int64(numWrong)
    score.type = type
    score.duration = Int64(duration)
    return score
  }
  
  func fetchAll(using context: NSManagedObjectContext) {
    
  }
}
