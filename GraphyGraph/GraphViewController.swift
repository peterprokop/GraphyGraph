//
//  GraphViewController.swift
//  GraphyGraph
//
//  Created by Peter Prokop on 18/10/2017.
//  Copyright © 2017 Peter Prokop. All rights reserved.
//

import Cocoa

class GraphViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cyan

        let vv = VertexView()
        vv.backgroundColor = .red
        vv.frame = NSRect(x: 10, y: 10, width: 20, height: 20)
        view.addSubview(vv)
    }
    
}
