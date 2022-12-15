//
//  day15.swift
//  aoc2022
//
//  Created by Ben Liset on 12/15/22.
//

import Foundation

class day15: Puzzle {
    func runPart1Sample() -> Int {
        return runPart1(Input.day15.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day15.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day15.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day15.actual)
    }
    
    private func runPart1(_ input: [String]) -> Int {
        let sensors = input.map(parseSensor)
        let targetY = (sensors.count > 15) ? 2000000 : 10
        var excludedSpots = Set<Int>()
        for sensor in sensors {
            excludedSpots = excludedSpots.union(sensor.generateEliminatedXCoordinates(row: targetY))
        }
        
        let overlappingSensors = sensors.filter { $0.point.y == targetY }.map(\.point.x)
        let overlappingBeacons = sensors.filter { $0.beacon.y == targetY }.map(\.beacon.x)
        excludedSpots = excludedSpots.subtracting(overlappingSensors)
        excludedSpots = excludedSpots.subtracting(overlappingBeacons)
        
        return excludedSpots.count
    }
    
    private func runPart2(_ input: [String]) -> Int {
        let sensors = input.map(parseSensor)
        
        let maxV = sensors.count > 15 ? 4000000 : 20
        var tuningFrequency: Int?
        for x in 0...maxV {
            var y = 0
            while y <= maxV && tuningFrequency == nil {
                let coord = Point(x: x, y: y)
                let sensorInRange = sensors.first { abs($0.point.x - coord.x) + abs($0.point.y - coord.y) <= $0.distance }
                if let sensorInRange {
                    let xdist = abs(sensorInRange.point.x - x)
                    y = sensorInRange.point.y + sensorInRange.distance - xdist + 1
                } else {
                    tuningFrequency = (coord.x  * 4000000) + coord.y
                    break
                }
            }
        }
        return tuningFrequency!
    }
    
    private func parseSensor(_ line: String) -> Sensor {
        let regex = /Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/
        
        let match = line.firstMatch(of: regex)!
        let sensorPoint = Point(x: Int(match.output.1)!, y: Int(match.output.2)!)
        let beacon = Point(x: Int(match.output.3)!, y: Int(match.output.4)!)
        return Sensor(point: sensorPoint, beacon: beacon)
    }
    
    struct Sensor {
        let point: Point
        let beacon: Point
        let distance: Int
        
        init(point: Point, beacon: Point) {
            self.point = point
            self.beacon = beacon
            self.distance = abs(point.x-beacon.x) + abs(point.y-beacon.y)
        }
        
        func minX(atY y: Int) -> Int {
            point.x - distance + abs(point.y-y)
        }
        
        func maxX(atY y: Int) -> Int {
            point.x + distance - abs(point.y-y)
        }
        
        func generateEliminatedXCoordinates(row y: Int) -> Set<Int> {
            let minX = point.x - Int(distance)
            let maxX = point.x + Int(distance)
            
            var set = Set<Int>()
            for x in minX...maxX {
                let xDistance = abs(point.x - x) + abs(point.y - y)
                if xDistance <= distance {
                    set.insert(x)
                }
            }
            
            return set
        }
    }
}
