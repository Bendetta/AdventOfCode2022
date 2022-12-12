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
    
    // MARK: Day 4
    
    func test_day4Part1Sample() {
        let value = day4().runPart1Sample()
        XCTAssertEqual(value, 2)
    }
    
    func test_day4Part1Actual() {
        let value = day4().runPart1Actual()
        XCTAssertEqual(value, 431)
    }
    
    func test_day4Part2Sample() {
        let value = day4().runPart2Sample()
        XCTAssertEqual(value, 4)
    }
    
    func test_day4Part2Actual() {
        let value = day4().runPart2Actual()
        XCTAssertEqual(value, 823)
    }

    // MARK: Day 5
    
    func test_day5Part1Sample() {
        let value = day5().runPart1Sample()
        XCTAssertEqual(value, "CMZ")
    }
    
    func test_day5Part1Actual() {
        let value = day5().runPart1Actual()
        XCTAssertEqual(value, "RNZLFZSJH")
    }
    
    func test_day5Part2Sample() {
        let value = day5().runPart2Sample()
        XCTAssertEqual(value, "MCD")
    }
    
    func test_day5Part2Actual() {
        let value = day5().runPart2Actual()
        XCTAssertEqual(value, "CNSFCGJSM")
    }
    
    // MARK: Day 6
    
    func test_day6Part1Sample() {
        let value = day6().runPart1Sample()
        XCTAssertEqual(value, 7)
    }
    
    func test_day6Part1Actual() {
        let value = day6().runPart1Actual()
        XCTAssertEqual(value, 1542)
    }
    
    func test_day6Part2Sample() {
        let value = day6().runPart2Sample()
        XCTAssertEqual(value, 19)
    }
    
    func test_day6Part2Actual() {
        let value = day6().runPart2Actual()
        XCTAssertEqual(value, 3153)
    }
    
    // MARK: Day 7
    
    func test_day7Part1Sample() {
        let value = day7().runPart1Sample()
        XCTAssertEqual(value, 95437)
    }
    
    func test_day7Part1Actual() {
        let value = day7().runPart1Actual()
        XCTAssertEqual(value, 1084134)
    }
    
    func test_day7Part2Sample() {
        let value = day7().runPart2Sample()
        XCTAssertEqual(value, 24933642)
    }
    
    func test_day7Part2Actual() {
        let value = day7().runPart2Actual()
        XCTAssertEqual(value, 6183184)
    }
    
    // MARK: Day 8
    
    func test_day8Part1Sample() {
        let value = day8().runPart1Sample()
        XCTAssertEqual(value, 21)
    }
    
    func test_day8Part1Actual() {
        let value = day8().runPart1Actual()
        XCTAssertEqual(value, 1693)
    }
    
    func test_day8Part2Sample() {
        let value = day8().runPart2Sample()
        XCTAssertEqual(value, 8)
    }
    
    func test_day8Part2Actual() {
        let value = day8().runPart2Actual()
        XCTAssertEqual(value, 422059)
    }
    
    // MARK: Day 9
    
    func test_day9Part1Sample() {
        let value = day9().runPart1Sample()
        XCTAssertEqual(value, 13)
    }
    
    func test_day9Part1Actual() {
        let value = day9().runPart1Actual()
        XCTAssertEqual(value, 6266)
    }
    
    func test_day9Part2Sample() {
        let value = day9().runPart2Sample()
        XCTAssertEqual(value, 36)
    }
    
    func test_day9Part2Actual() {
        let value = day9().runPart2Actual()
        XCTAssertEqual(value, 2369)
    }
    
    // MARK: Day 10
    
    func test_day10Part1Sample() {
        let value = day10().runPart1Sample()
        XCTAssertEqual(value, 13140)
    }
    
    func test_day10Part1Actual() {
        let value = day10().runPart1Actual()
        XCTAssertEqual(value, 15880)
    }
    
    func test_day10Part2Sample() {
        let value = day10().runPart2Sample()
        XCTAssertEqual(value, 0)
    }
    
    func test_day10Part2Actual() {
        let value = day10().runPart2Actual()
        XCTAssertEqual(value, 0)
    }
}
