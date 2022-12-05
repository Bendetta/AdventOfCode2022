//
//  aoc2022Tests.swift
//  aoc2022Tests
//
//  Created by Ben Liset on 12/2/22.
//

import XCTest
@testable import aoc2022

final class aoc2022Tests: XCTestCase {

    // MARK: Day 1
    
    func test_day1Part1Sample() {
        let value = day1().runPart1Sample()
        XCTAssertEqual(value, 24000)
    }
    
    func test_day1Part1Actual() {
        let value = day1().runPart1Actual()
        XCTAssertEqual(value, 74394)
    }
    
    func test_day1Part2Sample() {
        let value = day1().runPart2Sample()
        XCTAssertEqual(value, 45000)
    }
    
    func test_day1Part2Actual() {
        let value = day1().runPart2Actual()
        XCTAssertEqual(value, 212836)
    }
    
    // MARK: Day 2
    
    func test_day2Part1Sample() {
        let value = day2().runPart1Sample()
        XCTAssertEqual(value, 15)
    }
    
    func test_day2Part1Actual() {
        let value = day2().runPart1Actual()
        XCTAssertEqual(value, 12458)
    }
    
    func test_day2Part2Sample() {
        let value = day2().runPart2Sample()
        XCTAssertEqual(value, 12)
    }
    
    func test_day2Part2Actual() {
        let value = day2().runPart2Actual()
        XCTAssertEqual(value, 12683)
    }

    // MARK: Day 3
    
    func test_day3Part1Sample() {
        let value = day3().runPart1Sample()
        XCTAssertEqual(value, 157)
    }
    
    func test_day3Part1Actual() {
        let value = day3().runPart1Actual()
        XCTAssertEqual(value, 8123)
    }
    
    func test_day3Part2Sample() {
        let value = day3().runPart2Sample()
        XCTAssertEqual(value, 70)
    }
    
    func test_day3Part2Actual() {
        let value = day3().runPart2Actual()
        XCTAssertEqual(value, 2620)
    }

}
