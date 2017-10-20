//
//  MainViewController.swift
//  GraphyGraph
//
//  Created by Peter Prokop on 07/10/2017.
//  Copyright © 2017 Peter Prokop. All rights reserved.
//

import Cocoa
import GraphyGraphLib

class MainViewController: NSViewController {

    fileprivate var splitView: NSSplitView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let view1 = NSView()
        view1.backgroundColor = NSColor.red

        let graphViewController = GraphViewController()

        addChildViewController(graphViewController)

        splitView = NSSplitView(frame: view.bounds)
        splitView.translatesAutoresizingMaskIntoConstraints = false

        splitView.isVertical = true
        splitView.addArrangedSubview(view1)
        splitView.addArrangedSubview(graphViewController.view)

        view.addSubview(splitView)

        let constraint1 = NSLayoutConstraint(
            item: splitView,
            attribute: .left,
            relatedBy: .equal,
            toItem: view,
            attribute: .left,
            multiplier: 1,
            constant: 0
        )

        let constraint2 = NSLayoutConstraint(
            item: splitView,
            attribute: .right,
            relatedBy: .equal,
            toItem: view,
            attribute: .right,
            multiplier: 1,
            constant: 0
        )

        let constraint3 = NSLayoutConstraint(
            item: splitView,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1,
            constant: 0
        )

        let constraint4 = NSLayoutConstraint(
            item: splitView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )

        view.addConstraints([
            constraint1,
            constraint2,
            constraint3,
            constraint4,
        ])
    }

    override func viewDidLayout() {
        super.viewDidLayout()

        splitView.setPosition(100, ofDividerAt: 0)
    }
}
