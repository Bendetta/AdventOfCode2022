//
//  day2.swift
//  aoc2022
//
//  Created by Ben Liset on 12/2/22.
//

import Foundation

class day2: Puzzle {
    func runPart1Sample() -> Int {
        return runPart1(Input.day2.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day2.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day2.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day2.actual)
    }
    
    enum Shape { case Rock, Paper, Scissors
        static func parse(_ character: String) -> Self {
            switch character {
            case "A", "X": return .Rock
            case "B", "Y": return .Paper
            case "C", "Z": return .Scissors
            default: fatalError("Unexpected input: \(character)")
            }
        }
        
        var points: Int {
            switch self {
            case .Rock: return 1
            case .Paper: return 2
            case .Scissors: return 3
            }
        }
        
        func score(opponent: Shape) -> Int {
            var outcomePoints = 0
            switch self {
            case .Rock:
                outcomePoints = opponent == .Scissors ? Outcome.Win.points : opponent == .Rock ? Outcome.Draw.points  : Outcome.Lose.points
            case .Paper:
                outcomePoints = opponent == .Rock ? Outcome.Win.points  : opponent == .Paper ? Outcome.Draw.points : Outcome.Lose.points
            case .Scissors:
                outcomePoints = opponent == .Paper ? Outcome.Win.points  : opponent == .Scissors ? Outcome.Draw.points : Outcome.Lose.points
            }
            return outcomePoints + self.points
        }
        
        func choose(for outcome: Outcome) -> Int {
            var shapePoints = 0
            switch self {
            case .Rock:
                shapePoints = outcome == .Win ? Shape.Paper.points : outcome == .Draw ? self.points : Shape.Scissors.points
            case .Paper:
                shapePoints = outcome == .Win ? Shape.Scissors.points : outcome == .Draw ? self.points : Shape.Rock.points
            case .Scissors:
                shapePoints = outcome == .Win ? Shape.Rock.points : outcome == .Draw ? self.points : Shape.Paper.points
            }
            return shapePoints + outcome.points
        }
    }
    
    enum Outcome { case Win, Lose, Draw
        static func parse(_ character: String) -> Self {
            switch character {
            case "X": return .Lose
            case "Y": return .Draw
            case "Z": return .Win
            default: fatalError("Unexpected input: \(character)")
            }
        }
        
        var points: Int {
            switch self {
            case .Win: return 6
            case .Draw: return 3
            case .Lose: return 0
            }
        }
    }
    
    private func runPart1(_ input: [String]) -> Int {
        var score = 0
        input.forEach{ line in
            let shapes = line.components(separatedBy: .whitespaces)
            let opponent = Shape.parse(shapes[0])
            let me = Shape.parse(shapes[1])
            score += me.score(opponent: opponent)
        }
        return score
    }
    
    private func runPart2(_ input: [String]) -> Int {
        var score = 0
        input.forEach{ line in
            let shapes = line.components(separatedBy: .whitespaces)
            let opponent = Shape.parse(shapes[0])
            let outcome = Outcome.parse(shapes[1])
            score += opponent.choose(for: outcome)
        }
        return score
    }
}
