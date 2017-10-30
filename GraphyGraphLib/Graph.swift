//
//  Graph.swift
//  GraphyGraphLib
//
//  Created by Peter Prokop on 08/10/2017.
//  Copyright © 2017 Peter Prokop. All rights reserved.
//

open class Graph<V: Hashable> {

    public let isDirected: Bool

    var vertices: Set<V> = []
    var edges: Set<Edge<V>> = []
    var adjacency: [V: Set<Edge<V>>] = [:]

    public var getEdges: Set<Edge<V>> {
        return edges
    }

    public var getVertices: Set<V> {
        return vertices
    }

    public var vertexCount: Int {
        return vertices.count
    }

    public var edgeCount: Int {
        return edges.count
    }

    public init(isDirected: Bool) {
        self.isDirected = isDirected
    }

    public init(isDirected: Bool, vertices: Set<V>, edges: Set<Edge<V>>) {
        self.isDirected = isDirected

        for v in vertices {
            addVertex(v)
        }

        for e in edges {
            addEdge(e)
        }
    }

    /// Find all vertices directly reachable from given Vertex.
    ///
    /// - parameter vertex: The vertex to find reachable vertices.
    /// - returns: An array of the reachable vertices.
    public func reachableArray(from vertex: V) -> [V] {
        if isDirected {
            guard let edges = adjacency[vertex] else {
                 return []
            }
            return edges.map { $0.target }
        } else {
            let reachable = edges.filter { $0.target == vertex}.map { $0.source }
                + edges.filter { $0.source == vertex}.map { $0.target }

            return reachable
        }
    }

    /// Find all vertices directly reachable from given Vertex.
    ///
    /// - parameter vertex: The vertex to find reachable vertices.
    /// - returns: An set of the reachable vertices.
    public func reachable(from vertex: V) -> Set<V> {
        return Set<V>(reachableArray(from: vertex))
    }

    /// Find all of the edges where given vertex is source.
    ///
    /// - parameter vertex: The vertex to find the edges of.
    public func edges(for vertex: V) -> Set<Edge<V>>? {
        return adjacency[vertex]
    }

    /// Finds if edge exists from on vertex to another
    ///
    /// - parameter from: The from vertex.
    /// - parameter to: The to vertex.
    /// - returns: A Bool that is true if such an edge exists, and false otherwise.
    public func edgeExists(from: V, to: V) -> Bool {
        return adjacency[from]?.first(where: { $0.target == to }) != nil
    }

    /// Find the first occurence of a vertex.
    ///
    /// - parameter vertex: The vertex you are looking for.
    public func vertexInGraph(_ vertex: V) -> Bool {
        return vertices.contains(vertex)
    }

    /// Add a vertex to the graph.
    ///
    /// - parameter v: The vertex to be added.
    public func addVertex(_ vertex: V) {
        guard !vertices.contains(vertex) else {
            return
        }

        vertices.insert(vertex)
        adjacency[vertex] = []
    }

    /// Add an edge to the graph.
    ///
    /// - parameter e: The edge to add.
    public func addEdge(_ edge: Edge<V>) {
        edges.insert(edge)

        // TODO: check if vertex exists?
        // TODO: check if edge exists?
        adjacency[edge.source]?.insert(edge)

        if !isDirected {
            edges.insert(edge.reversed)
            adjacency[edge.target]?.insert(edge.reversed)
        }
    }

    /// Removes the first occurence of a vertex, all of the edges attached to it
    ///
    /// - parameter vertex: The vertex to be removed..
    public func removeVertex(_ vertex: V) {
        vertices.remove(vertex)

        edges = edges.filter { edge -> Bool in
            return (edge.source != vertex) && (edge.target != vertex)
        }

        adjacency[vertex] = nil

        if !isDirected {
            for v in vertices {
                guard let edges = adjacency[v] else {
                    continue
                }

                adjacency[v] = edges.filter { edge -> Bool in
                    return (edge.source != vertex) && (edge.target != vertex)
                }
            }
        }
    }

    public func removeEdge(_ edge: Edge<V>) {
        edges.remove(edge)

        adjacency[edge.source]?.remove(edge)

        if !isDirected {
            adjacency[edge.target]?.remove(edge.reversed)
        }
    }

    public func copy() -> Graph<V> {
        let copy = Graph<V>(isDirected: isDirected)
        copy.vertices = vertices
        copy.edges = edges
        copy.adjacency = adjacency

        return copy
    }
}

extension Graph where V: CustomDebugStringConvertible {
    public var debugDescription: String {
        return adjacency.map {
            let targets = $0.value.map { $0.target.debugDescription }.joined(separator: ", ")
            return "\($0.key.debugDescription) -> \(targets)"
        }.joined(separator: "\n")
    }
}

extension Graph {

    /// Returns all paths starting and ending at `startingAt`
    public func computeWalkthrough(startingAt: V) -> [[Edge<V>]] {
        var walks = [[Edge<V>]]()

        for e in adjacency[startingAt]! {
            let c = copy()
            c.removeEdge(e)

            if let rest = c.computeWalkthrough(startingAt: e.target, endingAt: startingAt) {
                for r in rest {
                    walks.append([e] + r)
                }
            }

        }

        return walks
    }

    /// Returns all paths starting and ending at `startingAt`
    /// and ending at `endingAt`
    public func computeWalkthrough(startingAt: V, endingAt: V) -> [[Edge<V>]]? {
        if startingAt == endingAt {
            return []
        }

        var walks = [[Edge<V>]]()

        let adj = adjacency[startingAt]!
        for e in adj {
            let c = copy()
            c.removeVertex(startingAt)

            if let rest = c.computeWalkthrough(startingAt: e.target, endingAt: endingAt) {
                for r in rest {
                    walks.append([e] + r)
                }

                if rest.count == 0 {
                    walks.append([e])
                }
            }

        }

        return walks.count > 0 ? walks : nil
    }
}
