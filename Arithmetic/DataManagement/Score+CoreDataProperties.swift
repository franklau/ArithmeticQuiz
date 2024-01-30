//
//  Score+CoreDataProperties.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-30.
//
//

import Foundation
import CoreData


extension Score {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Score> {
        return NSFetchRequest<Score>(entityName: "Score")
    }

    @NSManaged public var numCorrect: Int64
    @NSManaged public var numWrong: Int64
    @NSManaged public var duration: Int64

}

extension Score : Identifiable {

}
