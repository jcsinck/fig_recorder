//
//  DraggableWindow.swift
//  testrecorder
//
//  Created by Jeff Sinckler on 6/8/18.
//  Copyright © 2018 Bkryno. All rights reserved.
//

import Cocoa
import AVKit

class RecordingWindow: NSWindow {
  
  var captureSession = AVCaptureSession()
  var framesPerSecond: Float = 30.0
  var recordingTime: Float = 3
  
  let url = URL(fileURLWithPath: "/Users/JefeRiffsy/Library/Containers/com.bkryno.testrecorder/Data/Documents/test.mov", isDirectory: false)
  let destinationURL = URL(fileURLWithPath: "/Users/JefeRiffsy/Library/Containers/com.bkryno.testrecorder/Data/Documents/test.gif")
  
  let editorWindow = GifEditorWindowController(windowNibName: NSNib.Name(rawValue: "GifEditorWindowController"))
  
  func startRecording() {
      
    captureSession.sessionPreset = .high
    
    let screenInput = AVCaptureScreenInput(displayID: CGMainDisplayID())
    screenInput.cropRect = frame
    captureSession.addInput(screenInput)
    
    let captureOutput = AVCaptureMovieFileOutput()
    captureSession.addOutput(captureOutput)
    
    alphaValue = 0
    captureSession.startRunning()
    
    captureOutput.startRecording(to: url, recordingDelegate: self)
    
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
      captureOutput.stopRecording()
      self.alphaValue = 1
    }
  }
}

extension RecordingWindow : AVCaptureFileOutputRecordingDelegate {
  func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
    print("Recording Complete: Output: \(outputFileURL), Error: \(error?.localizedDescription)")
    
    Regift.createGIFFromSource(url, destinationFileURL: destinationURL,
                               frameCount: Int(framesPerSecond * recordingTime),
                               delayTime: 0.02,
                               loopCount: 0,
                               size: nil,
                               completion: { (completion) in
                                
                                DispatchQueue.main.async {
                                  print("tektite")
                                  self.editorWindow.showWindow(self)
                                }
                                
//                                self.addChildWindow(GifEditorWindowController().window!, ordered: NSWindow.OrderingMode.above)
    })
  }
}
