//
//  LogData.swift
//  TestButtons
//
//  Created by Douglas Adams on 7/25/20.
//  Copyright © 2020 Douglas Adams. All rights reserved.
//

import Cocoa
import SwiftUI

public class LogData: ObservableObject {
  
  @Published var logLines = [Line]()
  @Published var reload = false {
    didSet {
      if reload { loadLines() ; reload = false }
    }
  }
  @Published var filter = (id: 0, state: false) {
    didSet {
      // setBandButtons(buttonTag: filter.id, state: filter.state)
      //print( filter.id)
    }
  }
  
  init() {
    
    let appFolder = FileManager.appFolder(for: "net.k3tzr.xsdr6000/Logs")
    let logUrl = appFolder.appendingPathComponent("xSDR6000.log")
    
    let fileManager = FileManager()
    if fileManager.fileExists( atPath: logUrl.path ) {
      readLog(url: logUrl)
    }
  }
  
  
  
  func loadLines() {
    
    // allow the user to select a Log file
    let openPanel = NSOpenPanel()
    openPanel.canChooseFiles = true
    openPanel.canChooseDirectories = false
    openPanel.allowsMultipleSelection = false
    openPanel.allowedFileTypes = ["log"]
    openPanel.directoryURL = FileManager.appFolder(for: "net.k3tzr.xsdr6000/Logs")
    
    if openPanel.runModal() == NSApplication.ModalResponse.OK {
      readLog(url: openPanel.url!)
    }
  }

  func readLog(url: URL) {
    var lines = [Line]()

    let logString = try! String(contentsOf: url, encoding: .ascii)
    
    let texts = logString.components(separatedBy: "\n")
    for (i, lineText) in texts.enumerated() {
      lines.append(Line(id: i, text: lineText ))
    }
    logLines = lines
  }
}
