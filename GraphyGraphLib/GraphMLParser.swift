//
//  GraphMLParser.swift
//  GraphyGraphLib
//
//  Created by Peter Prokop on 09/10/2017.
//  Copyright © 2017 Peter Prokop. All rights reserved.
//

import Foundation

class GraphMLParser: NSObject, XMLParserDelegate {

    fileprivate enum Keys {
        static let graph = "graph"
        static let node = "node"
        static let edge = "edge"
    }

    var directedEdgeByDefault = false
    var vertices: [String] = []
    var edges: [Edge<String>] = []

    func parse(url: URL) -> Graph<String> {
        let parser = XMLParser(contentsOf: url)
        parser?.delegate = self
        parser?.parse()

        let verticesSet = Set<String>(vertices)
        let edgesSet = Set<Edge<String>>(edges)
        
        return Graph<String>(isDirected: directedEdgeByDefault, vertices: verticesSet, edges: edgesSet)
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        switch elementName {
        case Keys.graph:
            directedEdgeByDefault = attributeDict["edgedefault"] == "directed"

        case Keys.node:
            if let id = attributeDict["id"] {
                vertices.append(id)
            }
            // TODO: log error otherwise

        case Keys.edge:
            if let source = attributeDict["source"], let target = attributeDict["target"] {
                let edge = Edge<String>(source: source, target: target)
                edges.append(edge)
            }
            // TODO: log error otherwise

        default:
            // TODO: check that it's actually GraphML
            break
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        // Do nothing for now
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        // Do nothing for now
    }

    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
    }

}
