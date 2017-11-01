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

    func testWalkthrough() {
        let graph = Graph<String>(isDirected: false)

        let vv = [
            "T", "H", "N", "O", "P", "I", "O2", "S", "S2", "E", "E2", "R", "A", "W", "E3", "B", "L", "S", "I2", "S3", "Y"
        ]

        for v in vv {
            graph.addVertex(v)
        }

        let ee = [
            Edge<String>(source: "T", target: "H"),
            Edge<String>(source: "T", target: "Y"),

            Edge<String>(source: "H", target: "O"),
            Edge<String>(source: "H", target: "N"),
            Edge<String>(source: "H", target: "I"),
            Edge<String>(source: "H", target: "E"),

            Edge<String>(source: "O", target: "N"),
            Edge<String>(source: "O", target: "P"),

            Edge<String>(source: "N", target: "P"),
            Edge<String>(source: "N", target: "O2"),
            Edge<String>(source: "N", target: "S2"),
            Edge<String>(source: "N", target: "S"),

            Edge<String>(source: "Y", target: "A"),
            Edge<String>(source: "Y", target: "W"),
            Edge<String>(source: "Y", target: "I2"),

            Edge<String>(source: "A", target: "W"),

            Edge<String>(source: "I", target: "S"),
            Edge<String>(source: "I", target: "E2"),
            Edge<String>(source: "I", target: "E3"),
            Edge<String>(source: "I", target: "E"),
            Edge<String>(source: "I", target: "R"),

            Edge<String>(source: "E", target: "R"),

            Edge<String>(source: "R", target: "E2"),

            Edge<String>(source: "E2", target: "W"),

            Edge<String>(source: "W", target: "E3"),
            Edge<String>(source: "W", target: "L"),

            Edge<String>(source: "P", target: "O2"),

            Edge<String>(source: "O2", target: "S2"),

            Edge<String>(source: "S", target: "B"),

            Edge<String>(source: "S2", target: "B"),
            Edge<String>(source: "S2", target: "S3"),

            Edge<String>(source: "E3", target: "L"),

            Edge<String>(source: "L", target: "B"),

            Edge<String>(source: "Y", target: "B"),

            Edge<String>(source: "I2", target: "B"),
            Edge<String>(source: "I2", target: "S3"),

            Edge<String>(source: "S3", target: "B"),
        ]

        for e in ee {
            graph.addEdge(e)
        }

        let walks = graph.computeWalkthrough(startingAt: "T")

        let fullWalks = walks.filter { $0.count == vv.count - 1 }
        XCTAssertEqual(fullWalks.count, 2)
    }
}
