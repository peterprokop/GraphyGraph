//
//  GraphyGraphLibTests.swift
//  GraphyGraphLibTests
//
//  Created by Peter Prokop on 08/10/2017.
//  Copyright © 2017 Peter Prokop. All rights reserved.
//

import XCTest
@testable import GraphyGraphLib

class GraphyGraphLibTests: XCTestCase {

    func testRemoval() {
        let g = Graph<String>(isDirected: false)
        g.addVertex("1")
        g.addVertex("2")
        g.addVertex("3")

        g.addEdge(Edge<String>(source: "1", target: "2"))
        g.addEdge(Edge<String>(source: "3", target: "1"))
        g.addEdge(Edge<String>(source: "2", target: "3"))

        g.removeVertex("2")

        XCTAssertEqual(g.edgeCount, 1)
        XCTAssertEqual(g.vertexCount, 2)

        XCTAssertEqual(g.reachable(from: "1"), ["3"])
        XCTAssertEqual(g.reachable(from: "3"), ["1"])
    }
}
