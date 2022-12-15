//
//  TreeNode.swift
//  aoc2022
//
//  Created by Ben Liset on 12/7/22.
//

import Foundation

public class TreeNode<T> {
    
    public var value: T
    public var children: [TreeNode] = []
    public var parent: TreeNode?
    
    public init(_ value: T) {
        self.value = value
    }
    
    public func add(_ child: TreeNode) {
        child.parent = self
        children.append(child)        
    }
}

extension TreeNode {
    public func depthFirstTraversal(visit: (TreeNode) -> Void) {
        visit(self)
        children.forEach {
            $0.depthFirstTraversal(visit: visit)
        }
    }
    
    public func levelOrderTraversal(visit: (TreeNode) -> Void) {
            visit(self)
            var queue = [TreeNode]()
            children.forEach { queue.append($0) }
            
            while !queue.isEmpty {
                let node = queue.removeFirst()
                visit(node)
                node.children.forEach { queue.append($0) }
            }
        }
}

extension TreeNode where T: Equatable {
    public func search(_ value: T) -> TreeNode? {
        var result: TreeNode?
        depthFirstTraversal { node in
            if node.value == value {
                result = node
            }
        }
        
        return result
    }
}
