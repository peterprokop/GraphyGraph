//
//  Edge.swift
//  GraphyGraphLib
//
//  Created by Peter Prokop on 08/10/2017.
//  Copyright © 2017 Peter Prokop. All rights reserved.
//

public struct Edge<V: Hashable>: Hashable {

    let source: V
    let target: V

    public static func ==(lhs: Edge<V>, rhs: Edge<V>) -> Bool {
        return lhs.source == rhs.source &&
            lhs.target == rhs.target
    }

    public var hashValue: Int {
        return source.hashValue ^ target.hashValue
    }

}
