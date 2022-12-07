//
//  day7.swift
//  aoc2022
//
//  Created by Ben Liset on 12/7/22.
//

import Foundation

class day7: Puzzle {
    func runPart1Sample() -> Int {
        return runPart1(Input.day7.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day7.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day7.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day7.actual)
    }
    
    private func runPart1(_ input: [String]) -> Int {
        let tree = buildTree(from: input)
        let maxSize = 100000
        var currentSize = 0
        
        tree.depthFirstTraversal { node in
            if case .directory(_) = node.value {
                let dirSize = getDirectorySize(node: node)
                if dirSize <= maxSize {
                    print("\(node.value) (\(dirSize))")
                    currentSize += dirSize
                }
            }
        }

        return currentSize
    }
    
    private func runPart2(_ input: [String]) -> Int {
        let tree = buildTree(from: input)
        
        let currentFileSize = getDirectorySize(node: tree)
        let remainingSpace = 70000000 - currentFileSize
        let spaceToFreeUp = 30000000 - remainingSpace
        
        var deletionCandidates = [Int]()
        
        tree.depthFirstTraversal { node in
            if case .directory(_) = node.value {
                deletionCandidates.append(getDirectorySize(node: node))
            }
        }
        return deletionCandidates.sorted().first { $0 >= spaceToFreeUp } ?? 0
    }
    
    enum FileType: Equatable, CustomStringConvertible {
        
        case directory(name: String), file(name: String, size: Int)
        
        var description: String {
            switch self {
            case .directory(let name): do { return "\(name) (dir)"}
            case .file(let name, let size): do { return "\(name) (file, size=\(size)"}
            }
        }
    }
    
    private func buildTree(from input: [String]) -> TreeNode<FileType> {
        let root = TreeNode<FileType>(.directory(name: "/"))
        var currentNode = root
        for line in input {
            let parts = line.components(separatedBy: .whitespaces)
            if parts[0...1] == ["$", "cd"] {
                if parts[2] == ".." {
                    currentNode = currentNode.parent!
                } else {
                    currentNode = currentNode.search(.directory(name: parts[2]))!
                }
            } else if parts[0] != "$" {
                if parts[0] == "dir" {
                    let node = TreeNode(FileType.directory(name: parts[1]))
                    currentNode.add(node)
                } else {
                    let node = TreeNode(FileType.file(name: parts[1], size: Int(parts[0])!))
                    currentNode.add(node)
                }
            }
        }
        
        return root
    }
    
    private func getDirectorySize(node: TreeNode<FileType>) -> Int {
        var sum = 0
        node.depthFirstTraversal { node in
            switch node.value {
            case .file(_, let size): sum += size
            default: break
            }
        }
        return sum
    }
    
    private func printTree(root: TreeNode<Any>) {
        root.depthFirstTraversal { node in
            var parentPrefix = ""
            var parentNode = node.parent
            while parentNode != nil {
                parentPrefix += "-"
                parentNode = parentNode?.parent
            }
            print("\(parentPrefix) \(node.value)".trimmingCharacters(in: .whitespaces))
        }
    }
}
