//
//  QuizSettings+CoreDataProperties.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-30.
//
//

import Foundation
import CoreData


extension QuizSettings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuizSettings> {
        return NSFetchRequest<QuizSettings>(entityName: "QuizSettings")
    }

    @NSManaged public var level: String?
    @NSManaged public var durationInSeconds: Int64
    @NSManaged public var type: String?

}

extension QuizSettings : Identifiable {
  
}
