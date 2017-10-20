//
//  Edge.swift
//  GraphyGraphLib
//
//  Created by Peter Prokop on 08/10/2017.
//  Copyright © 2017 Peter Prokop. All rights reserved.
//

public struct Edge<V: Hashable>: Hashable {

    public let source: V
    public let target: V

    public init(source: V, target: V) {
        self.source = source
        self.target = target
    }

    public static func ==(lhs: Edge<V>, rhs: Edge<V>) -> Bool {
        return lhs.source == rhs.source &&
            lhs.target == rhs.target
    }

    public var hashValue: Int {
        return source.hashValue ^ target.hashValue
    }

    public var reversed: Edge<V> {
        return Edge<V>(source: target, target: source)
    }
}
