//
//  AppDelegate.swift
//  testrecorder
//
//  Created by Jeff Sinckler on 5/8/18.
//  Copyright © 2018 Bkryno. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  @IBOutlet weak var window: RecordingWindow!

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    // Insert code here to initialize your application
    
    window.contentView?.window?.backgroundColor = NSColor.blue.withAlphaComponent(0.3)
    window.styleMask = [.borderless, .resizable]
    window.isMovableByWindowBackground = true
  }
  
  //MARK: - Tap Handlers
  @IBAction func didTapRecord(sender: NSView) {
    window.startRecording()
  }
}

