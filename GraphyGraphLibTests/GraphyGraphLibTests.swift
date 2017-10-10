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

    func testParsing() {
        let url = Bundle.main.url(forResource: "simple", withExtension: "graphml")!
        let g = GraphMLParser().parse(url: url)

        XCTAssertEqual(g.vertexCount, 11)

        XCTAssertEqual(g.reachable(from: "n0"), ["n2"])
        XCTAssertEqual(g.reachable(from: "n2"), Set(["n0", "n1", "n3"]))

        XCTAssertEqual(g.reachable(from: "n3"), Set(["n2", "n5", "n4"]))
        XCTAssertEqual(g.reachable(from: "n4"), Set(["n3", "n6"]))
        XCTAssertEqual(g.reachable(from: "n5"), Set(["n3", "n6", "n7"]))
        XCTAssertEqual(g.reachable(from: "n6"), Set(["n4", "n5", "n8"]))

        XCTAssertEqual(g.reachable(from: "n7"), Set(["n5", "n8"]))
        XCTAssertEqual(g.reachable(from: "n8"), Set(["n6", "n7", "n9", "n10"]))
        XCTAssertEqual(g.reachable(from: "n9"), Set(["n8"]))
        XCTAssertEqual(g.reachable(from: "n10"), Set(["n8"]))
    }

}
