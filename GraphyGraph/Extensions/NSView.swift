//
//  NSView.swift
//  GraphyGraph
//
//  Created by Peter Prokop on 07/10/2017.
//  Copyright © 2017 Peter Prokop. All rights reserved.
//

import Cocoa

extension NSView {
    var backgroundColor: NSColor? {
        get {
            guard let color = layer?.backgroundColor else { return nil }
            return NSColor(cgColor: color)
        }
        set {
            wantsLayer = true
            layer?.backgroundColor = newValue?.cgColor
        }
    }
}
