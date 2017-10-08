//
//  AppDelegate.swift
//  GraphyGraph
//
//  Created by Peter Prokop on 07/10/2017.
//  Copyright © 2017 Peter Prokop. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application

        window.contentViewController = MainViewController()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

