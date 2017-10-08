//
//  MainViewController.swift
//  GraphyGraph
//
//  Created by Peter Prokop on 07/10/2017.
//  Copyright © 2017 Peter Prokop. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let view1 = NSView()
        view1.backgroundColor = NSColor.red

        let view2 = NSView()
        view2.backgroundColor = NSColor.green

        let splitView = NSSplitView(frame: view.bounds)
        splitView.isVertical = true
        splitView.addArrangedSubview(view1)
        splitView.addArrangedSubview(view2)

        view.addSubview(splitView)
    }
    
}
