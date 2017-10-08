//
//  Edge.swift
//  GraphyGraphLib
//
//  Created by Peter Prokop on 08/10/2017.
//  Copyright © 2017 Peter Prokop. All rights reserved.
//

public struct Edge<V: Hashable>: Hashable {
    public var hashValue: Int

    public static func ==(lhs: Edge<V>, rhs: Edge<V>) -> Bool {
        return true
    }

    var source: V
    var target: V

}
