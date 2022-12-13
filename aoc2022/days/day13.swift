//
//  day13.swift
//  aoc2022
//
//  Created by Ben Liset on 12/13/22.
//

import Foundation

class day13: Puzzle {
    func runPart1Sample() -> Int {
        return runPart1(Input.day13.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day13.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day13.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day13.actual)
    }
    
    private func runPart1(_ input: [String]) -> Int {
        var validIndices = 0
        for (index, block) in input.enumerated() {
            let messages: [Message] = block.splitLines().map {
                return try! JSONDecoder().decode(
                    Message.self,
                    from: $0.data(using: .utf8)!
                )
            }
            let m1 = messages[0]
            let m2 = messages[1]
            
            if m1 < m2 {
                validIndices += (index + 1)
            }
            
        }
        return validIndices
    }
    
    private func runPart2(_ input: [String]) -> Int {
        let div2: Message = [[2]]
        let div6: Message = [[6]]
        
        let messages = (input.flatMap { $0.splitLines() }.map{
            return try! JSONDecoder().decode(
                Message.self,
                from: $0.data(using: .utf8)!
            )} + [div2, div6]).sorted()
        
        let i2 = messages.firstIndex(of: div2)! + 1
        let i6 = messages.firstIndex(of: div6)! + 1
        return i2 * i6
    }
    
    enum Message: ExpressibleByIntegerLiteral, ExpressibleByArrayLiteral, Comparable {
        case value(Int)
        indirect case list([Message])
        
        init(integerLiteral: Int) {
            self = .value(integerLiteral)
        }
        
        init(arrayLiteral: Self...) {
            self = .list(arrayLiteral)
        }
        
        static func < (lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
            case (.value(let l), .value(let r)): return l < r
            case (.value(_), .list(_)): return .list([lhs]) < rhs
            case (.list(_), .value(_)): return lhs < .list([rhs])
            case (.list(let l), .list(let r)):
                for (le, re) in zip(l, r) {
                    if le < re { return true }
                    if le > re { return false }
                }
                return l.count < r.count
            }
        }
    }
    
}

extension day13.Message: Decodable {
    init(from decoder: Decoder) throws {
        do {
            let c = try decoder.singleValueContainer()
            self = .value(try c.decode(Int.self))
        } catch {
            self = .list(try [day13.Message](from: decoder))
        }
    }
}
