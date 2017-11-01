//
//  VertexView.swift
//  GraphyGraph
//
//  Created by Peter Prokop on 18/10/2017.
//  Copyright © 2017 Peter Prokop. All rights reserved.
//

import Cocoa

class VertexView: NSView {

    var textField: NSTextField?
    var mouseDownLocation: NSPoint?
    var vx: CGFloat = 0
    var vy: CGFloat = 0

    // MARK: Init

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        setup()
    }

    init() {
        super.init(frame: .zero)
        setup()
    }

    fileprivate func setup() {
        wantsLayer = true
        layer?.cornerRadius = 10
        layer?.masksToBounds = true

        textField = NSTextField(frame: bounds)
        textField?.textColor = .white
        textField?.alignment = .justified//.center
        textField?.isEditable = false
        textField?.isBezeled = false
        textField?.drawsBackground = false
//        textField?.backgroundColor = .blue
        addSubview(textField!)
    }

    // MARK: Other

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }

    override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
        return true
    }

    override func mouseDown(with event: NSEvent) {
        mouseDownLocation = convert(event.locationInWindow, from: nil)
    }

    override func mouseDragged(with event: NSEvent) {

        if
            let newDragLocation = superview?.convert(event.locationInWindow, from: nil),
            let mouseDownLocation = mouseDownLocation
        {
            // Move self
            frame.origin = NSPoint(
                x: newDragLocation.x - mouseDownLocation.x,
                y: newDragLocation.y - mouseDownLocation.y
            )

            superview?.needsDisplay = true
        }
    }

}
