//
//  ArithmeticOperationTests.swift
//  ArithmeticTests
//
//  Created by Frank Lau on 2024-04-13.
//

import XCTest
@testable import Arithmetic

final class ArithmeticOperationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_generate_numbers_for_addition() {
        let (lhs, rhs) = ArithmeticOperation.add.generateNumbersForLevel(level: .easy)
        XCTAssertGreaterThanOrEqual(lhs, rhs)
        XCTAssertLessThanOrEqual(lhs + rhs, 9 + 9)
        XCTAssertGreaterThanOrEqual(lhs + rhs, 1 + 1)
        
        let (lhsMedium, rhsMedium) = ArithmeticOperation.add.generateNumbersForLevel(level: .medium)
        XCTAssertGreaterThanOrEqual(lhsMedium, rhsMedium)
        let mediumRange = ((10 + 10)..<(99 + 99))
        XCTAssertTrue(mediumRange.contains(lhsMedium + rhsMedium))
        
        let (lhsHard, rhsHard) = ArithmeticOperation.add.generateNumbersForLevel(level: .hard)
        XCTAssertGreaterThanOrEqual(lhsHard, rhsHard)
        let hardRange = (100 + 100)..<(999 + 999)
        XCTAssertTrue(hardRange.contains(lhsHard + rhsHard))
    }
    
    func test_generate_numbers_for_subtraction() {
        let (lhs, rhs) = ArithmeticOperation.subtract.generateNumbersForLevel(level: .easy)
        XCTAssertGreaterThanOrEqual(lhs, rhs)
        XCTAssertTrue((1...9).contains(rhs))
        
        let (lhsMedium, rhsMedium) = ArithmeticOperation.subtract.generateNumbersForLevel(level: .medium)
        XCTAssertGreaterThanOrEqual(lhsMedium, rhsMedium)
        XCTAssertTrue((10...99).contains(rhsMedium))
        
        let (lhsHard, rhsHard) = ArithmeticOperation.subtract.generateNumbersForLevel(level: .hard)
        XCTAssertGreaterThanOrEqual(lhsHard, rhsHard)
        XCTAssertTrue((100...999).contains(rhsHard))
    }
    
    func test_generate_numbers_for_division() {
        let (lhs, rhs) = ArithmeticOperation.divide.generateNumbersForLevel(level: .easy)
        let answer = Double(lhs) / Double(rhs)
        XCTAssertEqual(floor(answer), answer) // check result of division is a whole number
        
        let (lhsMedium, rhsMedium) = ArithmeticOperation.divide.generateNumbersForLevel(level: .medium)
        let answerMedium = Double(lhsMedium) / Double(rhsMedium)
        XCTAssertEqual(floor(answerMedium), answerMedium)
        
        let (lhsHard, rhsHard) = ArithmeticOperation.divide.generateNumbersForLevel(level: .hard)
        let answerHard = Double(lhsHard) / Double(rhsHard)
        XCTAssertEqual(floor(answerHard), answerHard)
    }
    
    func test_generate_numbers_for_multiplication() {
        let (lhs, rhs) = ArithmeticOperation.multiply.generateNumbersForLevel(level: .easy)
        XCTAssertGreaterThan(lhs, rhs)
        XCTAssertLessThanOrEqual(lhs * rhs, 9 * 9)
        
        let (lhsMedium, rhsMedium) = ArithmeticOperation.multiply.generateNumbersForLevel(level: .medium)
        XCTAssertGreaterThan(lhsMedium, rhsMedium)
        XCTAssertLessThanOrEqual(lhsMedium * rhsMedium, 99 * 99)
        
        let (lhsHard, rhsHard) = ArithmeticOperation.multiply.generateNumbersForLevel(level: .hard)
        XCTAssertGreaterThan(lhsHard, rhsHard)
        XCTAssertLessThanOrEqual(lhsHard * rhsHard, 999 * 999)
    }
    
    func test_evaluate() {
        let sum = ArithmeticOperation.add.evaluate(lhs: 20, rhs: 50)
        XCTAssertEqual(sum, 70)
        
        let difference = ArithmeticOperation.subtract.evaluate(lhs: 80, rhs: 30)
        XCTAssertEqual(difference, 50)
        
        let quotient = ArithmeticOperation.divide.evaluate(lhs: 45, rhs: 9)
        XCTAssertEqual(quotient, 5)
        
        let product = ArithmeticOperation.multiply.evaluate(lhs: 9, rhs: 8)
        XCTAssertEqual(product, 72)
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
