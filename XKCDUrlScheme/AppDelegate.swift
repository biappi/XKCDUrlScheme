//
//  AppDelegate.swift
//  XKCDUrlScheme
//
//  Created by Antonio Malara on 5/10/17.
//  Copyright © 2017 Antonio Malara. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSAppleEventManager.shared().setEventHandler(self,
                                                     andSelector: #selector(handleGetUrl),
                                                     forEventClass: AEEventClass(kInternetEventClass),
                                                     andEventID: AEEventID(kAEGetURL))
    }
    
    @IBAction func showWindow(_ sender: Any) {
        window.makeKeyAndOrderFront(self)
    }

    func handleGetUrl(event: NSAppleEventDescriptor, replyEvent: NSAppleEventDescriptor) {
        if let xkcdURL =
            event
                .paramDescriptor(forKeyword: keyDirectObject)?
                .stringValue
                .flatMap ({ URL(string: $0) })?
                .host
                .flatMap ({ Int($0) })
                .flatMap ({ return NSURL(string: "https://xkcd.com/\($0)")})
        {
            NSWorkspace.shared().open(xkcdURL as URL)
            print(xkcdURL)
        }
    }
}

