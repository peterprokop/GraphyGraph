//
//  GraphViewController.swift
//  GraphyGraph
//
//  Created by Peter Prokop on 18/10/2017.
//  Copyright © 2017 Peter Prokop. All rights reserved.
//

import Cocoa

class GraphViewController: NSViewController {

    var graphView = GraphView()

    override func loadView() {
        view = graphView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cyan

        let vv = VertexView()
        vv.backgroundColor = .red
        vv.frame = NSRect(x: 10, y: 10, width: 20, height: 20)
        graphView.addVertex(vv)

        let vv1 = VertexView()
        vv1.backgroundColor = .blue
        vv1.frame = NSRect(x: 50, y: 10, width: 20, height: 20)
        graphView.addVertex(vv1)

        let vv2 = VertexView()
        vv2.backgroundColor = .orange
        vv2.frame = NSRect(x: 10, y: 50, width: 20, height: 20)
        graphView.addVertex(vv2)
    }
    
}

class GraphView: NSView {

    var vertice: [VertexView] = []

    override func draw(_ dirtyRect: NSRect) {
        for i in 0 ..< vertice.count {
            for j in i + 1 ..< vertice.count {
                NSGraphicsContext.current?.saveGraphicsState()

                let line = NSBezierPath()
                line.move(to: vertice[i].frame.center)
                line.line(to: vertice[j].frame.center)
                line.lineWidth = 5
                NSColor.red.set()

                line.stroke()

                NSGraphicsContext.current?.restoreGraphicsState()
            }
        }
    }

    func addVertex(_ vertexView: VertexView) {
        vertice.append(vertexView)
        addSubview(vertexView)
    }

}

extension NSRect {
    var center: NSPoint {
        return NSPoint(x: origin.x + size.width/2, y: origin.y + size.height/2)
    }
}
