//
//  GraphViewController.swift
//  GraphyGraph
//
//  Created by Peter Prokop on 18/10/2017.
//  Copyright © 2017 Peter Prokop. All rights reserved.
//

import Cocoa
import GraphyGraphLib

class GraphViewController: NSViewController {

    var graphView = GraphView()

    override func loadView() {
        view = graphView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = NSButton(title: "Start simulation", target: self, action: #selector(startSim))
        button.frame = NSRect(x: 0, y: 0, width: 150, height: 30)
        view.addSubview(button)

        let vv = Set(["1", "2", "3", "4", "5"])
        let ee = Set([
            Edge<String>(source: "1", target: "2"),
            Edge<String>(source: "2", target: "3"),
            Edge<String>(source: "3", target: "1"),
            Edge<String>(source: "3", target: "4"),
            Edge<String>(source: "4", target: "5"),
        ])

        let g = Graph<String>(isDirected: false, vertices: vv, edges: ee)
        graphView.graph = g
    }

    @objc func startSim() {
        graphView.startSimulation()
    }
}

class GraphView: NSView {

    typealias VertexType = String

    var vertexViews: [VertexView] = []
    var vertexToView: [VertexType: VertexView] = [:]

    var graph = Graph<VertexType>(isDirected: false) {
        didSet {
            setup()
        }
    }

    // Simulation-specific stuff
    var count = [VertexType: Int]()
    var bias = [Edge<VertexType>: Int]()

    var timer: Timer?

    var alpha: CGFloat = 1
    let alphaMin: CGFloat = 0.001
    let alphaDecay: CGFloat = 1 - pow(0.001, 1 / 300)
    let alphaTarget: CGFloat = 0
    let velocityDecay: CGFloat = 0.6

    func setup() {
        // Remove old values
        vertexViews.forEach {
            $0.removeFromSuperview()
        }
        vertexViews.removeAll()
        vertexToView.removeAll()
        count.removeAll()
        bias.removeAll()

        timer?.invalidate()
        timer = nil

        // Add vertices
        for v in graph.getVertices {
            let vv = VertexView()
            vertexToView[v] = vv

            vv.backgroundColor = .blue

            let x = CGFloat(arc4random_uniform(200)) + 50
            let y = CGFloat(arc4random_uniform(200)) + 50
            vv.frame = NSRect(x: x, y: y, width: 20, height: 20)

            vertexViews.append(vv)
            addSubview(vv)
        }

        // New values
        for vertex in graph.getVertices {
            count[vertex] = graph.reachable(from: vertex).count
        }

        for edge in graph.getEdges {
            bias[edge] = count[edge.source]! / (count[edge.source]! + count[edge.target]!)
        }
    }

    override func draw(_ dirtyRect: NSRect) {
        NSGraphicsContext.current?.saveGraphicsState()

        var edges = graph.getEdges
        while let e = edges.popFirst() {
            // TODO: add arrows for directed graph
            if !graph.isDirected {
                edges.remove(e.reversed)
            }

            let source = vertexToView[e.source]!
            let target = vertexToView[e.target]!

                let line = NSBezierPath()
                line.move(to: source.frame.center)
                line.line(to: target.frame.center)
                line.lineWidth = 1
                NSColor.lightGray.set()

                line.stroke()
        }

        NSGraphicsContext.current?.restoreGraphicsState()
    }

    func startSimulation() {
        alpha = 1
        timer = Timer.scheduledTimer(timeInterval: 0.015, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }

    @objc func tick() {
        if alpha < alphaMin {
            timer?.invalidate()
            timer = nil
        }

        force(alpha: alpha/20)
        alpha += (alphaTarget - alpha) * alphaDecay

        for v in vertexViews  {
            v.vx *= velocityDecay
            v.vy *= velocityDecay

            v.frame.origin.x += v.vx
            v.frame.origin.y += v.vy
        }

        needsDisplay = true
    }

    func force(alpha: CGFloat) {
        // Just 1 iteration

        for edge in graph.getEdges {
            let source = vertexToView[edge.source]!
            let target = vertexToView[edge.target]!
            var x = target.frame.center.x + target.vx - source.frame.center.x - source.vx
            var y = target.frame.center.y + target.vy - source.frame.center.y - source.vy

            let defaultDistance: CGFloat = 60

            var l = sqrt(x*x + y*y)
            l = (l - defaultDistance) / l * alpha * defaultStrength(edge: edge)
            x *= l; y *= l

            let b = CGFloat(bias[edge]!)

            target.vx -= x * b
            target.vy -= y * b

            source.vx += x * (1 - b)
            source.vy += y * (1 - b)
          }
    }

    func defaultStrength(edge: Edge<VertexType>) -> CGFloat {
        return 1 / CGFloat(min(count[edge.source]!, count[edge.target]!))
    }

}

extension NSRect {
    var center: NSPoint {
        return NSPoint(x: origin.x + size.width/2, y: origin.y + size.height/2)
    }
}
